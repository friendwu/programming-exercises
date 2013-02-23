# -*- coding: utf-8 -*-
import sys
import re

#ori_text = u"""<h3>基本释义</h3>
#<div class="layout basic">
#<ul>
#
#<li><span>adv.</span><strong>是；是的</strong></li>
#<li><span>n.</span><strong>是（表示肯定）</strong></li>
#<li><span>v.</span><strong>对…说是</strong></li>
#</ul>
#<div class="satis"><span>您对本词条的内容满意吗：</span><font><a href="" satis="1">满意</a><a href="" createword
#="imp" satis="2">请改进</a></font></div>
#</div>"""
#
ori_text = sys.stdin.read()
m = re.match(r'.*?<h3>基本释义</h3>.*?<div.*?>(.*)</div>', ori_text, re.DOTALL)

#print m.group(1)
xre = re.compile(r'<li><span>(.*?)</span><strong>(.*?)</strong></li>', re.DOTALL)

for x in xre.findall(m.group(1)):
	print "[%s]\t{%s}" %(x[0], x[1])

# print xre.findall(m.group(1))

#0. coding utf-8
#1. greedy.
#2. api.
