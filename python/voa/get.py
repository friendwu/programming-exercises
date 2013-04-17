import re
import urllib2
from BeautifulSoup import BeautifulSoup
import os

date_regex = re.compile(r'<a href="http://.+?putclub\.com_([0-9]{8}).+?\.mp3"', re.DOTALL)
link_regex = re.compile(r'<a href="(http://.+?\.(?:mp3|pdf))"')
exclude_regexes = [re.compile(r'.+FEATURE.mp3'), re.compile(r'.+SENEWS.+')]

url = "http://www.putclub.com/daily"
html = urllib2.urlopen(url).read()
ignore_dirs = []
file_set = set()
ignore_links = []

for path, dirs, files in os.walk('.'):
	file_set.update(files)

soup = BeautifulSoup(html)
l = soup.findAll('div', attrs={'class' : 'panel'})

for block in l:
	m = date_regex.search(str(block))
	datedir = m.group(1)
	if os.path.exists(datedir):
		ignore_dirs.append(datedir)
		continue

	os.mkdir(datedir)
	os.chdir(datedir)

	for link in link_regex.findall(str(block)):
		file_name = link.split('/')[-1]
		exclude = 0
		for r in exclude_regexes:
			if r.match(file_name):
				print 'exclude file name %s' % file_name
				exclude = 1
				break

		if exclude: continue

		if not file_name in file_set:
			os.system('wget -c %s' % link)
			file_set.add(file_name)
		else: 
			ignore_links.append(link)
	os.chdir('..')

for i in ignore_dirs:
	print 'ignore existed directory:', i

for i in ignore_links:
	print 'ignore dupliated source: ', i
