require 'rubygems'
require 'arduino_firmata'
require 'open-uri'
require 'hurley'
require 'json'
require 'pry'

user = "jphoenix86"
repo = "melt_and_pourium"
connection = Hurley::Client.new("https://api.github.com")
connection.query[:access_token] = ENV["TOKEN"]
connection.header[:accept] = "application/vnd.github+json"

def parse(response)
  JSON.parse(response.body)
end

@pr = parse(connection.get("repos/#{user}/#{repo}/pulls")).count

arduino = ArduinoFirmata.connect

count = 0
still = 0
found = 0
light = 13
sound = 12
fetch = 8

loop do
  if @pr > 0
    found = 0
    found += 1
    puts "*****************  !!Open Pull Request!!  *********************"
    5.times do
      arduino.digital_write light, true
      sleep(0.5)
      arduino.digital_write light, false
      sleep(0.5)
    end
    5.times do
      arduino.digital_write sound, true
      sleep(0.5)
      arduino.digital_write sound, false
      sleep(0.5)
    end
    count = 0
    still = 0
    puts "making sure"
    arduino.digital_write fetch, true
    sleep(1)
    arduino.digital_write fetch, false
    sleep(1)
    @pr = parse(connection.get("repos/#{user}/#{repo}/pulls")).count
  elsif count == 3
    sleep(1)
    puts "No Open PR's"
    count = 0
    still += 1
    puts " Fetched #{still * 3} times"
  else
    if found >= 1
      puts "\nPR closed!!!\nLooking for new open pull requests!\n\n"
    end
    puts "fetching"
    arduino.digital_write fetch, true
    sleep(1)
    arduino.digital_write fetch, false
    sleep(1)
    count += 1
    @pr = parse(connection.get("repos/#{user}/#{repo}/pulls")).count
    sleep(1)
    puts "fetched! \n count = #{count} before 'Still Waiting'"
  end
end
