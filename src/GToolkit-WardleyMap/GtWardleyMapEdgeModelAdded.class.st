Class {
	#name : #GtWardleyMapEdgeModelAdded,
	#superclass : #GtWardleyMapModelAnnouncement,
	#instVars : [
		'edgeModel'
	],
	#category : #'GToolkit-WardleyMap-Events'
}

{ #category : #accessing }
GtWardleyMapEdgeModelAdded >> edgeModel [
	^ edgeModel
]

{ #category : #accessing }
GtWardleyMapEdgeModelAdded >> edgeModel: anObject [
	edgeModel := anObject
]
