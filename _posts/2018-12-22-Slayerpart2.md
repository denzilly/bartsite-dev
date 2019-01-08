---
layout: post
title: 'Slaying the Top 2000 Part 2: Names and Emails'
tags: [slayer]
---

Welcome back to this short write-up of the top2000 Slayer voter! In this installment, we will look more closely at the part of the script that generates random names and email addresses.

## Name Generator

The next step in the voting procedure asks for some personal information-- a name and email address. Fortunately, neither are used for any sort of verification, but I still thought it a good idea to at least use a somewhat realistic naming scheme for my legion of metal-heads.

In order to do this, I decided to select first and last names at random from an online database of the 10,000 most common Dutch names.

~~~py
#The following funciton creates a random dutch name from the list of top 10000 first and last names
def namegenerator():

    #Make sure working directory is script location
    abspath = os.path.abspath(__file__)
    dname = os.path.dirname(abspath)
    os.chdir(dname)


    #Choose random row from first and lastname csvs
    firstnum = randint(1,9500)
    lastnum = randint(1,9500)
    def nameget(index, filename):
        with open(filename) as csv_file:
            csv_reader = csv.reader(csv_file, delimiter=',')
            rows = [row[0] for idx, row in enumerate(csv_reader) if idx in(index, index)]

            return rows


    #Concatenate into a "full name"
    full_name = nameget(firstnum,'voornamen.csv')[0] + " " + nameget(lastnum,'achternamen.csv')[0]

    print("Your name is: " + full_name)

    return full_name
~~~
