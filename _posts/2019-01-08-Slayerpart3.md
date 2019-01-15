---
layout: post
title: 'Slaying the Top 2000 Part 3: reCAPTCHA'
tags: Programming Music
---

![RIP](https://i.imgur.com/z3iEySE.jpg)
{: align="middle"}
*All hope is lost.*
{: style="color:gray; font-size: 80%; text-align: center;"}

Unfortunately, this is where the project came to an end. Google's secret weapon was too much to handle, an insurmountable obstacle. Crafted in the heart of mount Fuji by evil samurai programmers, reCAPTCHA is actually a pretty neat piece of technology, and more advanced than you would think. This post will cover a little bit of how CAPTCHA works, as well as a possible workaround.

The most modern iteration of CAPTCHA has a wide array of tools to detect whether or not the user is an actual human (of which not all are known, as far as I'm aware.) It looks at things like how you move your mouse, or how you type, but also your cached browsing history/cookies to see if you have been acting "human" on the internet (browsing social media, reading the news, researching black market kidney prices).

Without more advanced methods, bots usually type out letters in perfect time increments, or move the mouse to a certain location at a perfectly constant speed and in a linear direction. For a human, it would be impossible to type out a word with exact 10ms increments between keystrokes, or navigate a mouse in a perfectly straight line.   

The humorously morbid picture above displays the old version of reCAPTCHA, with the distorted letters--these are obselete, since they can be solved automatically with around 99.8% accuracy. You will recognize the new version as looking something like this.


![Captchaexample](https://i.imgur.com/zOzcQgq.jpg)
{: align="middle"}
Modern reCAPTCHA
{: style="color:gray; font-size: 80%; text-align: center;"}

The unchecked box on the upper left is what everyone sees before attempting to solve a CAPTCHA. When you attempt to click it, one of two things will happen:

- If CAPTCHA has seen into your past, and determined that your behavious was "human" enough, you might be lucky enough to get a checkmark straight away, without needing to solve a puzzle.

- If CAPTCHA doesn't know you well, or thinks you are behaving like a bot, it will ask you to identify some  objects from random google maps photos. This puzzle is very difficult to solve automatically, since it would require genuine image recognition (seeing as how the pictures are taken from streetview, and not stored anywhere else online).

Given this foolproof detection system, surely this is a bust?

![slayerfan](https://i.imgur.com/HfhUyEr.jpg)
{: align="middle"}
A typical Slayer fan, deep in thought.
{: style="color:gray; font-size: 80%; text-align: center;"}

## Speech-to-Text Solver

The industrious people who keep themselves busy with this sort of thing are remarkably crafty, and always coming up with new and innovative solutions to spoof bot-detection systems. One such system, that I didn't have the time to test, but would love to give a shot sometime in the future, involves taking advantage of the visually impaired assistance offered with the image recognition puzzle.

Note the little headphones icon at the bottom of the image recognition puzzle--this allows for visually impaired individuals to complete a speech-to-text puzzle instead, typing out an audio phrase that your computer spits out.

![Audiocaptcha](https://i.imgur.com/GTEyQoD.png)
{:.lead width="100px" align="middle"}
Audio solve
{: style="color:gray; font-size: 80%; text-align: center;"}

The workaround, based on [this](https://www.reddit.com/r/Python/comments/8oqp7v/hey_i_made_a_google_recaptcha_solver_bot_too/) reddit post, involves automatically downloading the mp3 file of the audio, running it through a speech-to-text API (such as IBM's Watson s-t-t tool), and regurgitating the appropriate text.

Unfortunately, it's not as simple as it sounds--if CAPTCHA doesn't believe your actions to have been human, it will reject your request to listen to the audio. You need to first convince it that your recent behaviour is human-like before you can even request to solve it this way. It would be interesting to test this to see if this still works, that being said, word on the street is that the Google-ites are hard at work on the latest version of CAPTCHA that will bring all botters to their knees!

## Conclusion

All in all, this was a neat project to get back into python, as well as learn a little bit about how bot detection works. Even though this was a completely hypothetical application, I'm sure that the Selenium methods used here could be very useful for other applications where browser automation is required.

As for Slayer being more prominent in the top 2000, perhaps we should start a political movement instead. Alternatively, we could start some commercial movement in a Bangladeshi click-farm?

Until next year!
