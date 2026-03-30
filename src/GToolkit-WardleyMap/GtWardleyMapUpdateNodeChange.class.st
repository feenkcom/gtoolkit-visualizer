Class {
	#name : #GtWardleyMapUpdateNodeChange,
	#superclass : #GtWardleyMapNodeChange,
	#instVars : [
		'node'
	],
	#category : #'GToolkit-WardleyMap-Changes'
}

{ #category : #copying }
GtWardleyMapUpdateNodeChange >> copyForPreviewIn: previewMap using: mapping [
	| copy |
	copy := super copyForPreviewIn: previewMap using: mapping.
	node ifNotNil: [ copy node: (mapping at: node) ].
	^ copy
]

{ #category : #private }
GtWardleyMapUpdateNodeChange >> executeNotifying: aBlock [
	| undo |
	undo := self copy.

	color
		ifNotNil: [ undo color: self node color.
			self node color: color ].
	evolution
		ifNotNil: [ undo evolution: self node evolution.
			self node evolution: evolution ].
	evolvedColor
		ifNotNil: [ undo evolvedColor: self node evolvedColor.
			self node evolvedColor: evolvedColor ].
	evolvedEvolution
		ifNotNil: [ undo evolvedEvolution: self node evolvedEvolution.
			self node evolvedEvolution: evolvedEvolution ].
	evolvedLabel
		ifNotNil: [ undo evolvedLabel: self node evolvedLabel.
			self node evolvedLabel: evolvedLabel ].
	evolvedLabelCoordinate
		ifNotNil: [ undo evolvedLabelCoordinate: self node evolvedLabelCoordinate.
			self node evolvedLabelCoordinate: evolvedLabelCoordinate ].
	evolvedSize
		ifNotNil: [ undo evolvedSize: self node evolvedSize.
			self node evolvedSize: evolvedSize ].
	id
		ifNotNil: [ undo id: self node id.
			self node id: id ].
	isEvolvedLabelVisible
		ifNotNil: [ undo isEvolvedLabelVisible: self node isEvolvedLabelVisible.
			self node isEvolvedLabelVisible: isEvolvedLabelVisible ].
	isEvolveVisible
		ifNotNil: [ undo isEvolveVisible: self node isEvolveVisible.
			self node isEvolveVisible: isEvolveVisible ].
	isPipelineVisible
		ifNotNil: [ undo isPipelineVisible: self node isPipelineVisible.
			self node isPipelineVisible: isPipelineVisible ].
	label
		ifNotNil: [ undo label: self node label.
			self node label: label ].
	labelCoordinate
		ifNotNil: [ undo labelCoordinate: self node labelCoordinate.
			self node labelModel coordinate: labelCoordinate ].
	pipelineCoordinate
		ifNotNil: [ undo pipelineCoordinate: self node pipelineCoordinate.
			self node pipelineCoordinate: pipelineCoordinate ].
	visibility
		ifNotNil: [ undo visibility: self node visibility.
			self node visibility: visibility ].

	^ undo
]

{ #category : #accessing }
GtWardleyMapUpdateNodeChange >> node [
	^ node
		ifNil: [ node := map
					nodeWithId: id
					ifFound: [ :each | each ]
					ifNone: [  ] ]
]

{ #category : #accessing }
GtWardleyMapUpdateNodeChange >> node: anObject [
	node := anObject
]
