Class {
	#name : #GtGraphTreemapSlice,
	#superclass : #Object,
	#instVars : [
		'nodes',
		'breadth',
		'length'
	],
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Treemap'
}

{ #category : #factory }
GtGraphTreemapSlice class >> horizontal [
	^ GtGraphTreemapSliceHorizontal new
]

{ #category : #testing }
GtGraphTreemapSlice class >> isAbstract [
	^ self name = #GtGraphTreemapSlice 
]

{ #category : #factory }
GtGraphTreemapSlice class >> vertical [
	^ GtGraphTreemapSliceVertical new
]

{ #category : #adding }
GtGraphTreemapSlice >> addNode: aNode [
	self updateExtentFor: aNode.
	self nodes 
		ifEmpty: [ aNode position: 0@0 ]
		ifNotEmpty: [ self updatePositionFor: aNode ].	
	self nodes: (self nodes, { aNode }).
]

{ #category : #converting }
GtGraphTreemapSlice >> asElement [
	<return: #BlElement>
	| aContainer |
	aContainer := BlElement new
		size: self extent;
		background: Color white;
		border: (BlBorder paint: Color lightGray width: 1).
	self nodes do: [ :eachNode | 
		aContainer addChild: (eachNode asElement
			background: Color random;
			relocate: eachNode position) ].
	^ aContainer
]

{ #category : #converting }
GtGraphTreemapSlice >> asElementWithInformation [
	<return: #BlElement>
	| aContainer |
	aContainer := BlElement new
		layout: (BlLinearLayout vertical cellSpacing: 3);
		background: Color white;
		constraintsDo: [ :c | 
			c horizontal fitContent.
			c vertical fitContent ].
	aContainer addChild: (self asElement
		constraintsDo: [ :c |
			c linear horizontal alignCenter]).
	aContainer addChild: (BlTextElement new
		text: (('Extent: ', self extent rounded asString) asRopedText glamorousCodeFontAndSize);
		constraintsDo: [ :c |
			c linear horizontal alignCenter ]).
	aContainer addChild: (BlTextElement new
		text: (('Remaining Extent: ', self remainingExtent rounded asString) asRopedText glamorousCodeFontAndSize);
		constraintsDo: [ :c |
			c linear horizontal alignCenter ]).
	^ aContainer
]

{ #category : #accessing }
GtGraphTreemapSlice >> breadth [
	<return: #Number>
	^ breadth
]

{ #category : #accessing }
GtGraphTreemapSlice >> breadth: aNumber [
	breadth := aNumber
]

{ #category : #accessing }
GtGraphTreemapSlice >> extent [
	<return: #Point>
	^ self subclassResponsibility
]

{ #category : #'gt-extension' }
GtGraphTreemapSlice >> gtNodesFor: aView [
	<gtView>
	self nodes ifNil: [ ^ aView empty ].
	^ (self nodes gtItemsFor: aView)
		title: 'Nodes'
]

{ #category : #'gt-extension' }
GtGraphTreemapSlice >> gtPreviewFor: aView [
	<gtView>
	self nodes ifNil: [ ^ aView empty ].
	^ aView explicit
		title: 'Preview';
		stencil: [ self asElementWithInformation asScalableElement
			margin: (BlInsets all: 10) ]
]

{ #category : #initialization }
GtGraphTreemapSlice >> initialize [
	super initialize.
	breadth := 0.
	nodes := #().
	length := 0.
]

{ #category : #accessing }
GtGraphTreemapSlice >> length [
	<return: #Number>
	^ length
]

{ #category : #accessing }
GtGraphTreemapSlice >> length: aNumber [
	length := aNumber
]

{ #category : #accessing }
GtGraphTreemapSlice >> nodes [
	<return: #Array>
	^ nodes
]

{ #category : #accessing }
GtGraphTreemapSlice >> nodes: anObject [
	nodes := anObject
]

{ #category : #accessing }
GtGraphTreemapSlice >> remainingExtent [
	<return: #Point>
	^ self subclassResponsibility
]

{ #category : #updating }
GtGraphTreemapSlice >> updateExtentFor: aNode [
	self subclassResponsibility
]

{ #category : #updating }
GtGraphTreemapSlice >> updatePositionFor: aNode [
	self subclassResponsibility
]
