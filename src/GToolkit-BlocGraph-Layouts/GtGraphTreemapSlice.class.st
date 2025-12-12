"
My subclasses implement treemap slice algorithms.
See my subclasses for more details and examples: {{gtClass:GtGraphTreemapSlice|show=gtSubclassesFor:|expanded=true}}


"
Class {
	#name : #GtGraphTreemapSlice,
	#superclass : #GtGraphTreemap,
	#instVars : [
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

{ #category : #converting }
GtGraphTreemapSlice >> asElementWithInformation [
	<return: #BlElement>
	| aContainer |
	aContainer := super asElementWithInformation.
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
