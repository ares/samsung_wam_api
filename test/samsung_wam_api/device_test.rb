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
 end
end
