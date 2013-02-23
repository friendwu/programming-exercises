from xml.sax import ContentHandler, parse
import os

class WebsiteConstructor(ContentHandler):
	pass_through = False

	def __init__(self, directory):
		self.directory = [directory]
		self.ensureDirectory()
	
	def defaultStart(self, name, attrs):
		if self.pass_through: 
			self.out.write('<' + name)
			for key,val in attrs.items():
				self.out.write('%s=%s', key, val)
			self.out.write('>\n')

	def defaultEnd(self, name):
		if self.pass_through:
			self.out.write('</%s>' % name)

	def startDirectory(self, attrs):
		self.directory.append(attrs['name'])
		self.ensureDirectory()

	def endDirectory(self):
		self.directory.pop()

	def ensureDirectory(self):
		path = os.path.join(*self.directory)
		if not os.path.isdir(path): os.makedirs(path)

	def startPage(self, attrs):
		# TODO
		filename = os.path.join(*self.directory+[attrs['name']+'.html'])
		self.out = open(filename, 'w')
		self.writeHeader(attrs['title'])
		self.pass_through = True

	def endPage(self):
		self.pass_through = False
		self.writeFooter()
		self.out.close()

	def writeHeader(self, title):
		self.out.write('<html>\n <head> \n <title>')
		self.out.write(title)
		self.out.write('</title>\n </head> \n <body>')

	def writeFooter(self):
		self.out.write('\n<body>\n</html>')

	def startElement(self, name, attrs=None):
		self.dispatch('start', name, attrs)	

	def characters(self, chars):
		if self.pass_through: self.out.write(chars)

	def endElement(self, name):
		self.dispatch('end')

	def dispatch(self, prefix, name)
		mname = prefix + name.capitalize()
		dname = 'default' + prefix.capitalize()

		method = getattr(self.mname, None)
		if callable(method): args = ()
		else:
			method = getattr(self.dname, None)
			args = name,
			if prefix == 'start': args += attrs,
		if callable(method): method(*args)

