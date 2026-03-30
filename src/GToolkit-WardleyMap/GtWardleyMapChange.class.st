Class {
	#name : #GtWardleyMapChange,
	#superclass : #RBRefactoryChange,
	#instVars : [
		'map'
	],
	#category : #'GToolkit-WardleyMap-Changes'
}

{ #category : #'instance creation' }
GtWardleyMapChange class >> onMap: aWardleyMapModel [
	^ self new
		map: aWardleyMapModel;
		yourself
]

{ #category : #copying }
GtWardleyMapChange >> copyForPreviewIn: previewMap using: mapping [
	| copy |
	copy := self copy.
	copy map: previewMap.
	^ copy
]

{ #category : #accessing }
GtWardleyMapChange >> map [
	^ map
]

{ #category : #accessing }
GtWardleyMapChange >> map: anObject [
	map := anObject
]
