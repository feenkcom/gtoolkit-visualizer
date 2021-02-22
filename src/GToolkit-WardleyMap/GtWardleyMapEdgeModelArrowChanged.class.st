Class {
	#name : #GtWardleyMapEdgeModelArrowChanged,
	#superclass : #Announcement,
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
