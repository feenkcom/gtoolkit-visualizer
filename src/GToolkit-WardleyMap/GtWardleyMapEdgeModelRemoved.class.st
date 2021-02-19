Class {
	#name : #GtWardleyMapEdgeModelRemoved,
	#superclass : #Announcement,
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
