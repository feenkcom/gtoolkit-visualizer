Class {
	#name : #GtWardleyMapEdgeModel,
	#superclass : #Object,
	#traits : 'TGtAnnouncer + TGtWardleyMapWithColor + TGtWardleyMapWithArrow + TGtWardleyMapWithWidth + TGtWardleyMapExportable + TGtWardleyMapVisitable',
	#classTraits : 'TGtAnnouncer classTrait + TGtWardleyMapWithColor classTrait + TGtWardleyMapWithArrow classTrait + TGtWardleyMapWithWidth classTrait + TGtWardleyMapExportable classTrait + TGtWardleyMapVisitable classTrait',
	#instVars : [
		'announcer',
		'fromNode',
		'toNode'
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
	width := 1.0.
	arrow := false
]

{ #category : #'api - arrow' }
GtWardleyMapEdgeModel >> notifyArrowChanged [
	self announce: (GtWardleyMapEdgeModelArrowChanged new edgeModel: self)
]

{ #category : #'api - color' }
GtWardleyMapEdgeModel >> notifyColored [
	self announce: (GtWardleyMapEdgeModelColored new edgeModel: self)
]

{ #category : #'api - width' }
GtWardleyMapEdgeModel >> notifyWidthChanged [
	self announce: (GtWardleyMapEdgeModelResized new edgeModel: self)
]

{ #category : #accessing }
GtWardleyMapEdgeModel >> toNode [
	^ toNode
]

{ #category : #accessing }
GtWardleyMapEdgeModel >> toNode: anObject [
	toNode := anObject
]
