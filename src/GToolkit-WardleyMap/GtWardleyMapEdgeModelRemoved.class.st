Class {
	#name : #GtWardleyMapEdgeModelRemoved,
	#superclass : #GtWardleyMapModelAnnouncement,
	#instVars : [
		'edgeModel'
	],
	#category : #'GToolkit-WardleyMap-Events'
}

{ #category : #accessing }
GtWardleyMapEdgeModelRemoved >> edgeModel [
	^ edgeModel
]

{ #category : #accessing }
GtWardleyMapEdgeModelRemoved >> edgeModel: anObject [
	edgeModel := anObject
]
