"
My subclasses are announced by the edge model {{gtClass:GtWardleyMapEdgeModel}}


"
Class {
	#name : #GtWardleyMapEdgeModelAnnouncement,
	#superclass : #GtWardleyMapAnnouncement,
	#instVars : [
		'edgeModel'
	],
	#category : #'GToolkit-WardleyMap-Events'
}

{ #category : #accessing }
GtWardleyMapEdgeModelAnnouncement >> edgeModel [
	^ edgeModel
]

{ #category : #accessing }
GtWardleyMapEdgeModelAnnouncement >> edgeModel: anObject [
	edgeModel := anObject
]
