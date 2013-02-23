import re
import sys

def blocks(file):
	blk = []
	for line in file:
		if line.strip():
			blk.append(line)
		elif blk:
			yield blk
			blk = []
	
	if blk:
		yield blk 

class Filter(object):
	def apply(self, blk):
		pass

#class HeadFilter(Filter):
#	def apply(self, blk):
#		if len(blk) == 2 and blk[1].strip() == '':
#			blk[0] = "<S> %s <S>" % blk[0]

class RegexFilter(Filter):
	def __init__(self, regex):
		self.regex = re.compile(regex)

	def apply(self, blk):
		for i in range(len(blk)):
			blk[i] = self.regex.sub(self._sub, blk[i])


class RegexFilterOne(RegexFilter):
	def __init__(self):
		super(RegexFilterOne, self).__init__(r"\*(.+?)\*")
	
	def _sub(self, match):
		return "<strong>%s<strong>" % match.group(1)
		
class RegexFilterTwo(RegexFilter):
	def __init__(self):
		super(RegexFilterTwo, self).__init__(r"\s?-\s(.+?)")
	
	def _sub(self, match):
		return "<li>%s<li>" % match.group(1)

class Parser(object):
	def __init__(self, rules):
		self.rules = rules

	def parse(self, file):
		blk_list = []
		for blk in blocks(file):
			#apply rules
			for rule in self.rules:
				rule.apply(blk)
			blk_list.append(''.join(blk))
			print ''.join(blk_list)
			
rule_list = [RegexFilterOne(), RegexFilterTwo()]#, HeadFilter()]
argv1 = sys.argv[1]

f = open(argv1, 'r')
	
parser = Parser(rule_list)
parser.parse(f)
f.close()
