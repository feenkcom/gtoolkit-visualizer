Class {
	#name : #GtDiagrammerTitledCard,
	#superclass : #GtDiagrammerCard,
	#instVars : [
		'titleElement',
		'contentElement'
	],
	#category : 'GToolkit-Diagrammer-UI'
}

{ #category : #'api - accessing' }
GtDiagrammerTitledCard >> content [
	<return: #BlElement>
	
	^ contentElement
]

{ #category : #'api - accessing' }
GtDiagrammerTitledCard >> content: anElement [
	contentElement removeFromParent.
	contentElement := anElement.
	self addChild: contentElement as: #content
]

{ #category : #initialization }
GtDiagrammerTitledCard >> initialize [
	super initialize.
	
	self margin: (BlInsets top: 0 left: 0 bottom: 20 right: 0).
	self padding: (BlInsets all: 5).
	self layout: BlLinearLayout vertical.

	titleElement := BlTextElement new.
	titleElement margin: (BlInsets top: 5 right: 5 bottom: 0 left: 5). 
	self addChildFirst: titleElement as: #title.
	
	contentElement := BlElement new.
	self content: contentElement
]

{ #category : #'api - accessing' }
GtDiagrammerTitledCard >> title: aString [
	| aText |
	
	aText := aString asString asRopedText.
	aText attributes: {
		BrTextForegroundAttribute paint: Color gray.
		BrFontWeightAttribute thin }.
	
	titleElement text: aText
]

{ #category : #'api - accessing' }
GtDiagrammerTitledCard >> titleTextDo: aBlock [
	titleElement textDo: aBlock
]
