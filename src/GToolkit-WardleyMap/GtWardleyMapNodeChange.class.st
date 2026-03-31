Class {
	#name : #GtWardleyMapNodeChange,
	#superclass : #GtWardleyMapChange,
	#instVars : [
		'evolution',
		'color',
		'labelCoordinate',
		'isPipelineVisible',
		'isEvolveVisible',
		'pipelineCoordinate',
		'id',
		'visibility',
		'label',
		'evolvedLabel',
		'evolvedColor',
		'evolvedSize',
		'evolvedEvolution',
		'evolvedLabelCoordinate',
		'isEvolvedLabelVisible'
	],
	#category : #'GToolkit-WardleyMap-Changes'
}

{ #category : #accessing }
GtWardleyMapNodeChange >> color [
	^ color
]

{ #category : #accessing }
GtWardleyMapNodeChange >> color: aColor [
	color := aColor
]

{ #category : #accessing }
GtWardleyMapNodeChange >> evolution [
	^ evolution
]

{ #category : #accessing }
GtWardleyMapNodeChange >> evolution: aNumber [
	evolution := aNumber
]

{ #category : #accessing }
GtWardleyMapNodeChange >> evolvedColor [
	^ evolvedColor
]

{ #category : #accessing }
GtWardleyMapNodeChange >> evolvedColor: aColor [
	evolvedColor := aColor
]

{ #category : #accessing }
GtWardleyMapNodeChange >> evolvedEvolution [
	^ evolvedEvolution
]

{ #category : #accessing }
GtWardleyMapNodeChange >> evolvedEvolution: aNumber [
	evolvedEvolution := aNumber
]

{ #category : #accessing }
GtWardleyMapNodeChange >> evolvedLabel [
	^ evolvedLabel
]

{ #category : #accessing }
GtWardleyMapNodeChange >> evolvedLabel: aString [
	evolvedLabel := aString
]

{ #category : #accessing }
GtWardleyMapNodeChange >> evolvedLabelCoordinate [
	^ evolvedLabelCoordinate
]

{ #category : #accessing }
GtWardleyMapNodeChange >> evolvedLabelCoordinate: aPoint [
	evolvedLabelCoordinate := aPoint
]

{ #category : #accessing }
GtWardleyMapNodeChange >> evolvedSize [
	^ evolvedSize
]

{ #category : #accessing }
GtWardleyMapNodeChange >> evolvedSize: aPoint [
	evolvedSize := aPoint
]

{ #category : #accessing }
GtWardleyMapNodeChange >> highlightModifications [
	| highlight |
	self execute.
	highlight := GtWardleyMapHighlight new.
	self node addWardleyMapDecoratorModel: highlight
]

{ #category : #accessing }
GtWardleyMapNodeChange >> id [
	^ id
]

{ #category : #accessing }
GtWardleyMapNodeChange >> id: aUUID [
	id := aUUID
]

{ #category : #accessing }
GtWardleyMapNodeChange >> isEvolveVisible [
	^ isEvolveVisible
]

{ #category : #accessing }
GtWardleyMapNodeChange >> isEvolveVisible: aBoolean [
	isEvolveVisible := aBoolean
]

{ #category : #accessing }
GtWardleyMapNodeChange >> isEvolvedLabelVisible [
	^ isEvolvedLabelVisible
]

{ #category : #accessing }
GtWardleyMapNodeChange >> isEvolvedLabelVisible: aBoolean [
	isEvolvedLabelVisible := aBoolean
]

{ #category : #accessing }
GtWardleyMapNodeChange >> isPipelineVisible [
	^ isPipelineVisible
]

{ #category : #accessing }
GtWardleyMapNodeChange >> isPipelineVisible: aBoolean [
	isPipelineVisible := aBoolean
]

{ #category : #accessing }
GtWardleyMapNodeChange >> label [
	^ label
]

{ #category : #accessing }
GtWardleyMapNodeChange >> label: aString [
	label := aString
]

{ #category : #accessing }
GtWardleyMapNodeChange >> labelCoordinate [
	^ labelCoordinate
]

{ #category : #accessing }
GtWardleyMapNodeChange >> labelCoordinate: aPoint [
	labelCoordinate := aPoint
]

{ #category : #accessing }
GtWardleyMapNodeChange >> node [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtWardleyMapNodeChange >> pipelineCoordinate [
	^ pipelineCoordinate
]

{ #category : #accessing }
GtWardleyMapNodeChange >> pipelineCoordinate: aPoint [
	pipelineCoordinate := aPoint
]

{ #category : #accessing }
GtWardleyMapNodeChange >> visibility [
	^ visibility
]

{ #category : #accessing }
GtWardleyMapNodeChange >> visibility: aNumber [
	visibility := aNumber
]
