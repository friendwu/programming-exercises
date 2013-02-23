#!/usr/bin/python3.2
import urllib.request
import json

def wordMeaning(word):
    """
    Use YouDao API key and the url below, get the JSON formatted information,
    then use json lib to analyze the data.
    """
    try:
        url = 'http://fanyi.youdao.com/openapi.do?keyfrom=USERNAME&key=APIKEY&type=data&doctype=json&version=1.1&q='+word
        wordinfo= urllib.request.urlopen(url).read().decode('utf-8')
        data = json.loads(wordinfo)

        #if word is exist, the len(data) should be five.

        if len(data) != 5:
            print ("Not a word, maybe an incorrect input")
        else:
            for dataDetail in data['web']:
                print ('{0:25}'.format(dataDetail['key']), end='')
                for meanDetail in dataDetail['value']:
                    print(meanDetail, end=',')
                print ()
        
    finally:
        pass

while 1:
    word = input("Input your word: ")
    if(word == 'exit'):
        break
    else:
        wordMeaning(word)
