require_relative 'sequence'
require 'rubygems'
require 'arduino_firmata'
require 'open-uri'
require 'hurley'
require 'json'
require 'pry'

include Sequence

user = "jphoenix86"
repo = "melt_and_pourium"

connection = Hurley::Client.new("https://api.github.com")
connection.query[:access_token] = ENV["TOKEN"]
connection.header[:accept] = "application/vnd.github+json"

def parse(response)
  JSON.parse(response.body)
end

@pr = parse(connection.get("repos/#{user}/#{repo}/pulls")).count

count = 0

arduino = ArduinoFirmata.connect

loop do
  if @pr > 0
    puts "*****************  !!Open Pull Request!!  *********************"
    sleep(1)
    dit(arduino)
    dah(arduino)
    dit(arduino)
    sleep(1)
    count = 0
    still = 0
    puts "Making sure."
    arduino.digital_write 8, true
    sleep(1)
    arduino.digital_write 8, false
    sleep(1)
    @pr = parse(connection.get("repos/#{user}/#{repo}/pulls")).count
  else
    puts "Fetching."
    arduino.digital_write 8, true
    sleep(1)
    arduino.digital_write 8, false
    sleep(1)
    count += 1
    @pr = parse(connection.get("repos/#{user}/#{repo}/pulls")).count
    sleep(1)
    puts "Fetched! \n Count = #{count}"
  end
end
