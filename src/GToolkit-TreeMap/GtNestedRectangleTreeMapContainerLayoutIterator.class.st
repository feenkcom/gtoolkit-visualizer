Class {
	#name : #GtNestedRectangleTreeMapContainerLayoutIterator,
	#superclass : #Object,
	#instVars : [
		'layoutClasses',
		'nextLayoutIndex'
	],
	#category : #'GToolkit-TreeMap'
}

{ #category : #initialization }
GtNestedRectangleTreeMapContainerLayoutIterator >> initialize [
	super initialize.
	layoutClasses := { GtGraphTreemapSliceHorizontalLayout. GtGraphTreemapSliceVerticalLayout }.
	nextLayoutIndex := 1.
]

{ #category : #accessing }
GtNestedRectangleTreeMapContainerLayoutIterator >> nextLayout [
	<return: #BlLayout>
	^ self nextLayoutClass new
]

{ #category : #accessing }
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
