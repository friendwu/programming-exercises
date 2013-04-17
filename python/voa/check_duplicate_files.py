import os

file_set = set()

for path, dirs, files in os.walk('.'):
	for f in files:
		if f in file_set: 
			print 'duplicated file: ', os.path.join(path, f) 
			os.unlink(os.path.join(path, f))
	file_set.update(files)
