require 'test_helper'

module SamsungWamApi
 class DeviceTest < Minitest::Test
   def setup
     @device = Device.new(ip: '192.168.22.144', logger: Logger.new('/dev/null'))
   end

   def test_power_status_for_sleeping_device
     VCR.use_cassette 'off' do
       assert_equal 0, @device.power_status
     end
   end

   def test_power_status_for_active_device
     VCR.use_cassette 'on' do
       assert_equal 1, @device.power_status
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

   def test_volume
     VCR.use_cassette 'get_volume' do
       assert_equal 16, @device.volume
     end
   end

   def test_set_volume
     VCR.use_cassette 'set_volume' do
       assert_equal 16, @device.volume
       @device.set_volume(20)
       assert_equal 20, @device.volume
     end
   end

   def test_incerease_volume
     VCR.use_cassette 'increase_volume' do
       assert_equal 20, @device.volume
       @device.increase_volume
       assert_equal 21, @device.volume
       @device.increase_volume 4
       assert_equal 25, @device.volume
     end
   end

   def test_incerease_volume
     VCR.use_cassette 'decrease_volume' do
       assert_equal 25, @device.volume
       @device.decrease_volume
       assert_equal 24, @device.volume
       @device.decrease_volume 4
       assert_equal 20, @device.volume
     end
   end

   def test_mute_features
     VCR.use_cassette 'unmuted' do
       refute @device.muted?
       @device.mute!
       assert @device.muted?
       @device.unmute!
       refute @device.muted?
       @device.toggle_mute!
       assert @device.muted?
       @device.toggle_mute!
       refute @device.muted?
     end
   end

   def test_inputs_changing
     VCR.use_cassette 'inputs' do
       assert_equal 'aux', @device.input
       @device.set_input!('wifi')
       assert_equal 'wifi', @device.input
       @device.set_input!('bt')
       assert_equal 'bt', @device.input
       sleep 5 # starting BT takes a sec, it ignores set_input meanwhile
       @device.set_input!('aux')
       assert_equal 'aux', @device.input
     end
     refute @device.set_input!('whatever')
   end

   def test_cloud_prodiver_info
     VCR.use_cassette 'cloud_playing' do
       assert_equal 'Spotify', @device.cloud_provider_info['cpname']
       assert_equal 'tester', @device.cloud_username
       assert_equal "For What It's Worth", @device.audio_info['title']
       assert_equal 'play', @device.play_info
     end
   end

   def test_cloud_disconnected
     VCR.use_cassette 'cloud_disconnected' do
       assert_equal 'Spotify', @device.cloud_provider_info['cpname']
       assert_nil @device.cloud_username
       assert_nil @device.audio_info
       assert_nil @device.play_info
     end
   end
 end
end
