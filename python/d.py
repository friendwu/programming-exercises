from sys import argv
from xml.sax import ContentHandler
from xml.sax import parse

file = argv[1]

class PageMaker(ContentHandler):
	def startElement(self, name, attrs):
		pass
	def characters(self, chars):
		print chars	

	def endElement(self, name):
		pass

parse(file, PageMaker())
