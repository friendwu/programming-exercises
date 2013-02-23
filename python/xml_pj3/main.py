from xml.sax import ContentHandler
from xml.sax import parse

class PageMaker(ContentHandler):
	pass_through = False
	def startElement(self, name, attrs):
		if name == 'page':
			self.pass_through = True
			self.out = open(attrs['name'], 'w')
			self.out.write('<html><head>\n<title>%s</title></head><body>' % attrs['title'])
		elif self.pass_through:
			self.out.write('<' + name)
			for key,val in attrs.items():
				self.out.write('%s=%s', key, val)
			self.out.write('>\n')
	
	def characters(self, chars):
		if self.pass_through: self.out.write(chars)

	def endElement(self, name):
		if name == 'page':
			self.pass_through = False
			self.out.write('</html>')
			self.out.close()



