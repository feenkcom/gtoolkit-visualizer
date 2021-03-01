Class {
	#name : #GtWardleyMapEdgeModelArrowChanged,
	#superclass : #GtWardleyMapEdgeModelAnnouncement,
	#instVars : [
		'edgeModel'
	],
	#category : #'GToolkit-WardleyMap-Events'
}

{ #category : #accessing }
GtWardleyMapEdgeModelArrowChanged >> edgeModel [
	^ edgeModel
]

{ #category : #accessing }
GtWardleyMapEdgeModelArrowChanged >> edgeModel: anObject [
	edgeModel := anObject
]
