Class {
	#name : #GtWardleyMapAddNodeChange,
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
		'newNode'
	],
	#category : #'GToolkit-WardleyMap-Changes'
}

{ #category : #accessing }
GtWardleyMapAddNodeChange >> color [
	^ color
]

{ #category : #accessing }
GtWardleyMapAddNodeChange >> color: aColor [
	color := aColor
]

{ #category : #accessing }
GtWardleyMapAddNodeChange >> evolution [
	^ evolution
]

{ #category : #accessing }
GtWardleyMapAddNodeChange >> evolution: aNumber [
	evolution := aNumber
]

{ #category : #private }
GtWardleyMapAddNodeChange >> executeNotifying: aBlock [
	| undo |
	newNode := GtWardleyMapNodeModel new.
	color ifNotNil: [ newNode color: color ].
	evolution ifNotNil: [ newNode evolution: evolution ].
	id ifNotNil: [ newNode id: id ].
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
GtWardleyMapAddNodeChange >> id [
	^ id
]

{ #category : #accessing }
GtWardleyMapAddNodeChange >> id: aUUID [
	id := aUUID
]

{ #category : #accessing }
GtWardleyMapAddNodeChange >> isEvolveVisible [
	^ isEvolveVisible
]

{ #category : #accessing }
GtWardleyMapAddNodeChange >> isEvolveVisible: aBoolean [
	isEvolveVisible := aBoolean
]

{ #category : #accessing }
GtWardleyMapAddNodeChange >> isPipelineVisible [
	^ isPipelineVisible
]

{ #category : #accessing }
GtWardleyMapAddNodeChange >> isPipelineVisible: aBoolean [
	isPipelineVisible := aBoolean
]

{ #category : #accessing }
GtWardleyMapAddNodeChange >> label [
	^ label
]

{ #category : #accessing }
GtWardleyMapAddNodeChange >> label: aString [
	label := aString
]

{ #category : #accessing }
GtWardleyMapAddNodeChange >> labelCoordinate [
	^ labelCoordinate
]

{ #category : #accessing }
GtWardleyMapAddNodeChange >> labelCoordinate: aPoint [
	labelCoordinate := aPoint
]

{ #category : #accessing }
GtWardleyMapAddNodeChange >> newNode [
	^ newNode
]

{ #category : #accessing }
GtWardleyMapAddNodeChange >> pipelineCoordinate [
	^ pipelineCoordinate
]

{ #category : #accessing }
GtWardleyMapAddNodeChange >> pipelineCoordinate: aPoint [
	pipelineCoordinate := aPoint
]

{ #category : #accessing }
GtWardleyMapAddNodeChange >> visibility [
	^ visibility
]

{ #category : #accessing }
GtWardleyMapAddNodeChange >> visibility: aNumber [
	visibility := aNumber
]
