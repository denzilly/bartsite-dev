---
layout: post
title: 'Slaying the Top 2000 Part 2: Names and Emails'
tags: [slayer]
---

Welcome back to this short write-up of the top2000 Slayer voter! In this installment, we will look more closely at the part of the script that generates random names and email addresses.

## Name Generator

The next step in the voting procedure asks for some personal information-- a name and email address. Fortunately, neither are used for any sort of verification, but I still thought it a good idea to at least use a somewhat realistic naming scheme for my legion of autonomous metal-heads.

In order to do this, I decided to select first and last names at random from an online database of the 10,000 most common Dutch names. These were scraped into two csv files, *voornamen* and *acthernamen*, respectively.

What follows is a simple block of code that chooses two random integers, which are used to call a row from either csv file, representing a first and last name.

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


## Email Generator

The final piece of information needed is a disposable email address--fortunately, *10minutemail* provides an excellent service that does exactly as its name suggests. The block of code below uses the requests and BeautifulSoup packages to request an instance of the *10minutemail* website, and scrape the HTML element containing only the email address. This is subsequently returned as a string.

~~~py
##########Email Generator###############

def getmail():
    r = requests.get("https://www.10minutemail.com", timeout=5)

    pc = BeautifulSoup(r.content, "html.parser")

    email = pc.find("input", {"id": "mailAddress"}).get('value')

    return email
~~~

## Sending Name and Email Input

Now that we have a "real" sounding Dutch name, as well as a disposable email address, we can send the relevant inputs to the voting site. The block of code below is from the main *vote* function that was referenced in the first part of this write-up, and operates in much the same way. It finds the relevant input field's XPATH, and subsequently enters the required information as generated through our generator functions.


~~~py
#Song selection is now complete. We now need to fill in name/email and submit the vote

  #Click through to next pages
  time.sleep(wts)
  driver.find_element_by_xpath(songnext).click()
  time.sleep(wtl)
  driver.find_element_by_xpath(motiveernext).click()
  time.sleep(wtl)


  #Call name generator to enter a random name, call email generator for disposable mail
  driver.find_element_by_xpath(name).send_keys(namegenerator())
  time.sleep(wts)
  driver.find_element_by_xpath(email).send_keys(getmail())
  time.sleep(wts)


  driver.execute_script("window.scrollTo(0, document.body.scrollHeight)")
  time.sleep(wts)
  #accept terms and conditions
  driver.find_element_by_xpath(tandc).click()
~~~

## Now What?

We have sent through our song choices and entered the requested personal information to vote, what could possibly be left? As you would expect from such a reputable institution, there is a final familiar layer of protection to would-be spammers--the dreaded reCAPTCHA. To be fair--this is where the project stalled (read: crashed and burned), but if you are interested in potential subversion strategies and theories, read on to part 3.
