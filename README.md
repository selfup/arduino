### Arduino with Ruby!

* Download the Arduio IDE for your OS
* Plug in your Arduino via USB
* Open the Arduino IDE, select: File > Examples > Firmata > StandardFirmata
* Connect to the correct Serial Port: Tools > Serial Port
* Click the Upload button

#### Interesting behavior with loops

If methods are created first and then called in a loop do or a while loop, the last sleep function hangs for more that the intended amount of time. Everything must be set and called within the loop. Looks like classes are going to be the best way to organize in the future.

There is a Gemfile included, just bundle and run any script!

If any additional hardware is needed there will be comments at the top of the ruby file.

Enjoy!
