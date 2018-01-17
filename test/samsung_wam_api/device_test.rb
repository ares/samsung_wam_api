require 'test_helper'

module SamsungWamApi
 class DeviceTest < Minitest::Test
   def setup
     @device = Device.new(ip: '192.168.22.144', logger: Logger.new('/dev/null'))
   end

   def test_power_status_for_sleeping_device
     VCR.use_cassette 'off' do
       assert_equal '0', @device.power_status
     end
   end

   def test_power_status_for_active_device
     VCR.use_cassette 'on' do
       assert_equal '1', @device.power_status
     end
   end

   def test_on?
     VCR.use_cassette 'on' do
       assert @device.on?
     end
   end

   def test_off?
     VCR.use_cassette 'off' do
       assert @device.off?
     end
   end

   def test_turn_on
     VCR.use_cassette 'turn_on' do
       @device.on!
       assert @device.on?
     end
   end

   def test_turn_on
     VCR.use_cassette 'turn_off' do
       @device.off!
       assert @device.off?
     end
   end
 end
end
