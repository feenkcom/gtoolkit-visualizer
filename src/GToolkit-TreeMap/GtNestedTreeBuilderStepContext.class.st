Class {
	#name : #GtNestedTreeBuilderStepContext,
	#superclass : #Object,
	#instVars : [
		'data',
		'weight'
	],
	#category : #'GToolkit-TreeMap-Data Structures'
}

{ #category : #copying }
GtNestedTreeBuilderStepContext >> copyWithData: aCollection [ 
	^ self copy data: aCollection
]

{ #category : #accessing }
GtNestedTreeBuilderStepContext >> data [
	^ data
]

{ #category : #accessing }
GtNestedTreeBuilderStepContext >> data: anObject [
	data := anObject
]

{ #category : #initialization }
GtNestedTreeBuilderStepContext >> defaultData [
	^ #()
]

{ #category : #initialization }
GtNestedTreeBuilderStepContext >> defaultWeight [
	^ [ :anItem | anItem yourself ]
]

{ #category : #initialization }
GtNestedTreeBuilderStepContext >> initialize [
	super initialize.
	data := self defaultData.
	weight := self defaultWeight.

]

{ #category : #accessing }
GtNestedTreeBuilderStepContext >> weight [
	^ weight
]

{ #category : #accessing }
GtNestedTreeBuilderStepContext >> weight: anObject [
	weight := anObject
]
