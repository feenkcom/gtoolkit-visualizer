examples - instance creation
treeLayout: levelDistance nodeDistance: nodeDistance

	<gtExample>
	|  aTreeLayout |

	aTreeLayout := GtGradVerticalTreeLayout new.
 	aTreeLayout levelDistance: levelDistance.
	aTreeLayout nodeDistance: nodeDistance.
										
	self assert: aTreeLayout levelDistance equals: levelDistance.
	self assert: aTreeLayout nodeDistance equals: nodeDistance.

	^ aTreeLayout