"
I keep utility methods that are useful for ${class:GtGraphTreemapSquarifyWorst}$ inspector extention views.

"
Class {
	#name : #GtGraphTreemapSquarifyWorstPreview,
	#superclass : #Object,
	#instVars : [
		'worst'
	],
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Treemap'
}

{ #category : #converting }
GtGraphTreemapSquarifyWorstPreview >> asElement [
	^ GtGraphUtilities default 
		rectangleOn: self 
		extent: self extent 
		margin: (BlInsets all: 0)
]

{ #category : #converting }
GtGraphTreemapSquarifyWorstPreview >> asElementWithInformation [
	^ GtGraphUtilities default 
		informationForRectangle: self asElement 
		bounds: self bounds
]

{ #category : #converting }
GtGraphTreemapSquarifyWorstPreview >> asElementWithNodes [
	| aContainer aNextNodePosition |
	aContainer := BlElement new.
	aContainer layout: BlFitLayout new.
	aContainer constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ].
	aContainer addChild: self asElementWithInformation.
	aNextNodePosition := 0@0.
	self nodes do: [ :eachNode | 
		| anExtent anElement |
		anExtent := self nodeExtent: eachNode.
		anElement := GtGraphUtilities default 
			rectangleOn: eachNode 
			extent: anExtent 
			margin: (BlInsets all: 0).
		GtGraphUtilities default 
			informationForRectangle: anElement 
			bounds: (aNextNodePosition extent: anExtent).
		anElement
			background: (Color random alpha: 0.5);
			size: anExtent asFloatPoint;
			relocate: aNextNodePosition asFloatPoint.
		aContainer addChild: anElement.
		aNextNodePosition := aNextNodePosition + (0 @ anExtent y) ].
	^ aContainer
]

{ #category : #converting }
GtGraphTreemapSquarifyWorstPreview >> asReversedElement [
	^ GtGraphUtilities default 
		rectangleOn: self 
		extent: self reversedExtent 
		margin: (BlInsets all: 0)
]

{ #category : #converting }
GtGraphTreemapSquarifyWorstPreview >> asReversedElementWithInformation [
	^ GtGraphUtilities default 
		informationForRectangle: self asReversedElement 
		bounds: self reversedBounds
]

{ #category : #converting }
GtGraphTreemapSquarifyWorstPreview >> asReversedElementWithNodes [
	| aContainer aNextNodePosition |
	aContainer := BlElement new.
	aContainer layout: BlFitLayout new.
	aContainer constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ].
	aContainer addChild: self asReversedElementWithInformation.
	aNextNodePosition := 0@0.
	self nodes do: [ :eachNode | 
		| anExtent anElement |
		anExtent := self nodeReversedExtent: eachNode.
		anElement := GtGraphUtilities default 
			rectangleOn: eachNode 
			extent: anExtent 
			margin: (BlInsets all: 0).
		GtGraphUtilities default 
			informationForRectangle: anElement 
			bounds: (aNextNodePosition extent: anExtent).
		anElement
			background: (Color random alpha: 0.5);
			size: anExtent asFloatPoint;
			relocate: aNextNodePosition asFloatPoint.
		aContainer addChild: anElement.
		aNextNodePosition := aNextNodePosition + (anExtent x @ 0) ].
	^ aContainer
]

{ #category : #'accessing - occupied area' }
GtGraphTreemapSquarifyWorstPreview >> bounds [
	^ 0@0 extent: self extent
]

{ #category : #accessing }
GtGraphTreemapSquarifyWorstPreview >> breadth [
	^ self worst breadth
]

{ #category : #'accessing - occupied area' }
GtGraphTreemapSquarifyWorstPreview >> extent [
	<return: #Point>
	^ self breadth @ self length
]

{ #category : #'gt-extension' }
GtGraphTreemapSquarifyWorstPreview >> gtNodesFor: aView [
	<gtView>
	self nodes ifNil: [ ^ aView empty ].
	^ aView columnedList 
		title: 'Nodes';
		items: [ self nodes ];
		column: 'Weight' 
			item: [ :aNode | aNode weight ] 
			format: [ :aNumber | self printNumber: aNumber ];
		column: 'Worst Value' 
			item: [ :aNode | self worstValueForNode: aNode ] 
			format: [ :aNumber | self printNumber: aNumber ];
		column: 'Vertical Extent'
			item: [ :aNode | | anExtent | 
				anExtent := (self nodeExtent: aNode) asFloatPoint.
				anExtent x rounded @ anExtent y rounded ];
		column: 'Horizontal Extent'
			item: [ :aNode | | anExtent | 
				anExtent := (self nodeReversedExtent: aNode) asFloatPoint.
				anExtent x rounded @ anExtent y rounded ]
]

{ #category : #'gt-extension' }
GtGraphTreemapSquarifyWorstPreview >> gtPreviewFor: aView [
	<gtView>
	self length ifNil: [ ^ aView empty ].
	self breadth ifNil: [ ^ aView empty ].
	^ aView explicit
		title: 'Vertical Preview';
		priority: 2;
		stencil: [ self asElementWithNodes asScalableElement
			margin: (BlInsets all: 10) ]
]

{ #category : #'gt-extension' }
GtGraphTreemapSquarifyWorstPreview >> gtReversedPreviewFor: aView [
	<gtView>
	self length ifNil: [ ^ aView empty ].
	self breadth ifNil: [ ^ aView empty ].
	^ aView explicit
		title: 'Horizontal Preview';
		priority: 3;
		stencil: [ self asReversedElementWithNodes asScalableElement
			margin: (BlInsets all: 10) ]
]

{ #category : #'gt-extension' }
GtGraphTreemapSquarifyWorstPreview >> gtWorstValueFor: aView [
	<gtView>
	self nodes ifNil: [ ^ aView empty ].
	self nodes ifEmpty: [ ^ aView empty ].
	^ (self value gtPreviewFor: aView)
		priority: 1;
		title: 'Worst Aspect Ratio'
]

{ #category : #accessing }
GtGraphTreemapSquarifyWorstPreview >> length [
	^ self worst length
]

{ #category : #'accessing - nodes' }
GtGraphTreemapSquarifyWorstPreview >> nodeArea: aNode [
	^ aNode weight * self totalArea
]

{ #category : #'accessing - nodes' }
GtGraphTreemapSquarifyWorstPreview >> nodeExtent: aNode [
	^ self nodesBreadth @ (self nodeLength: aNode)
]

{ #category : #'accessing - nodes' }
GtGraphTreemapSquarifyWorstPreview >> nodeLength: aNode [
	^ (self nodeArea: aNode) / self nodesBreadth
]

{ #category : #'accessing - nodes' }
GtGraphTreemapSquarifyWorstPreview >> nodeReversedExtent: aNode [
	^ (self nodeLength: aNode) @ self nodesBreadth
]

{ #category : #accessing }
GtGraphTreemapSquarifyWorstPreview >> nodes [
	^ self worst nodes
]

{ #category : #'accessing - nodes' }
GtGraphTreemapSquarifyWorstPreview >> nodesBreadth [
	^ self worst nodesBreadth
]

{ #category : #printing }
GtGraphTreemapSquarifyWorstPreview >> printNumber: aNumber [
	<return: #String>
	^ GtGraphUtilities default printNumber: aNumber
]

{ #category : #'accessing - occupied area' }
GtGraphTreemapSquarifyWorstPreview >> reversedBounds [
	^ 0@0 extent: self reversedExtent
]

{ #category : #'accessing - occupied area' }
GtGraphTreemapSquarifyWorstPreview >> reversedExtent [
	<return: #Point>
	^ self length @ self breadth
]

{ #category : #accessing }
GtGraphTreemapSquarifyWorstPreview >> totalArea [
	^ self worst totalArea
]

{ #category : #evaluating }
GtGraphTreemapSquarifyWorstPreview >> value [
	^ self worst value
]

{ #category : #accessing }
GtGraphTreemapSquarifyWorstPreview >> worst [
	^ worst
]

{ #category : #accessing }
GtGraphTreemapSquarifyWorstPreview >> worst: anObject [
	worst := anObject
]

{ #category : #'accessing - nodes' }
GtGraphTreemapSquarifyWorstPreview >> worstValueForNode: aNode [
	^ self worst worstValueForNode: aNode
]
