
## Basic Algorithm:
- Get a sequence of tweets by Trump:
    - for each tweet, search for retweeters:
        - for each retweeter, filter and collect tweets from his timeline
        - add entry to python dictionary
- Clean JSON format in dictionary and convert into csv
- Steam the process for updates and realtime twitter scraping

### 1. Fetch the sequence of tweets by Trump

- Tweets are specified by the tweet ID (statusid) and can only be selected
- We can either include all his tweets, or manually select those we are interested in to focus on, according to their content
- Problem: Due to limited storage space of our machine, we can only look at several of his tweets, where sample bias is inevitable


```python
def GetRetweets(self,
                    statusid,
                    count=None,
                    trim_user=False):
        """
            Returns up to 100 of the first retweets of the tweet identified
        by statusid
        Args:
          statusid (int):
            The ID of the tweet for which retweets should be searched for
          count (int, optional):
            The number of status messages to retrieve.
          trim_user (bool, optional):
            If True the returned payload will only contain the user IDs,
            otherwise the payload will contain the full user data item.
        Returns:
          A list of twitter.Status instances, which are retweets of statusid
        """
    
        url = '%s/statuses/retweets/%s.json' % (self.base_url, statusid)
        parameters = {
            'trim_user': enf_type('trim_user', bool, trim_user),
        }

        if count:
            parameters['count'] = enf_type('count', int, count)

        resp = self._RequestUrl(url, 'GET', data=parameters)
        data = self._ParseAndCheckTwitter(resp.content.decode('utf-8'))

        return [Status.NewFromJsonDict(s) for s in data]

```

### 2. For each tweet ID, search for users who retweeted this tweet:
- Retweets are specified by their statusid in place of time, user ID are collected if their retweet statusid is larger than a -statusid of a certain retweet (this we can manually determine)
- Problems:
    - The maximun amount of IDs we can get is 100
    - The maximun request for getting retweeter's ID is 75/15-min/window
    - (See <a href = "https://dev.twitter.com/rest/reference/get/statuses/retweeters/ids">reference documentation</a> for relevant limitations)


```python
  def GetRetweeters(self,
                      status_id,
                      cursor=None,
                      count=100,
                      stringify_ids=False):
        """Returns a collection of up to 100 user IDs belonging to users who have
        retweeted the tweet specified by the status_id parameter.
        Args:
          status_id:
            the tweet's numerical ID
          cursor:
            breaks the ids into pages of no more than 100.
          stringify_ids:
            returns the IDs as unicode strings. [Optional]
        Returns:
          A list of user IDs
        """
        url = '%s/statuses/retweeters/ids.json' % (self.base_url)
        parameters = {
            'id': enf_type('id', int, status_id),
            'stringify_ids': enf_type('stringify_ids', bool, stringify_ids)
        }

        result = []

        total_count = 0
        while True:
            if cursor:
                try:
                    parameters['count'] = int(cursor)
                except ValueError:
                    raise TwitterError({'message': "cursor must be an integer"})
            resp = self._RequestUrl(url, 'GET', data=parameters)
            data = self._ParseAndCheckTwitter(resp.content.decode('utf-8'))
            result += [x for x in data['ids']]
            if 'next_cursor' in data:
                if data['next_cursor'] == 0 or data['next_cursor'] == data['previous_cursor']:
                    break
                else:
                    cursor = data['next_cursor']
                    total_count -= len(data['ids'])
                    if total_count < 1:
                        break
            else:
                break

        return result

```

Can get user information along the way


