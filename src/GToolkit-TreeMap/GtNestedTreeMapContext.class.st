Class {
	#name : #GtNestedTreeMapContext,
	#superclass : #Object,
	#instVars : [
		'level',
		'model'
	],
	#category : 'GToolkit-TreeMap-Core'
}

{ #category : #copying }
GtNestedTreeMapContext >> copyWithModel: anObject [
	^ self copy
		model: anObject;
		level: self level + 1
]

{ #category : #accessing }
GtNestedTreeMapContext >> level [
	^ level
]

{ #category : #accessing }
GtNestedTreeMapContext >> level: anObject [
	level := anObject
]

{ #category : #accessing }
GtNestedTreeMapContext >> model [
	^ model
]

{ #category : #accessing }
GtNestedTreeMapContext >> model: anObject [
	model := anObject
]
