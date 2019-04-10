---
layout: post
title: 'Raspberry Pi Nerf Target - Part 1: Hit-Detection'
tags: Programming Raspberry DIY
---

<div style="width: 100%; height: 0px; position: relative; padding-bottom: 56.250%;"><iframe src="https://streamable.com/s/awobp/meuzbi" frameborder="0" width="100%" height="100%" allowfullscreen style="width: 100%; height: 100%; position: absolute;"></iframe></div>

{: align="middle"}
*Something something clint eastwood*
{: style="color: gray; font-size: 80%; text-align: center;"}

As a notorious impulse buyer, I need to periodically satisfy my urges by throwing some money at senseless gadgets. Rather than approach the subject with any sort of trepidation whatsoever, I try instead to keep the financial damage to a minimum by sticking to the dollar store, or everyone's favourite Chinese megacorporation, Alibaba. Enter, my latest acquisition:

![Gun](https://i.imgur.com/CXAVxRG.jpg)
{: align="middle"}
*Thanks, (Jack) Ma'!*
{: style="color: gray; font-size: 80%; text-align: center;"}

Now, I'm not much of a gun fanatic at all, but I do love a good skills challenge, and quickly ran out of things to shoot in my apartment. Having overcome my apartment's most threatening nemesis, *crack between ceiling and lamp*, I knew I needed to up the ante.



<div class="col-sm-2" style="width: 50%; margin-left: auto; margin-right: auto;">
    <img src="https://i.imgur.com/J6BqPQf.jpg" alt="lamp">
</div>
*You may not like it, but this is what peak marksmanship looks like.*
{: style="color: gray; font-size: 80%; text-align: center;"}

 Simultaneously, this seemed like the perfect opportunity to put my Raspberry Pi to work, seeing as how it was gathering dust at an alarming rate.

### The PiTarget™

Using the rail salvaged from an old printer I had lying around, as well as the side of a vinyl delivery box, the protoype of the PiTarget was born.

The concept is simple, it's a moving target with hit-detection for the foam darts shot out by my nerf-like rifle.


I hope however, to integrate some more interesting concepts along the way to use it as a way to learn more about working with microcontrollers. The project will develop over 3 phases, each with a clear end goal.

1. **Hit Detection**: Get the target to register hits from all ranges, returning this information to the player by activating an LED and playing a sound.

2. **Moving Target**: Get the target to move on its rail, either erratically or on a set path, depending on mode selection.

3. **Cheat Mode**: Using a Pi-camera, enable motion detection so that the target follows the direction in which the gun is aiming, guaranteeing a 100% hit (on the x-plane).


The reason why making the target move is a step in itself, is that the motor I have is rather big, and requires a little bit of extra work to get going. As it draws about 3A, I can't power it straight through the Pi and need to build an H-bridge with some beefy transistors.

### Physical Assembly

The principle behind the target is quite simple, and uses a flat piece of material (in this iteration, cardboard) as the contact surface. Upon contact, it hinges back and presses in a button, and subsequently bends back to its initial state. Cardboard is an excellent material to start with since it has some natural elasticity when you bend it. All I had to do to keep it in line with the button-board was tie a piece of string  to keep it in place. Once I've worked out all of the kinks, I plan to 3D print out my own little carriage to spec.

![Assembly](https://i.imgur.com/nwXVksD.jpg)
{: align="middle"}

The hit is registered through the button, which is pressed down when the first piece of card is hit with enough force. It is possible to strike the target anywhere except for the very bottom (approx 1cm), and the button will register a hit.

Mounted to the side of the target are 3 LEDs, which light up one by one as the target is struck. These are wired in parallel, and each have a 100ohm current limiting resistor.

### Wiring

![schematic](https://i.imgur.com/INHblpp.png)
{: align="middle"}

The wiring is done as follows, and is very simple. Each of the LEDs is preceded by a 100ohm resistor, and goes to one of the Pi's GPIO pins--same goes for the button. A python script then allows us to send a signal from either of the pins to the LED, each time the button is pressed.


### Software

We need some software to make sense of what exactly is supposed to happen here. The core consists of a while loop that waits for the button to be pressed, and then adds a point when this happens, as well as play a sound. When the button has been hit 3 times, the game is over and the LEDs perform a celebratory display. The enclosed comments provide details as to what is happening at each step.


~~~py
import RPi.GPIO as GPIO
import time
import pygame


# Initialise Pi IO Pins
GPIO.setmode(GPIO.BCM)

#Button pin
GPIO.setup(12, GPIO.IN, pull_up_down=GPIO.PUD_UP)

#LED Pins
lights = [21, 20, 16]
for x in lights:
    GPIO.setup(x, GPIO.OUT)

#Wait parameter, set to 5ms
wts = .05
count = 1

#Load audio files
pygame.init()
pygame.mixer.init()
hitsound = pygame.mixer.Sound('ding2.wav')
winsound = pygame.mixer.Sound('rocky.wav')




while True:
    button_state = GPIO.input(12)

    #if button gets pressed, do this
    if button_state == False:
        #turn on one additional LED
        for x in range(count):
            GPIO.output(lights[x],True)
        #Hit sound    
        hitsound.play()   
        time.sleep(0.2)
        print ("Score is: " + str(count))
        count += 1

    if count == 4:
        print("you win")
        winsound.play()   

        #celebratory LED display
        while count <= 30:

            for x in lights:
                GPIO.output(x, True)
                time.sleep(wts)
            for x in lights:
                GPIO.output(x, False)
                time.sleep(wts)
            count += 1

        GPIO.cleanup()
        break
~~~
