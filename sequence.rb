module Sequence

  def dit(arduino)
    3.times do
      arduino.digital_write 13, true
      arduino.analog_write 11, 2
      sleep(0.2)
      arduino.analog_write 11, 0
      arduino.digital_write 13, false
      sleep(0.2)
    end
  end

  def dah(arduino)
    3.times do
      arduino.digital_write 13, true
      arduino.analog_write 11, 2
      sleep(0.6)
      arduino.analog_write 11, 0
      arduino.digital_write 13, false
      sleep(0.2)
    end
  end
  
end
