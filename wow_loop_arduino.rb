require 'rubygems'
require 'arduino_firmata'
require 'nokogiri'
require 'open-uri'

doc = Nokogiri::HTML(open("https://medium.com/@rboudinot"))

arduino = ArduinoFirmata.connect  # use default arduino

count = 0

while count <= 50 do
  if doc.text.include?("test 1 2 3")
    puts "I found my article!"
    arduino.digital_write 13, true
    sleep(3)
    arduino.digital_write 13, false
    sleep(1)
    arduino.digital_write 13, true
    sleep(3)
    arduino.digital_write 13, false
    sleep(1)
    count = 0
  elsif count == 3
    sleep(1)
    puts "Still waiting"
    count = 0
  else
    arduino.digital_write 13, true
    sleep(1)
    arduino.digital_write 13, false
    sleep(1)
    arduino.digital_write 13, true
    sleep(1)
    arduino.digital_write 13, false
    sleep(1)
    arduino.digital_write 13, true
    sleep(1)
    arduino.digital_write 13, false
    sleep(1)
    arduino.digital_write 13, true
    sleep(1)
    arduino.digital_write 13, false
    sleep(1)
    arduino.digital_write 13, true
    sleep(1)
    arduino.digital_write 13, false
    sleep(1)
    count += 1
  end
end
