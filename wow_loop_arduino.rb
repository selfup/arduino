require "rubygems"
require "arduino_firmata"

arduino = ArduinoFirmata.connect  # use default arduino

count = 0

while count <= 4 do
  if count == 3
    sleep(1)
    puts "WOW"
    count = 0
  else
    arduino.digital_write 13, true
    sleep(1)
    arduino.digital_write 13, false
    sleep(1)

    count += 1
  end
end
