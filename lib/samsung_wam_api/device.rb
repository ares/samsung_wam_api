require 'uri'
require 'net/http'
require 'active_support/core_ext/hash/conversions'
require 'logger'
require 'timeout'

module SamsungWamApi
  class Device
    def initialize(ip:, port: '55001', endpoint: 'UIC', logger: Logger.new(STDOUT), timeout_seconds: 3)
      @ip = ip
      @port = port
      @endpoint = endpoint
      @logger = logger
      @timeout_seconds = timeout_seconds
    end

    # returns '1' (on) or '0' (off)
    def power_status
      command!('<name>GetPowerStatus</name>')['powerStatus'].to_i
    end

    def on?
      power_status == 1
    end

    def off?
      power_status == 0
    end

    def on!
      command!('<name>SetPowerStatus</name><p type="dec" name="powerstatus" val="1"/>')
    end

    def off!
      command!('<name>SetPowerStatus</name><p type="dec" name="powerstatus" val="0"/>')
    end

    def volume
      command!('<name>GetVolume</name>')['volume'].to_i
    end

    def set_volume(vol)
      command!('<name>SetVolume</name><p type="dec" name="Volume" val="' + vol.to_i.to_s + '"/>')
    end

    def increase_volume(step = 1)
      set_volume(volume + step.to_i)
    end

    def decrease_volume(step = 1)
      set_volume(volume - step.to_i)
    end

    def command!(cmd)
      query = "http://#{@ip}:#{@port}/#{@endpoint}?cmd=#{URI.encode(cmd)}"
      @logger.debug { "Firing query '#{URI.decode(query)}'" }

      # if we e.g. request to power on device which is already on, we never receive a response, therefore we use configurable timeout
      raw_response = nil
      Timeout::timeout(@timeout_seconds) {
        raw_response = Net::HTTP.get(URI(query))
      }
      parsed_response = Hash.from_xml(raw_response)
      @logger.debug { "Got response:\n #{raw_response.inspect} \nparsed to:\n#{parsed_response}" }
      parsed_response[@endpoint]['response']
    rescue Timeout::Error
      @logger.warn "Timeout and #{@timeout_seconds} seconds, you most likely did invalid operation"
    end
  end
end