```python
"""
Use Twitter API to grab user information from list of organizations; 
export text file
Uses Twython module to access Twitter API
"""

import sys
import string
import simplejson
from twython import Twython

#WE WILL USE THE VARIABLES DAY, MONTH, AND YEAR FOR OUR OUTPUT FILE NAME
import datetime
now = datetime.datetime.now()
day=int(now.day)
month=int(now.month)
year=int(now.year)
   
#REPLACE WITH YOUR LIST OF TWITTER USER IDS
ids = "4816,9715012,13023422, 13393052,  14226882,  14235041, 14292458, 14335586, 14730894,\
    15029174, 15474846, 15634728, 15689319, 15782399, 15946841, 16116519, 16148677, 16223542,\
    16315120, 16566133, 16686673, 16801671, 41900627, 42645839, 42731742, 44157002, 44988185,\
    48073289, 48827616, 49702654, 50310311, 50361094,"

#ACCESS THE LOOKUP_USER METHOD OF THE TWITTER API -- GRAB INFO ON UP TO 100 IDS WITH EACH API CALL
#THE VARIABLE USERS IS A JSON FILE WITH DATA ON THE 32 TWITTER USERS LISTED ABOVE
users = t.lookup_user(user_id = ids)

#NAME OUR OUTPUT FILE - %i WILL BE REPLACED BY CURRENT MONTH, DAY, AND YEAR
outfn = "twitter_user_data_%i.%i.%i.txt" % (now.month, now.day, now.year)

#NAMES FOR HEADER ROW IN OUTPUT FILE
fields = "id screen_name name created_at url followers_count friends_count statuses_count \
    favourites_count listed_count \
    contributors_enabled description protected location lang expanded_url".split()

#INITIALIZE OUTPUT FILE AND WRITE HEADER ROW   
outfp = open(outfn, "w")
outfp.write(string.join(fields, "\t") + "\n")  # header

#THE VARIABLE 'USERS' CONTAINS INFORMATION OF THE 32 TWITTER USER IDS LISTED ABOVE
#THIS BLOCK WILL LOOP OVER EACH OF THESE IDS, CREATE VARIABLES, AND OUTPUT TO FILE
for entry in users:
    #CREATE EMPTY DICTIONARY
    r = {}
    for f in fields:
        r[f] = ""
    #ASSIGN VALUE OF 'ID' FIELD IN JSON TO 'ID' FIELD IN OUR DICTIONARY
    r['id'] = entry['id']
    #SAME WITH 'SCREEN_NAME' HERE, AND FOR REST OF THE VARIABLES
    r['screen_name'] = entry['screen_name']
    r['name'] = entry['name']
    r['created_at'] = entry['created_at']
    r['url'] = entry['url']
    r['followers_count'] = entry['followers_count']
    r['friends_count'] = entry['friends_count']
    r['statuses_count'] = entry['statuses_count']
    r['favourites_count'] = entry['favourites_count']
    r['listed_count'] = entry['listed_count']
    r['contributors_enabled'] = entry['contributors_enabled']
    r['description'] = entry['description']
    r['protected'] = entry['protected']
    r['location'] = entry['location']
    r['lang'] = entry['lang']
    #NOT EVERY ID WILL HAVE A 'URL' KEY, SO CHECK FOR ITS EXISTENCE WITH IF CLAUSE
    if 'url' in entry['entities']:
        r['expanded_url'] = entry['entities']['url']['urls'][0]['expanded_url']
    else:
        r['expanded_url'] = ''
    print(r)
    #CREATE EMPTY LIST
    lst = []
    #ADD DATA FOR EACH VARIABLE
    for f in fields:
        lst.append(unicode(r[f]).replace("\/", "/"))
    #WRITE ROW WITH DATA IN LIST
    outfp.write(string.join(lst, "\t").encode("utf-8") + "\n")

outfp.close()    
```


    ---------------------------------------------------------------------------

    ImportError                               Traceback (most recent call last)

    <ipython-input-9-b5c2c06b0ca4> in <module>()
          9 import sys
         10 import string
    ---> 11 import simplejson
         12 from twython import Twython
         13 
    

    ImportError: No module named 'simplejson'


### 3. For each retweeter, filter and collect tweets from his timeline
- For each retweeter ID, search for his/her tweets on timeline and filter to only include the retweets of the Trump tweet that we are interested
- The filter can be achieved using *tweepy* library by specifying `twitterStream.filter(follow = ["statusid"]` or check for substring 'RT@'

### 4. Clean the JSON output and use pandas to create csv output
- Problem: This is a time-consuming process which will take up most of the time we can otherwise use to get better insights from our data

### 5. Stream the process
<a herf = "http://rawkes.com/articles/how-i-scraped-and-stored-over-3-million-tweets">Storage options<a/>


```python
from tweepy import Stream
from tweepy.streaming import StreamListener
 
class MyListener(StreamListener):
 
    def on_data(self, data):
        try:
            with open('python.json', 'a') as f:
                f.write(data)
                return True
        except BaseException as e:
            print(&quot;Error on_data: %s&quot; % str(e))
        return True
 
    def on_error(self, status):
        print(status)
        return True
 
twitter_stream = Stream(auth, MyListener())
twitter_stream.filter(track=['#python'])
```
