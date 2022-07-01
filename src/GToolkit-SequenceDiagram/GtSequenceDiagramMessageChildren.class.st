Class {
	#name : #GtSequenceDiagramMessageChildren,
	#superclass : #Object,
	#instVars : [
		'edgeElement',
		'fromNodeElement',
		'toNodeElement',
		'nodeElements'
	],
	#category : #'GToolkit-SequenceDiagram-UI'
}

{ #category : #accessing }
GtSequenceDiagramMessageChildren >> at: anIndex putElement: anElement [
	nodeElements at: anIndex put: anElement
]

{ #category : #accessing }
GtSequenceDiagramMessageChildren >> at: anIndex putFromNodeElement: anElement [
	fromNodeElement := anElement.
	nodeElements at: anIndex put: anElement
]

{ #category : #accessing }
GtSequenceDiagramMessageChildren >> at: anIndex putToNodeElement: anElement [
	toNodeElement := anElement.
	nodeElements at: anIndex put: anElement
]

{ #category : #accessing }
GtSequenceDiagramMessageChildren >> edgeElement [

	^ edgeElement
]

{ #category : #accessing }
GtSequenceDiagramMessageChildren >> edgeElement: anObject [

	edgeElement := anObject
]

{ #category : #accessing }
GtSequenceDiagramMessageChildren >> fromNodeElement [

	^ fromNodeElement
]

{ #category : #accessing }
GtSequenceDiagramMessageChildren >> nodeElements [

	^ nodeElements
]

{ #category : #accessing }
GtSequenceDiagramMessageChildren >> positions: anInteger [
	self
		assert: [ nodeElements isNil ]
		description: [ self className , ' nodeElements can be initialized only once.' ].
	nodeElements := Array new: anInteger
]

{ #category : #accessing }
GtSequenceDiagramMessageChildren >> toNodeElement [

	^ toNodeElement
]
