class xx(object):
	s = 1 
	def __init__(self):
		self.s = '2222222222'
	@classmethod
	def a(cls):
		print cls.s

	def b(self):
		xx.s += 1
		print self.s
	@staticmethod
	def c(v):
		xx.s = v
		print xx.s

class yy(xx):
	s = 2
	@classmethod
	def a(cls):
		print cls.s
