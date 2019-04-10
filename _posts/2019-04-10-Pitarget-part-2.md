---
layout: post
title: 'Raspberry Pi Nerf Target - Part 2: Controlled Movement'
tags: Programming Raspberry DIY
---

1. [ Movement. ](#movement)
{: align="middle"}
*Something something clint eastwood*
{: style="color: gray; font-size: 80%; text-align: center;"}

Welcome to the second installment of the PiTarget's development and build. This time, we're going to take a look at making the target move from side to side, using input from a proximity sensor to decide where to go, and to make sure that it doesn't go too far and damage itself.
If you haven't read the [first installment](https://denzilly.github.io/2019/04/02/Pitarget-part-1/), you can do so to get a better idea overview of the whole project. If you're just looking to figure out the basics of the HC-SR04 proximity sensor or the L298N motor driver, then this page is all you need.

In this installment, we set up an ultrasonic proximity sensor to determine the target carriage's position, feeding this information to the pi. The pi then uses this input to determine how far to make the our printer-motor move, which is done using an L298N motor driver board.


**Goals for this installment**:
1. Create a movement system that allows the carriage to move back and forth in a way that makes the game more challenging

2. Find a way to ensure the carriage does not attempt to move beyond its bounds

3. Find a way to determine the position of the carriage relative to the rails at any given point


<a name="movement"></a>
### What kind of movement?

Obviously, we are sort of stuck with one axis of freedom--we can decide however, how we want the target's movement to behave, *on that axis*. Since this game's goal is to test actively test your marksmanship, we would like it to move around somewhat randomly, so that you can't just follow it's pattern back and forth. It also shouldn't change direction too often however, since foam darts dont travel very quickly, a mid air direction change could make the game too luck based.

Considering these constraints, we have chosen to let the target move and change direction randomly, but with a minimum distance traveled each time.

### Safely moving on the rails

Another key issue relating to movement, is ensuring that the target carriage doesn't run into the end of the rail, and try keep going. We require an effective way to ensure that the machine doesn't damage itself by trying to go beyond its bounds.

One way to more accurately control movement behaviour is through the use of a **proximity sensor**, which can allow us to determine the location of the carriage, based on its distance from a fixed point.  


![sensor](https://i.imgur.com/vMdSHIP.jpg)
{: align="middle"}
*The HC-SR04 Ultrasonic Sensor*
{: style="color: gray; font-size: 80%; text-align: center;"}

 This type of sensor measures the distance to a certain point by sending out an ultrasonic pulse, and measuring the amount of time before it bounces back. Since this is just a sound wave, we know it moves at 343ms<sup>-1</sup>, and can handily measure the distance of the bounced off object, knowing both time taken and speed travelled.  

 By attaching this sensor to the end of the rail, we can measure the carriage's distance from that end, and thus determine its position on the rail.

 That information can then in turn be used to make sure it doesn't try to derail itself, as well as determine the direction of movement. Additionally, we will use the sensor to determine the carriage's travel speed at different motor voltages, so that we know how long to tell the motor to move for each direction change. Amazingly, for a sensor costing less than €3, it has an accuracy of up to 3mm in optimal conditions at distances up to 4m.

### Motor Characteristics

The rail, carriage, and motor were all salvaged from an old printer, meaning that these parts were specifically designed or chosen to fit together. Since it fits perfectly, and we know it's specced to be able to meet the demands of moving the carriage, it makes sense to keep the motor that's already in there

Since the rail, carriage, and motor were all salvaged from the same printer, they already fit perfectly and are specced to work together.


![motor](https://i.imgur.com/NAJVQhK.jpg)
{: align="middle"}

![motorspec](https://i.imgur.com/gqS8DhV.png)
{: align="middle"}
*Mabuchi RS-555PC-3550 printer motor*
{: style="color: gray; font-size: 80%; text-align: center;"}

One small issue, it's pretty beefy for a little motor, and operates nominally at 12V and 1.3A. To deal with this, we're using a 12V-5A DC laptop power supply, that feeds directly into the motor drive board.




### Physical Assembly and Wiring

The motor is already attached to the rail, so requires no additional assembly except for wiring. The proximity sensor is mounted to the end of the rail with a small bracket and a couple of screws.

In terms of wiring, we have two additions to the circuit, one for the motor, and the other for the sensor.


![schematic](https://i.imgur.com/INHblpp.png)
{: align="middle"}

1. Sensor circuit - The sensor has 4 pins, **Ground, ECHO, TRIG, and VCC (5V)**. The ground and 5V pins speak for themselves, and are connected to the pi's 5V and GND pins respectively. TRIG and ECHO are I/O pins, connected to GPIO pins on the Pi. A pulse to TRIG activates the sensor, after which ECHO stays on high until the ultrasound burst bounces back. The amount of time that ECHO stays on high is equivalent to the travel time of the wave. **Important**: the ECHO pin returns a 5V signal, so we need a voltage divider circuit to get it back to 3.3V to avoid damaging the pi.

2. Motor circuit - In order for the motor to be able to run in either direction, we need to be able to run current through it in two directions. To achieve this we use an [H-bridge circuit](https://qph.fs.quoracdn.net/main-qimg-8037a6e7ae95016e9fa3cc8e8bdcdb46.webp), handily packed into an L298 motor driver board. This board links the powersupply, motor, and inputs from the pi. Additionally, it allows us to use pulse-width modulation to moderate the speed of the motor.

### Software

Finally, we need


~~~py

~~~
