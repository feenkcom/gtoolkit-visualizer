"
I describes a logical connection (link) between methods


"
Class {
	#name : #GtConnectorLink,
	#superclass : #Object,
	#instVars : [
		'source',
		'target'
	],
	#category : #'GToolkit-Connector-Extensions'
}

{ #category : #'instance creation' }
GtConnectorLink class >> source: aSource target: aTarget [
	^ self new source: aSource target: aTarget
]

{ #category : #comparing }
GtConnectorLink >> = anotherObject [
	self == anotherObject
		ifTrue: [ ^ true ].
	(anotherObject isKindOf: self class)
		ifFalse: [ ^ false ].
	
	^ anotherObject source = self source
		and: [ anotherObject target = self target ]
]

{ #category : #comparing }
GtConnectorLink >> hash [
	^ self source hash bitXor: self target hash
]

{ #category : #accessing }
GtConnectorLink >> inverted [
	^ self class
		source: self target
		target: self source
]

{ #category : #accessing }
GtConnectorLink >> source [
	^ source
]

{ #category : #initialization }
GtConnectorLink >> source: aSource target: aTarget [

	source := aSource.
	target := aTarget
]

{ #category : #accessing }
GtConnectorLink >> target [
	^ target
]
