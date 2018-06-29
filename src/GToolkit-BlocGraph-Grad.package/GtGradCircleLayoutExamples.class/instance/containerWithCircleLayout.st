examples - composite
containerWithCircleLayout
	<gtExample>
	| aContainer aCircleLayout |
	
	aContainer := self container. 
	aCircleLayout := self circleLayout.

	aContainer layout: aCircleLayout.
	
	^ aContainer