from xml.dom import minidom
import urllib2
from sys import argv

url = 'http://dict.youdao.com/fsearch?client=deskdict&keyfrom=chrome.extension&q=%s&pos=-1&doctype=xml&xmlVersion=3.2&dogVersion=1.0&vendor=unknown&appVer=3.1.17.4208&le=eng' % argv[1]
#url = 'http://220.181.76.240/fsearch?client=deskdict&keyfrom=chrome.extension&q=%s&pos=-1&doctype=xml&xmlVersion=3.2&dogVersion=1.0&vendor=unknown&appVer=3.1.17.4208&le=eng' % argv[1]
#url = 'http://dict.youdao.com/fsearch?&q=%s&doctype=xml&xmlVersion=3.2&dogVersion=1.0&appVer=3.1.17.4208&le=eng' % argv[1]

headers = {
	'Cookie' : 'JSESSIONID=abcPDqMgmdvly4rj02sPt; DESKDICT_VENDOR=cidian.youdao.com;OUTFOX_SEARCH_USER_ID=1164183104@220.176.189.152; __ntes__test__cookies=1358058262037;_ntes_nnid=e2f21446e88fb5da3afb49230aff7f38,1358058262040',
	'User-Agent' : 'Mozilla/5.0 (X11; Linux i686) AppleWebKit/537.11 (KHTML, like Gecko) Chrome/23.0.1271.97 Safari/537.11',
	'Connection' : 'close',
	'Host' : 'dict.youdao.com'
}

req = urllib2.Request(
    url = url,
    headers = headers
)
xml = urllib2.urlopen(req).read()

doc = minidom.parseString(xml)
root = doc.documentElement

try:
	phonetic_symbol = root.getElementsByTagName('phonetic-symbol')[0].childNodes[0].nodeValue
	
	custom_translation = []
	for c in root.getElementsByTagName('content'):
		custom_translation.append(c.childNodes[0].nodeValue)

	print '%s: [%s] ' % (argv[1], phonetic_symbol)
	print '\n'.join(custom_translation), '\n'

	#print 'web translations: '

	web_translation = root.getElementsByTagName('web-translation')
	for t in web_translation:
		key = t.getElementsByTagName('key')[0].childNodes[0].nodeValue
		trans = t.getElementsByTagName('trans')
		values = []
		for tr in trans:
			value = tr.getElementsByTagName('value')[0].childNodes[0].nodeValue
			values.append(value)

		print '%s: %s' %(key, ', '.join(values))
except:
	print 'cannot find the definition of %s.' % argv[1]
