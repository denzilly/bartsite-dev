---
layout: post
title: 'Riddle: Three Deck Monté'
tags: Programming
---


![three-card-monte](https://i.imgur.com/37bNTq2.jpg)
{: align="middle"}
*Never trust a man in a tracksuit.*
{: style="color: gray; font-size: 80%; text-align: center;"}
This is another solution attempt to a riddle originally posted on [FiveThirtyEight](https://FiveThirtyEight.com) [here](https://fivethirtyeight.com/features/can-you-escape-a-maze-without-walls/). This time, about a three-*deck*-monte problem. Image credits to the painter of the above work, [Max Ginsburg](http://www.maxginsburg.com/) who does some excellent job of capturing life in New York City over the course of the last decades.

### The Premise

We are trying to figure out the odds that we'll win against a crafty hustler, who, for the sake of convenience, we are going to name Monté.

Monte is taking bets at his upturned microwave box, for a little game he has designated three-deck-monte. It goes as follows:

- There are 3 decks of cards, each with 12 cards.
- The 12 cards are split into 3 sets of 4 with the same value.
- The player chooses a deck first, upon which Monté will choose a deck.
- Thus commences the game, similar to *war*:
  - Each player draws a card at random from his/her deck.
  - Player who draws the highest card (ace-high) gets a point.
  - First player to 5 wins, takes home the presidents.


The decks are:

- Red Deck: 4 Aces, 4 Nines, 4 Sevens
- Blue Deck: 4 Kings, 4 Jacks, 4 Sixes
- Black Deck: 4 Queens, 4 Tens, 4 Eights


### Setting up the problem

There are a key elements of this problem to break down, and that end up drastically shifting the favour in Monté's direction.

#### All decks are not equal

Each draw of two cards has 9 possible outcomes. The fact that this total is odd, implies that the chance of success is always stacked in one player's favor.
Tabulating possible outcomes reveals that the decks are selected very specifically, such that we end up with a sort-of  "rock-paper-scissors" hierarchy between the decks.

Each card is capable of being superior to either 0, 1, 2, or 3 of the possible cards drawn from the opponent's chosen deck. Adding these up reveals the relative matchup in terms of probability of success on the first draw. The chart below shows potential matchups based on deck choices. It is quickly apparent that certain deck choices (responses from Monté), are better than others, and that there is a clear best response deck to each deck chosen by the player. These are outlined in red (note that W/L is from the player's perspective, so it is in Monté's interest to have more Ls).

![Best-Responses](https://i.imgur.com/wrCC2B6.png)
{: align="middle"}
Monté's best responses highlighted to each deck choice are outlined in red. W/L is shown from Player's perspective.


### Solution attempt

Similar to riddles we've solved in the past, this solution attempt is based around simply simulating the game a significant number of times in order to estimate the chance that one player will win.

At 1 million iterations, we estimate the player to win 298027 times. We thus estimate the victory probability to be $$29.8027% +/- 0.00118$$  with a 99% confidence interval.

![Win-Probability](https://i.imgur.com/t0skFB5.png)
{: align="middle"}
Estimating the probability of victory.

Indeed, as theorised, the odds are stacked heavily in Monté's favour! According to an additional update from the original riddle page, the true odds of player victory are exactly $$541/1815 = .29807%$$! It seems that our simulation was a success. 

For the full code, as well as a snippet to generate the graph, see my [github page](https://github.com/denzilly/riddles).
