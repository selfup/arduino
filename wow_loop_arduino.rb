require 'rubygems'
require 'arduino_firmata'
require 'nokogiri'
require 'open-uri'
require 'pry'
 
@doc = Nokogiri::HTML(open("http://selfup.me"))
 
arduino = ArduinoFirmata.connect
 
count = 0
 
while count <= 50 do
    if @doc.text.include?("Chris")                 
    puts "I found Chris!"
    arduino.digital_write 13, true
    sleep(10)
    arduino.digital_write 13, false
    sleep(5)
    arduino.digital_write 13, true
    sleep(5)
    arduino.digital_write 13, false
    sleep(5)
    arduino.digital_write 13, true
    sleep(5)
    arduino.digital_write 13, false
    sleep(15)
    count = 0
    @doc = Nokogiri::HTML(open("http://selfup.me"))
  elsif count == 3
    sleep(5)
    puts "Still waiting"
    count = 0
  else
    sleep(30)                      
    arduino.digital_write 13, true
    sleep(0.2)
    arduino.digital_write 13, false
    sleep(0.2)
    arduino.digital_write 13, true
    sleep(0.2)
    arduino.digital_write 13, false
    sleep(0.2)
    arduino.digital_write 13, true
    sleep(0.2)
    arduino.digital_write 13, false
    sleep(0.2)
    arduino.digital_write 13, true
    sleep(0.2)
    arduino.digital_write 13, false
    sleep(0.2)
    arduino.digital_write 13, true
    sleep(0.2)
    arduino.digital_write 13, false
    sleep(0.2)
    count += 1
    @doc = Nokogiri::HTML(open("http://selfup.me"))
    sleep(5)
  end
end
