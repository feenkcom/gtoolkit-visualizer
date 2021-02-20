Class {
	#name : #GtWardleyMapEdgeModel,
	#superclass : #Object,
	#traits : 'TGtWardleyMapWithColor + TGtWardleyMapExportable + TGtAnnouncer',
	#classTraits : 'TGtWardleyMapWithColor classTrait + TGtWardleyMapExportable classTrait + TGtAnnouncer classTrait',
	#instVars : [
		'announcer',
		'fromNode',
		'toNode',
		'width'
	],
	#category : #'GToolkit-WardleyMap-! Models'
}

{ #category : #visiting }
GtWardleyMapEdgeModel >> acceptVisitor: aWardleyMapVisitor [
	^ aWardleyMapVisitor visitWardleyMapEdge: self
]

{ #category : #announcer }
GtWardleyMapEdgeModel >> announcer [
	<return: #Announcer>

	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #accessing }
GtWardleyMapEdgeModel >> fromNode [
	^ fromNode
]

{ #category : #accessing }
GtWardleyMapEdgeModel >> fromNode: anObject [
	fromNode := anObject
]

{ #category : #initialization }
GtWardleyMapEdgeModel >> initialize [
	super initialize.
	
	color := Color gray.
	width := 1.0
]

{ #category : #'api - color' }
GtWardleyMapEdgeModel >> notifyColored [
	self announce: (GtWardleyMapEdgeModelColored new edgeModel: self)
]

{ #category : #accessing }
GtWardleyMapEdgeModel >> toNode [
	^ toNode
]

{ #category : #accessing }
GtWardleyMapEdgeModel >> toNode: anObject [
	toNode := anObject
]

{ #category : #accessing }
GtWardleyMapEdgeModel >> width [
	<return: #Number>

	^ width
]

{ #category : #accessing }
GtWardleyMapEdgeModel >> width: aNumber [
	self width = aNumber
		ifTrue: [ ^ self ].

	width := aNumber.
	self announce: (GtWardleyMapEdgeModelResized new edgeModel: self)
]
