examples - instance creation
circleLayout: distance
	<gtExample>
	| aCircleLayout |

	aCircleLayout := GtGradCircleLayout new.
	aCircleLayout  distance: distance.
	self assert: aCircleLayout distance equals: distance.

	^ aCircleLayout