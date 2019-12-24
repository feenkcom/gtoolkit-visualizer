"
My subclasses implement treemap slice algorithms.
See my subclasses for more details and examples: ${class:GtGraphTreemapSlice|show=gtSubclassesFor:|expanded=true}$


"
Class {
	#name : #GtGraphTreemapSlice,
	#superclass : #GtGraphTreemap,
	#instVars : [
		'breadth'
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

{ #category : #initialization }
GtGraphTreemapSlice >> initialize [
	super initialize.
	breadth := 0.
]

{ #category : #accessing }
GtGraphTreemapSlice >> length [
	<return: #Number>
	^ area
]

{ #category : #accessing }
GtGraphTreemapSlice >> length: aNumber [
	area := aNumber
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

{ #category : #adding }
GtGraphTreemapSlice >> updateNode: aNode [
	self updateExtentFor: aNode.
	self nodes
		ifEmpty: [ aNode position: 0 @ 0 ]
		ifNotEmpty: [ self updatePositionFor: aNode ]
]

{ #category : #updating }
GtGraphTreemapSlice >> updatePositionFor: aNode [
	self subclassResponsibility
]
