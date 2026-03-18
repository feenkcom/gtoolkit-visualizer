Class {
	#name : #GtWardleyMapAddNodeChange,
	#superclass : #GtWardleyMapNodeChange,
	#instVars : [
		'newNode'
	],
	#category : #'GToolkit-WardleyMap-Changes'
}

{ #category : #'as yet unclassified' }
GtWardleyMapAddNodeChange class >> onMap: aMap andNode: aNode [
	| undo |
	undo := self onMap: aMap.
	undo color: aNode color.
	undo evolution: aNode evolution.
	undo evolvedColor: aNode evolvedColor.
	undo evolvedEvolution: aNode evolvedEvolution.
	undo evolvedLabel: aNode evolvedLabel.
	undo evolvedLabelCoordinate: aNode evolvedLabelCoordinate.
	undo evolvedSize: aNode evolvedSize.
	aNode hasId ifTrue: [ undo id: aNode id ].
	undo isEvolvedLabelVisible: aNode isEvolvedLabelVisible.
	undo isEvolveVisible: aNode isEvolveVisible.
	undo isPipelineVisible: aNode isPipelineVisible.
	undo label: aNode label.
	undo labelCoordinate: aNode labelModel coordinate.
	undo pipelineCoordinate: aNode pipelineCoordinate.
	undo visibility: aNode visibility.
	^ undo
]

{ #category : #private }
GtWardleyMapAddNodeChange >> executeNotifying: aBlock [
	| undo |
	newNode := GtWardleyMapNodeModel new.
	color ifNotNil: [ newNode color: color ].
	evolution ifNotNil: [ newNode evolution: evolution ].
	evolvedColor ifNotNil: [ newNode evolvedColor: evolvedColor ].
	evolvedEvolution ifNotNil: [ newNode evolvedEvolution: evolvedEvolution ].
	evolvedLabel ifNotNil: [ newNode evolvedLabel: evolvedLabel ].
	evolvedLabelCoordinate
		ifNotNil: [ newNode evolvedLabelCoordinate: evolvedLabelCoordinate ].
	evolvedSize ifNotNil: [ newNode evolvedSize: evolvedSize ].
	id ifNotNil: [ newNode id: id ].
	isEvolvedLabelVisible
		ifNotNil: [ newNode isEvolvedLabelVisible: isEvolvedLabelVisible ].
	isEvolveVisible ifNotNil: [ newNode isEvolveVisible: isEvolveVisible ].
	isPipelineVisible ifNotNil: [ newNode isPipelineVisible: isPipelineVisible ].
	label ifNotNil: [ newNode label: label ].
	labelCoordinate ifNotNil: [ newNode labelModel coordinate: labelCoordinate ].
	pipelineCoordinate ifNotNil: [ newNode pipelineCoordinate: pipelineCoordinate ].
	visibility ifNotNil: [ newNode visibility: visibility ].
	map addNode: newNode.
	undo := (GtWardleyMapRemoveNodeChange onMap: map) node: newNode.
	^ undo
]

{ #category : #accessing }
GtWardleyMapAddNodeChange >> newNode [
	^ newNode
]
