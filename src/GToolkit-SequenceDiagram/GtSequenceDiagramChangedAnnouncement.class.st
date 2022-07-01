Class {
	#name : #GtSequenceDiagramChangedAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'sequenceDiagram'
	],
	#category : #'GToolkit-SequenceDiagram-Announcements'
}

{ #category : #accessing }
GtSequenceDiagramChangedAnnouncement >> sequenceDiagram [

	^ sequenceDiagram
]

{ #category : #accessing }
GtSequenceDiagramChangedAnnouncement >> sequenceDiagram: anObject [

	sequenceDiagram := anObject
]
