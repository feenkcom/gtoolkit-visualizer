Class {
	#name : #GtGraphCircleEnclosureElement,
	#superclass : #BlElement,
	#instVars : [
		'enclosure'
	],
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Circle'
}

{ #category : #'private - elements' }
GtGraphCircleEnclosureElement >> embellishCircle: aCircleElement at: anIndex [
	| aCircle aCenterLabel aCenterLabelElement |

	aCircle := self enclosure circles at: anIndex.

	aCenterLabel := ('C' asRopedText fontSize: self labelFontSize)
		append: ((' ', anIndex asString) asRopedText fontSize: (self labelFontSize * 0.65)).

	aCenterLabelElement := self newLabel: aCenterLabel for: aCircleElement circle: aCircle.

	aCircleElement relocate: aCircle origin.
	aCircleElement addChild: aCenterLabelElement
]

{ #category : #'private - elements' }
GtGraphCircleEnclosureElement >> embellishEnclosureCircle: aCircleElement [
	| anActualCircle |

	anActualCircle := aCircleElement childNamed: #circle.
	anActualCircle
		background: (BrGlamorousColors primaryBorderColor alpha: 0.1);
		border: (anActualCircle border copyWithPaint: BrGlamorousColors primaryBorderColor).
	(aCircleElement childNamed: #center) background: (Color transparent)
]

{ #category : #accessing }
GtGraphCircleEnclosureElement >> enclosure [
	^ enclosure
]

{ #category : #accessing }
GtGraphCircleEnclosureElement >> enclosure: anObject [
	enclosure := anObject.
	self initializeElement
]

{ #category : #initialization }
GtGraphCircleEnclosureElement >> initializeElement [
	| theCircleElements anEnclosureCircle anEnclosureCircleElement |
	
	self layout: BlFitLayout new.
	
	theCircleElements := self enclosure circles withIndexCollect: [ :eachCircle :anIndex |
		| aCircleElement |
		
		aCircleElement := eachCircle asElement.
		self embellishCircle: aCircleElement at: anIndex.
		aCircleElement ].

	anEnclosureCircle := self enclosure enclosureCircle.
	anEnclosureCircleElement := anEnclosureCircle asElement.
	anEnclosureCircleElement relocate: anEnclosureCircle origin.
	self embellishEnclosureCircle: anEnclosureCircleElement.
	
	self addChildren: theCircleElements.
	self addChild: anEnclosureCircleElement
]

{ #category : #'private - elements' }
GtGraphCircleEnclosureElement >> labelFontSize [
	^ self enclosure averageRadius / 6.0
]

{ #category : #'private - elements' }
GtGraphCircleEnclosureElement >> newLabel: aLabelText for: aCircleElement circle: aCircle [ 
	| aCenterLabelElement aCenterBounds aCenterLabelDistance aCenterLabelPosition |

	aCenterLabelElement := BlTextElement new text: aLabelText.
	aCenterLabelElement forceLayout.

	aCenterBounds := (aCircleElement childNamed: #center) userData at: #centerBounds.

	aCenterLabelDistance := ((aCenterBounds extent max / 2.0) + (aCenterLabelElement extent max / 2.0)) * 2 sqrt.
	aCenterLabelPosition := aCircle outerRadius asPoint - (aCenterLabelElement extent / 2.0) + ((0@1) * aCenterLabelDistance).
	aCenterLabelElement relocate: aCenterLabelPosition.
	
	^ aCenterLabelElement
]
