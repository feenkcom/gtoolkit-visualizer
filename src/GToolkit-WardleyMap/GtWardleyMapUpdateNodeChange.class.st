Class {
	#name : #GtWardleyMapUpdateNodeChange,
	#superclass : #GtWardleyMapNodeChange,
	#instVars : [
		'node'
	],
	#category : #'GToolkit-WardleyMap-Changes'
}

{ #category : #private }
GtWardleyMapUpdateNodeChange >> executeNotifying: aBlock [
	| undo |
	undo := self copy.

	color
		ifNotNil: [ undo color: node color.
			node color: color ].
	evolution
		ifNotNil: [ undo evolution: node evolution.
			node evolution: evolution ].
	evolvedColor
		ifNotNil: [ undo evolvedColor: node evolvedColor.
			node evolvedColor: evolvedColor ].
	evolvedEvolution
		ifNotNil: [ undo evolvedEvolution: node evolvedEvolution.
			node evolvedEvolution: evolvedEvolution ].
	evolvedLabel
		ifNotNil: [ undo evolvedLabel: node evolvedLabel.
			node evolvedLabel: evolvedLabel ].
	evolvedLabelCoordinate
		ifNotNil: [ undo evolvedLabelCoordinate: node evolvedLabelCoordinate.
			node evolvedLabelCoordinate: evolvedLabelCoordinate ].
	evolvedSize
		ifNotNil: [ undo evolvedSize: node evolvedSize.
			node evolvedSize: evolvedSize ].
	id
		ifNotNil: [ undo id: node id.
			node id: id ].
	isEvolvedLabelVisible
		ifNotNil: [ undo isEvolvedLabelVisible: node isEvolvedLabelVisible.
			node isEvolvedLabelVisible: isEvolvedLabelVisible ].
	isEvolveVisible
		ifNotNil: [ undo isEvolveVisible: node isEvolveVisible.
			node isEvolveVisible: isEvolveVisible ].
	isPipelineVisible
		ifNotNil: [ undo isPipelineVisible: node isPipelineVisible.
			node isPipelineVisible: isPipelineVisible ].
	label
		ifNotNil: [ undo label: node label.
			node label: label ].
	labelCoordinate
		ifNotNil: [ undo labelCoordinate: node labelCoordinate.
			node labelModel coordinate: labelCoordinate ].
	pipelineCoordinate
		ifNotNil: [ undo pipelineCoordinate: node pipelineCoordinate.
			node pipelineCoordinate: pipelineCoordinate ].
	visibility
		ifNotNil: [ undo visibility: node visibility.
			node visibility: visibility ].

	^ undo
]

{ #category : #accessing }
GtWardleyMapUpdateNodeChange >> node [
	^ node
]

{ #category : #accessing }
GtWardleyMapUpdateNodeChange >> node: anObject [
	node := anObject
]
