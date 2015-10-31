require 'rubygems'
require 'arduino_firmata'
require 'open-uri'
require 'hurley'
require 'json'
require 'pry'

user = "selfup"
repo = "arduino"
connection = Hurley::Client.new("https://api.github.com")
connection.query[:access_token] = ENV["TOKEN"]
connection.header[:accept] = "application/vnd.github+json"

def parse(response)
  JSON.parse(response.body)
end

# testing

@pr = parse(connection.get("repos/#{user}/#{repo}/pulls")).count

arduino = ArduinoFirmata.connect

count = 0
still = 0
found = 0

# testing github le hub

while count <= 50 do
  if @pr > 0
    found = 0
    found += 1
    puts "*****************  !!Open Pull Request!!  *********************"
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
    sleep(0.5)
    arduino.digital_write 12, false
    sleep(0.5)
    arduino.digital_write 12, true
    sleep(0.5)
    arduino.digital_write 12, false
    sleep(0.5)
    arduino.digital_write 12, true
    sleep(0.5)
    arduino.digital_write 12, false
    sleep(1)
    count = 0
    still = 0
    puts "making sure"
    @pr = parse(connection.get("repos/#{user}/#{repo}/pulls")).count
  elsif count == 3
    sleep(1)
    puts "Still waiting"
    count = 0
    still += 1
    puts " This many times...#{still}"
  else
    if found >= 1
      puts "\nPR closed!!!\nLooking for new open pull requests!\n\n"
    end
    arduino.digital_write 13, true
    sleep(4)
    arduino.digital_write 13, false
    sleep(4)
    puts "fetching"
    sleep(1)
    count += 1
    @pr = parse(connection.get("repos/#{user}/#{repo}/pulls")).count
    sleep(1)
    puts "fetched! \n count = #{count} before 'Still Waiting'"
  end
end
