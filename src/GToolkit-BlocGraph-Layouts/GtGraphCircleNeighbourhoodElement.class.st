Class {
	#name : #GtGraphCircleNeighbourhoodElement,
	#superclass : #BlElement,
	#instVars : [
		'neighbourhood'
	],
	#category : 'GToolkit-BlocGraph-Layouts-Data Structures - Circle'
}

{ #category : #'private - elements' }
GtGraphCircleNeighbourhoodElement >> createEdges: theCircleElements neighbour: aNeighbourCircleElement [
	| theEdges |

	theEdges := theCircleElements collect: [ :eachCircleElement |
		self lineBetween: eachCircleElement and: aNeighbourCircleElement ].

	theCircleElements size >= 2
		ifTrue: [
			theEdges := theEdges, (theCircleElements overlappingPairsCollect: [ :aCircleElement :anAnotherCircleElement |
				self lineBetween: aCircleElement and: anAnotherCircleElement
			]) ].

	^ theEdges
]

{ #category : #'private - elements' }
GtGraphCircleNeighbourhoodElement >> embellishCircle: aCircleElement at: anIndex [
	| aCircle aCenterLabel aCenterLabelElement |

	aCircle := self neighbourhood circles at: anIndex.

	aCenterLabel := ('C' asRopedText fontSize: self labelFontSize)
		append: ((' ', anIndex asString) asRopedText fontSize: (self labelFontSize * 0.65)).

	aCenterLabelElement := self newLabel: aCenterLabel for: aCircleElement circle: aCircle.

	aCircleElement relocate: aCircle origin.
	aCircleElement addChild: aCenterLabelElement
]

{ #category : #'private - elements' }
GtGraphCircleNeighbourhoodElement >> embellishNeighbourCircle: aCircleElement [
	| aCircle aCenterLabelElement |
	aCircle := self neighbourhood neighbourCircle.
	aCenterLabelElement := self
		newLabel: ('C' asRopedText fontSize: self labelFontSize)
		for: aCircleElement
		circle: aCircle.
	aCircleElement addChild: aCenterLabelElement.
	aCircleElement relocate: aCircle origin.
	(aCircleElement childNamed: #circle)
		background: (self theme default primaryBorderColor alpha: 0.1).
	(aCircleElement childNamed: #center)
		background: self theme default primaryBorderColor
]

{ #category : #initialization }
GtGraphCircleNeighbourhoodElement >> initializeElement [
	| theCircleElements aNeighbourCircleElement theEdges |
	
	self layout: BlFitLayout new.
	self constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ].
	
	self neighbourhood neighbourCircle
		ifNil: [ ^ BlElement new ].
	
	theCircleElements := self neighbourhood circles withIndexCollect: [ :eachCircle :anIndex |
		| aCircleElement |
		
		aCircleElement := eachCircle asElement.
		self embellishCircle: aCircleElement at: anIndex.
		aCircleElement ].

	aNeighbourCircleElement := self neighbourhood neighbourCircle asElement.
	self embellishNeighbourCircle: aNeighbourCircleElement.
	
	theEdges := self createEdges: theCircleElements neighbour: aNeighbourCircleElement.

	self addChild: aNeighbourCircleElement.
	self addChildren: theCircleElements.
	self addChildren: theEdges.
	
	self initializeProjection: aNeighbourCircleElement
]

{ #category : #initialization }
GtGraphCircleNeighbourhoodElement >> initializeProjection: aNeighbourCircleElement [
	| aProjectionElement aProjectionLine aProjectionLabel |
	
	self neighbourhood size < 2
		ifTrue: [ ^ self ].

	aProjectionElement := self projectionElement.
	aProjectionLabel := self projectionLabelElement.

	self addChildren: { aProjectionElement . aProjectionLabel }.
	
	self neighbourhood size < 3
		ifTrue: [ ^ self ].

	aProjectionLine := self lineBetween: aNeighbourCircleElement and: aProjectionElement.
	self addChild: aProjectionLine
]

{ #category : #'private - elements' }
GtGraphCircleNeighbourhoodElement >> labelFontSize [
	^ self neighbourhood averageRadius / 6.0
]

{ #category : #'private - elements' }
GtGraphCircleNeighbourhoodElement >> lineBetween: aCircleElement and: anotherCircleElement [
	| aLine aCenter anAnotherCenter |
	
	aCenter := aCircleElement childNamed: #center ifFound: #yourself ifNone: aCircleElement.
	anAnotherCenter := anotherCircleElement childNamed: #center ifFound: #yourself ifNone: anotherCircleElement.
	
	aLine := BlLineElement new.
	aLine fromAnchor: (BlNearestPositionEllipseAnchor referenceElement: aCenter relatedTo: anAnotherCenter).
	aLine toAnchor: (BlNearestPositionEllipseAnchor referenceElement: anAnotherCenter relatedTo: aCenter).
	aLine border: (BlBorder paint: Color black width: 0.2).
	aLine constraintsDo: [ :c | c ignoreByLayout ].
	
	^ aLine
]

{ #category : #accessing }
GtGraphCircleNeighbourhoodElement >> neighbourhood [
	^ neighbourhood
]

{ #category : #accessing }
GtGraphCircleNeighbourhoodElement >> neighbourhood: aGtGraphCircleNeighbourhood [
	neighbourhood := aGtGraphCircleNeighbourhood.
	
	self initializeElement
]

{ #category : #'private - elements' }
GtGraphCircleNeighbourhoodElement >> newLabel: aLabelText for: aCircleElement circle: aCircle [ 
	| aCenterLabelElement aCenterBounds aCenterLabelDistance aCenterLabelPosition |

	aCenterLabelElement := BlTextElement new text: aLabelText.
	aCenterLabelElement forceLayout.

	aCenterBounds := (aCircleElement childNamed: #center) userData at: #centerBounds.

	aCenterLabelDistance := ((aCenterBounds extent max / 2.0) + (aCenterLabelElement extent max / 2.0)) * 2 sqrt.
	aCenterLabelPosition := aCircle outerRadius asPoint - (aCenterLabelElement extent / 2.0) + ((self neighbourhood averageOutgoingEdgeVector: aCircle) negated * aCenterLabelDistance).
	aCenterLabelElement relocate: aCenterLabelPosition.
	
	^ aCenterLabelElement
]

{ #category : #'private - elements projection' }
GtGraphCircleNeighbourhoodElement >> projectionElement [
	| anExtent |

	anExtent := self neighbourhood averageRadius asPoint /  20.0.
	
	^ BlElement new
		geometry: BlEllipseGeometry new;
		relocate: self neighbourhood neighbourProjection - (anExtent / 2.0);
		size: anExtent;
		background: (Color black alpha: 0.6)
]

{ #category : #'private - elements projection' }
GtGraphCircleNeighbourhoodElement >> projectionLabelElement [
	| aProjectionLabel aProjectionLabelElement aProjectionLabelDistance aProjection aProjectionVector |
	
	self
		assert: [ self neighbourhood size >= 2 ]
		description: [ 'Projection is available starting with 2 circles' ].

	aProjectionLabel := 'B' asRopedText fontSize: self labelFontSize.
	aProjectionLabelElement := BlTextElement new text: aProjectionLabel.
	aProjectionLabelElement forceLayout.
	
	aProjection := self neighbourhood neighbourProjection.
	aProjectionLabelDistance := aProjectionLabelElement extent max.

	aProjectionVector := self neighbourhood size = 2
		ifTrue: [ (self neighbourhood neighbourCircle center - self neighbourhood circles first center) normalized rightRotated ]
		ifFalse: [ (aProjection - self neighbourhood neighbourCircle center) normalized ].

	aProjectionLabelElement relocate: aProjection + (aProjectionVector * aProjectionLabelDistance) - (aProjectionLabelElement extent / 2.0).

	^ aProjectionLabelElement
]
