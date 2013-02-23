import re

ori_text = """<h3>aaaaa</h3>
<div class="layout basic">
<ul>

<li><span>adv.</span><strong>bbbbb</strong></li>
<li><span>n.</span><strong>ccccc</strong></li>
<li><span>v.</span><strong>ddddddd</strong></li>
</ul>
<div class="satis"><span>ddddddd</span><font><a href="###" satis="1">yyyy</a><a href="###" createword
="imp" satis="2">dfsfsfsfd</a></font></div>
</div>"""

m = re.match('<h3>aaaaa</h3>.*?<div.*?>(.*)</div>', ori_text, re.DOTALL)

xre = re.compile('<li><span>(.*?)</span><strong>(.*?)</strong></li>', re.DOTALL)

#for x in xre.findall(m.group(1)):
#	print "[%s]\t{%s}" %(x[0], x[1])

print xre.findall(m.group(1))

#1. greedy.
#2. api.
