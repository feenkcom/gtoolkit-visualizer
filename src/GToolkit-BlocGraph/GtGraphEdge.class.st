"
I represent a logical connection between two elements. I do not have a visual representation and I am used as a constraint in graph-based layouts.
"
Class {
	#name : #GtGraphEdge,
	#superclass : #Object,
	#instVars : [
		'from',
		'to'
	],
	#category : #'GToolkit-BlocGraph-Core'
}

{ #category : #'instance creation' }
GtGraphEdge class >> connecting: aFromElement to: aToElement [
	<return: #GtGraphEdge>

	^ aFromElement graph connectTo: aToElement
]

{ #category : #comparing }
GtGraphEdge >> = anObject [
	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ from == anObject fromElement and: [ to == anObject toElement ]
]

{ #category : #private }
GtGraphEdge >> from: anElement [
	from ifNotNil: [ :element | element constraints graph removeConnectedEdge: self ].
	from := anElement.
	anElement constraints graph addConnectedEdge: self
]

{ #category : #initialization }
GtGraphEdge >> from: fromElement to: toElement [
	self from: fromElement.
	self to: toElement
]

{ #category : #accessing }
GtGraphEdge >> fromElement [
	^ from
]

{ #category : #comparing }
GtGraphEdge >> hash [
	^ from hash bitXor: to hash
]

{ #category : #private }
GtGraphEdge >> to: anElement [
	to ifNotNil: [ :element | element constraints graph removeConnectedEdge: self ].
	to := anElement.
	anElement constraints graph addConnectedEdge: self
]

{ #category : #accessing }
GtGraphEdge >> toElement [
	^ to
]
