Class {
	#name : #GtWardleyMapLabelMenuItem,
	#superclass : #Object,
	#traits : 'TGtWardleyMapContextMenuItem',
	#classTraits : 'TGtWardleyMapContextMenuItem classTrait',
	#instVars : [
		'text'
	],
	#category : #'GToolkit-WardleyMap-Helpers - Context Menu'
}

{ #category : #converting }
GtWardleyMapLabelMenuItem >> createElementUsingContext: aContextMenuItem [
	<return: #BlElement or: nil>
	^ GtWardleyMapUtility newColorLabelElement text: (self text ifNil: [ '' ])
]

{ #category : #accessing }
GtWardleyMapLabelMenuItem >> text [
	^ text
]

{ #category : #accessing }
GtWardleyMapLabelMenuItem >> text: anObject [
	text := anObject
]
