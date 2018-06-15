examples - instance creation
treeLayout
	<gtExample>
	|  aTreeLayout |

	aTreeLayout := GtGradHorizontalTreeLayout new.
	self assert: aTreeLayout levelDistance equals: 5.
	self assert: aTreeLayout nodeDistance equals: 20.

	^ aTreeLayout