Class {
	#name : #GtWardleyMapModelChanged,
	#superclass : #GtWardleyMapModelAnnouncement,
	#instVars : [
		'wardleyMapModel',
		'dueToAnnouncement'
	],
	#category : #'GToolkit-WardleyMap-Events'
}

{ #category : #accessing }
GtWardleyMapModelChanged >> dueToAnnouncement [
	^ dueToAnnouncement
]

{ #category : #accessing }
GtWardleyMapModelChanged >> dueToAnnouncement: anObject [
	dueToAnnouncement := anObject
]

{ #category : #accessing }
GtWardleyMapModelChanged >> wardleyMapModel [
	^ wardleyMapModel
]

{ #category : #accessing }
GtWardleyMapModelChanged >> wardleyMapModel: anObject [
	wardleyMapModel := anObject
]
