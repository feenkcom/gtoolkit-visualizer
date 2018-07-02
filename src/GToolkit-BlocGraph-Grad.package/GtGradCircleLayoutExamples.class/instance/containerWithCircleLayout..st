examples - composite
containerWithCircleLayout: layoutDistance
	<gtExample>
	| aContainer aCircleLayout |
	
	aContainer := self container. 
	aCircleLayout := self circleLayout: layoutDistance.

	aContainer layout: aCircleLayout.
	
	^ aContainer