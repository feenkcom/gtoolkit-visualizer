examples - instance creation
circleLayout
	<gtExample>
	| aCircleLayout |

	aCircleLayout := GtGradCircleLayout new.
	self assert: aCircleLayout distance equals: 20.

	^ aCircleLayout