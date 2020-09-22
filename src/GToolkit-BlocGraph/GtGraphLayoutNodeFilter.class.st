Class {
	#name : #GtGraphLayoutNodeFilter,
	#superclass : #Object,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'GToolkit-BlocGraph-Core'
}

{ #category : #accessing }
GtGraphLayoutNodeFilter class >> cleanUp [
	uniqueInstance := nil
]

{ #category : #accessing }
GtGraphLayoutNodeFilter class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #comparing }
GtGraphLayoutNodeFilter >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	^ self class = anObject class
]

{ #category : #comparing }
GtGraphLayoutNodeFilter >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ self class hash
]

{ #category : #generated }
GtGraphLayoutNodeFilter >> value: aLayoutNode [
	^ aLayoutNode constraints graph isNode
]
