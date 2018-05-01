space-calculation
areasFrom: space overlapingOutside: aRectangle
	"Answer an Array of maximized Rectangles comprising (overlaped by each other) the parts of the receiver not 
	intersecting aRectangle. Make sure the intersection is non-empty"
	| areas o c |
	(space intersects: aRectangle) ifFalse: [ ^ Array with: space ].
	areas := OrderedCollection new.
	o := space topLeft.
	c := space bottomRight.
	aRectangle topLeft y > o y 
		ifTrue: 
			[ areas addLast: (o corner: c x @ aRectangle topLeft y) ].
	aRectangle bottomRight y < c y 
		ifTrue: 
			[ areas addLast: (o x @ aRectangle bottomRight y corner: c) ].
	aRectangle topLeft x > o x 
		ifTrue: 
			[ areas addLast: (o corner: aRectangle topLeft x @ c y) ].
	aRectangle bottomRight x < c x 
		ifTrue: 
			[ areas addLast: (aRectangle bottomRight x @ o y corner: c) ].
	^ areas