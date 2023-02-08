Class {
	#name : #GtWardleyMapNodeModelInnerNodeAdded,
	#superclass : #GtWardleyMapNodeModelAnnouncement,
	#instVars : [
		'innerNodeModel'
	],
	#category : #'GToolkit-WardleyMap-Events'
}

{ #category : #accessing }
GtWardleyMapNodeModelInnerNodeAdded >> innerNodeModel [
	^ innerNodeModel
]

{ #category : #accessing }
GtWardleyMapNodeModelInnerNodeAdded >> innerNodeModel: anObject [
	innerNodeModel := anObject
]
