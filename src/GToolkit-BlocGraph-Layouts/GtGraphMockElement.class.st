Class {
	#name : #GtGraphMockElement,
	#superclass : #Object,
	#instVars : [
		'realElement',
		'position'
	],
	#category : #'GToolkit-BlocGraph-Layouts-Layouts'
}

{ #category : #action }
GtGraphMockElement >> applyToRealElement [
	realElement translateTo: position
]

{ #category : #'as yet unclassified' }
GtGraphMockElement >> extent [
	^ realElement extent
]

{ #category : #'as yet unclassified' }
GtGraphMockElement >> height [
	^ realElement height
]

{ #category : #accessing }
GtGraphMockElement >> position [
	^ position
]

{ #category : #accessing }
GtGraphMockElement >> realElement [
	^ realElement
]

{ #category : #accessing }
GtGraphMockElement >> realElement: rtElement [
	realElement := rtElement.
	position := rtElement position
]

{ #category : #actions }
GtGraphMockElement >> translateTo: aPosition [
	position := aPosition
]

{ #category : #'as yet unclassified' }
GtGraphMockElement >> view [
	^ realElement view
]

{ #category : #'as yet unclassified' }
GtGraphMockElement >> width [
	^ realElement width
]
