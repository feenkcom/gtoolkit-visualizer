"
A layout that packs rectangles in as amall space as possible (at least it tries to)

Instance Variables
	padding:	<Number>
	freeSpace:	<Set of Rectamgles>
	bounds:	<Point>

gap
	- gap between elements defined as ""percentage"" of average size. 0.2 means 20%

freeSpace
	- collection of spaces that can be used for next element insertion
	
bounds
	- bounding box of all currently processed elements

"
Class {
	#name : #GtGraphRectanglePackLayout,
	#superclass : #GtGraphLayout,
	#instVars : [
		'freeSpace',
		'gap',
		'padding',
		'bounds'
	],
	#category : 'GToolkit-BlocGraph-Layouts-Layouts'
}

{ #category : #'space-calculation' }
GtGraphRectanglePackLayout >> areasFrom: space overlapingOutside: aRectangle [
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
]

{ #category : #'space-calculation' }
GtGraphRectanglePackLayout >> bestSpaceFor: anElement [
	| elementsPadedBox suitableSpaces |
	
	elementsPadedBox := anElement measuredBounds asRectangle extendBy: padding * 2.
	
	suitableSpaces := freeSpace select: [ :space |
		elementsPadedBox width <= space width and:
			[ elementsPadedBox height <= space height ] ].
	suitableSpaces isEmpty ifTrue: [ ^ freeSpace anyOne ].
	^ suitableSpaces
		fold: [ :best :current |
			| bestExt currentExt | 
			((currentExt := self extentByInserting: elementsPadedBox into: current) <
			(bestExt := self extentByInserting: elementsPadedBox  into: best) or: [ 
				currentExt = bestExt and: [
					current gtHalfPerimeter < best gtHalfPerimeter ] ])
						ifTrue: [ current ]
						ifFalse: [ best ] ]
]

{ #category : #accessing }
GtGraphRectanglePackLayout >> boundingBox [
	^ bounds
]

{ #category : #hook }
GtGraphRectanglePackLayout >> doExecute: elements [
	| sortedElements maxSpace |
	bounds := 0@0.
	
	maxSpace := elements inject: 0@0 into: [ :sum :el |
			sum + el measuredExtent ].
		
	padding := maxSpace / elements size * gap / 2.
	
	maxSpace := 1 + gap * maxSpace.
	
	freeSpace := Set new.
	freeSpace add: (0@0 corner: maxSpace).
	
	sortedElements := SortedCollection sortBlock:  [ :larger :smaller |
		larger  boundsInLocal gtHalfPerimeter >
		smaller boundsInLocal gtHalfPerimeter ].
	sortedElements addAll: elements.
	
	sortedElements
		do: [ :el | self packIn: el ]
]

{ #category : #'space-calculation' }
GtGraphRectanglePackLayout >> extentByInserting: aRectangle into: aSpace [
	| futureCorner |
	futureCorner := aSpace origin + aRectangle extent.
	
	^	(((futureCorner x - bounds x) max: 0) +
		((futureCorner y - bounds y) max: 0))
		* "this is balancing magic"
		(((futureCorner max: bounds) degrees - 45) abs / 45 + 1)

]

{ #category : #accessing }
GtGraphRectanglePackLayout >> gap [
	"gap between elements defined as ''percentage'' of average size. 0.2 means 20%"
	^ gap
]

{ #category : #accessing }
GtGraphRectanglePackLayout >> gap: anObject [
	gap := anObject
]

{ #category : #'initialize-release' }
GtGraphRectanglePackLayout >> initialize [
	super initialize.
	gap := 0.2
]

{ #category : #execution }
GtGraphRectanglePackLayout >> packIn: anElement [
	translator translateTopLeftOf: anElement to: (self bestSpaceFor: anElement) origin + padding.
	bounds := bounds max: anElement bounds inParent bottomRight + padding.
	
	self recalculateFreeSpacesWith: anElement
]

{ #category : #deprecated }
GtGraphRectanglePackLayout >> padding [
	self deprecated: 'Use gap instead'.
	^ self gap
]

{ #category : #deprecated }
GtGraphRectanglePackLayout >> padding: anObject [
	self deprecated: 'Use gap: instead'.
	self gap: anObject
]

{ #category : #'space-calculation' }
GtGraphRectanglePackLayout >> recalculateFreeSpacesWith: anElement [
	freeSpace := freeSpace inject: Set new into: [ :set :space |
		 set
			addAll: (self areasFrom: space overlapingOutside:
				(anElement measuredBounds asRectangle expandBy: padding)); 
			yourself ].
		
	"remove subspaces"
	freeSpace := freeSpace reject: [ :subspace | 
		freeSpace anySatisfy: [ :space |
			space ~~ subspace and: [ 
				space containsRect: subspace ] ] ]
	
]
