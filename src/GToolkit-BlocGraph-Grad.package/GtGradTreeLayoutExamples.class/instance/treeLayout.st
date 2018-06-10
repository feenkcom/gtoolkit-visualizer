examples - instance creation
treeLayout
	<gtExample>
	|  aTreeLayout |

	aTreeLayout := GtGradTreeLayout new.
	self assert: aTreeLayout levelDistance equals: 5.
	self assert: aTreeLayout nodeDistance equals: 20.
	self assert: aTreeLayout orientation equals: 1.

	^ aTreeLayout