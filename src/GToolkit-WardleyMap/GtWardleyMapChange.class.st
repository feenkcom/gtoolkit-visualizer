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

{ #category : #accessing }
GtWardleyMapChange >> map [
	^ map
]

{ #category : #accessing }
GtWardleyMapChange >> map: anObject [
	map := anObject
]
