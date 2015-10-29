require 'rubygems'
require 'arduino_firmata'
require 'nokogiri'
require 'open-uri'
require 'pry'

@doc = Nokogiri::HTML(open("http://example.com"))

arduino = ArduinoFirmata.connect

count = 0
still = 0
found = 0

# testing github le hub

while count <= 50 do
  if @doc.text.include?("Chris")
    found = 0
    found += 1
    puts "*****************  I found Chris!  *********************"
    arduino.digital_write 13, true
    sleep(0.5)
    arduino.digital_write 13, false
    sleep(0.5)
    arduino.digital_write 13, true
    sleep(0.5)
    arduino.digital_write 13, false
    sleep(0.5)
    arduino.digital_write 13, true
    sleep(0.5)
    arduino.digital_write 13, false
    sleep(0.5)
    arduino.digital_write 13, true
    sleep(0.5)
    arduino.digital_write 13, false
    sleep(0.5)
    arduino.digital_write 12, true
    sleep(1)
    arduino.digital_write 12, false
    sleep(0.5)
    arduino.digital_write 12, true
    sleep(1)
    arduino.digital_write 12, false
    sleep(0.5)
    arduino.digital_write 12, true
    sleep(1)
    arduino.digital_write 12, false
    sleep(10)
    count = 0
    still = 0
    puts "making sure"
    @doc = Nokogiri::HTML(open("http://example.com"))
  elsif count == 3
    sleep(5)
    puts "Still waiting"
    count = 0
    still += 1
    puts " This many times...#{still}"
  else
    if found >= 1
      puts "\nI lost him!!!\nStill Looking for him!\n\n"
    end
    arduino.digital_write 13, true
    sleep(4)
    arduino.digital_write 13, false
    sleep(4)
    arduino.digital_write 13, true
    sleep(4)
    arduino.digital_write 13, false
    sleep(4)
    arduino.digital_write 13, true
    sleep(4)
    arduino.digital_write 13, false
    sleep(4)
    arduino.digital_write 13, true
    sleep(4)
    arduino.digital_write 13, false
    sleep(4)
    arduino.digital_write 13, true
    sleep(4)
    arduino.digital_write 13, false
    sleep(4)
    arduino.digital_write 13, true
    sleep(1)
    arduino.digital_write 13, false
    sleep(1)
    arduino.digital_write 13, true
    sleep(1)
    arduino.digital_write 13, false
    puts "fetching"
    sleep(1)
    count += 1
    @doc = Nokogiri::HTML(open("http://example.com"))
    sleep(1)
    puts "fetched! \n count = #{count} before 'Still Waiting'"
    sleep(5)
  end
end
