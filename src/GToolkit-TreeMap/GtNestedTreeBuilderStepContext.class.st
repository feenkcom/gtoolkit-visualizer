Class {
	#name : 'GtNestedTreeBuilderStepContext',
	#superclass : 'Object',
	#instVars : [
		'data',
		'weight'
	],
	#category : 'GToolkit-TreeMap-Data Structures'
}

{ #category : 'copying' }
GtNestedTreeBuilderStepContext >> copyWithData: aCollection [ 
	^ self copy data: aCollection
]

{ #category : 'accessing' }
GtNestedTreeBuilderStepContext >> data [
	^ data
]

{ #category : 'accessing' }
GtNestedTreeBuilderStepContext >> data: anObject [
	data := anObject
]

{ #category : 'initialization' }
GtNestedTreeBuilderStepContext >> defaultData [
	^ #()
]

{ #category : 'initialization' }
GtNestedTreeBuilderStepContext >> defaultWeight [
	^ [ :anItem | anItem isNumber ifTrue: [ anItem ] ifFalse: [ 1 ] ]
]

{ #category : 'gt-extension' }
GtNestedTreeBuilderStepContext >> gtDataFor: aView [
	<gtView>
	self data ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Data';
		object: [ self data ];
		view: #gtItemsFor:
]

{ #category : 'initialization' }
GtNestedTreeBuilderStepContext >> initialize [
	super initialize.
	data := self defaultData.
	weight := self defaultWeight.

]

{ #category : 'accessing' }
GtNestedTreeBuilderStepContext >> weight [
	^ weight
]

{ #category : 'accessing' }
GtNestedTreeBuilderStepContext >> weight: anObject [
	weight := anObject
]
