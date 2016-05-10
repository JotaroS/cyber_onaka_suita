#-*- coding:utf-8 -*-
import time
from slackclient import SlackClient

token = "your token"# found at https://api.slack.com/web#authentication
sc = SlackClient(token)
if sc.rtm_connect():
    while True:
        event=sc.rtm_read()
        if not event ==[]:
            if event[0]["type"]=="message":
                    if u"きょうのおすすめは" in event[0]["text"]:
                        sc.api_call('reactions.add',name='one',channel=event[0]["channel"],timestamp=event[0]["ts"])
                        sc.api_call('reactions.add',name='two',channel=event[0]["channel"],timestamp=event[0]["ts"])
                        sc.api_call('reactions.add',name='three',channel=event[0]["channel"],timestamp=event[0]["ts"])
        time.sleep(1)
