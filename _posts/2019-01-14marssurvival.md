---
layout: post
title: 'Riddle: Surviving on Mars'
tags: Programming
---


![martian](https://i.imgur.com/4npodS6.jpg)
{: align="middle"}
*All my makerbots are broken*
{: style="color:gray; font-size: 80%; text-align: center;"}


This is a solution attempt to a riddle originally posted on [FiveThirtyEight](https://FiveThirtyEight.com) [here](https://fivethirtyeight.com/features/in-space-no-one-can-hear-your-3d-printer-die/). I recently discovered their weekly "riddlers", and really enjoyed trying to figure this one out!

### The Premise

You are an astronaut, trying to survive on Mars until you are relieved by the next crew in 5 years time (1,825 earth days, excluding leap years).

You live in a habitation pod that has a series of critical life support components, as well as 3 3D printers to manufacture parts and additional supplies that you might need. The life support infrastructure is essential in providing you with food, water, and breathable atmosphere.

Your 3D printers help you to fabricate parts, should the life support equipment break down. They can also be used to make parts for eachother, should one of the printers break down. You cannot scavenge them for parts, as they are made by different manufacturers; thus printing is your only option. Each 3D printer can make **(1)** part per day


One part of your critical life support systems is guaranteed to fail **daily**, requiring a 3D printer to spend a day replacing said part.   

Your 3D printers have fixed probabilities to fail on a given day, requiring a new part:
- Printer 1 : 10%
- Printer 2 : 7.5%
- Printer 3 : 5%


*What is the probability that you will survive the full 1,825 days?*

### Solution attempt

There are two ways to solve this problem--theoretically or empirically. I opted for the latter because I thought it might be more interesting to brute force my way to a probability of survival by modeling the situation programatically.

I decided to structure everything around a daily cycle, under certain assumptions.

- We check whether or not the printers are functional every morning (first for loop)

- Based on the newly determined printer status, we try to fix broken printers if possible.

- We cannot pre-fabricate parts, as we are not given details on how many parts each machine contains etc.

This leaves us with two for loops, as seen in the code block below (within the while loop).

~~~py
import random
import matplotlib.pyplot as plt
import matplotlib
import numpy as np


#Probablilities

p1break = 0.1
p2break = 0.075
p3break = 0.05



#One day
def survive():

    #Printer status
    status = [1,1,1]
    #Probabilities out of 1000 to use integers
    probs = [p1break*1000, p2break*1000, p3break*1000]
    days = 0


    while True:

        #Check machine status on given day, if working
        for idx,val in enumerate(status):
            if val == 1:
                if (random.randint(1,1000) <= probs[idx]):
                    status[idx] = 0

        #If machine is broken, test if it can be fixed
        for idx,val in enumerate(status):
            if val == 0:

            #Count how many of the other machines are working
                working = 0
                for x in status:
                    working = working + x
                #No machines working, you' dead sucka
                if working == 0:
                    return days
                #2 Machines working, you can be fixed!
                if working == 2:
                    status[idx] = 1
        days = days + 1
~~~

The while loop runs the survive function until, well, you're no longer surviving. The first loop checks the status of each printer, which is previously initialised at 1. Using probabilities out of 1000 (to maintain integer values), the script calls a random number between 1-1000. If this value falls below the pre-specified probability level, the printer is considered broken and its status is set to 0.

The second loop determines what we can potentially do with any broken printers. There are 3 cases:

1. All 3 printers are broken, working == 0. You can't replace life support parts and are therefore dead. The return statement here breaks the while loop, and returns the total number of days that you survived.

2. 2 printers are broken, working == 1. Your remaining machine is dedicated to fixing life support, and cannot be used to repair the other printers. You are waiting, hoping that this lone printer will last you the 5 years. This case is not coded, because it is handled by the first loop.
3. 1 printer is broken, working == 2. You have 2 operational printers, of which one will be dedicated to life support parts, and the second can be used to restore your broken printer.

Finally, a day is added to the counter.

That's basically it!  

The following block runs the program for as many iterations as necessary to determine an appropriate survival probability, noting down the number of days survived in each instance.
In the end, it reports the average number of days survived, number of times you made it to 5 years, as well as estimated probability of survival.

~~~py
#This block runs survive() multiple times and tallies the results
count = 0
avgdays = 0
survival = 0
days = []
iterations = 100000

while(count < iterations):
    surviveddays = survive()
    avgdays = avgdays + surviveddays
    days.append(surviveddays)
    count = count + 1
    if surviveddays >= 1825:
        survival = survival + 1
print ("You survived on average %s days after %s iterations" % ((avgdays/iterations),(iterations)))
print ("Number of times survived = %s" % survival)
print ("Your survival probability is %s%%" % ((survival/iterations)*100))

~~~

I found that with 1 million iterations, I tend to survive on average just 78 days and change, nowhere close! There is however, definitely a chance to survive, given the circumstances.

~~~py

~~~




For the full code, as well as a snippet to generate a histogram, see my [github page](https://github.com/denzilly/riddles).
