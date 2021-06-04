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
	self
		assert: [ from isNil ]
		description: [ 'From element of the graph edge must not be modified' ].

	from := anElement
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
	self
		assert: [ to isNil ]
		description: [ 'To element of the graph edge must not be modified' ].

	to := anElement
]

{ #category : #accessing }
GtGraphEdge >> toElement [
	^ to
]
