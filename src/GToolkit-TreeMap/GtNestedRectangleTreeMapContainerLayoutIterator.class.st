Class {
	#name : 'GtNestedRectangleTreeMapContainerLayoutIterator',
	#superclass : 'Object',
	#instVars : [
		'layoutClasses',
		'nextLayoutIndex'
	],
	#category : 'GToolkit-TreeMap-Core'
}

{ #category : 'initialization' }
GtNestedRectangleTreeMapContainerLayoutIterator >> beAlternateHorizontalAndVerticalSlice [
	self layoutClasses: { GtGraphTreemapSliceHorizontalLayout. GtGraphTreemapSliceVerticalLayout }
	
]

{ #category : 'initialization' }
GtNestedRectangleTreeMapContainerLayoutIterator >> beSquarified [
	self layoutClasses: { GtGraphTreemapSquarifiedLayout }
]

{ #category : 'initialization' }
GtNestedRectangleTreeMapContainerLayoutIterator >> initialize [
	super initialize.
	nextLayoutIndex := 1.
	self beSquarified.
]

{ #category : 'accessing' }
GtNestedRectangleTreeMapContainerLayoutIterator >> layoutClasses: anArray [
	layoutClasses := anArray
]

{ #category : 'accessing' }
GtNestedRectangleTreeMapContainerLayoutIterator >> nextLayout [
	<return: #BlLayout>
	^ self nextLayoutClass new
]

{ #category : 'accessing' }
GtNestedRectangleTreeMapContainerLayoutIterator >> nextLayoutClass [
	<return: #Class>
	| aLayoutClass aPossibleNextLayoutIndex |
	aLayoutClass := layoutClasses at: nextLayoutIndex.
	aPossibleNextLayoutIndex := nextLayoutIndex + 1.
	nextLayoutIndex := aPossibleNextLayoutIndex > layoutClasses size
		ifTrue: [ 1 ]
		ifFalse: [ aPossibleNextLayoutIndex ].
	^ aLayoutClass
]
