Class {
	#name : #GtWardleyMapCompositeChange,
	#superclass : #RBCompositeRefactoryChange,
	#instVars : [
		'originalMap',
		'map'
	],
	#category : #'GToolkit-WardleyMap-Changes'
}

{ #category : #copying }
GtWardleyMapCompositeChange >> copyForPreview [
	| copy previewMap mapping |
	previewMap := self originalMap copy.
	mapping := IdentityDictionary new.
	self originalMap nodes
		with: previewMap nodes
		do: [ :node :pre | mapping at: node put: pre ].
	self originalMap edges
		with: previewMap edges
		do: [ :edge :pre | mapping at: edge put: pre ].
	self originalMap notes
		with: previewMap notes
		do: [ :note :pre | mapping at: note put: pre ].
	copy := self class new.
	copy map: previewMap.
	copy
		changes: (changes collect: [ :each | each copyForPreviewIn: previewMap using: mapping ]).
	^ copy
]

{ #category : #'as yet unclassified' }
GtWardleyMapCompositeChange >> executeNotifying: aBlock [
	| undo |
	undo := super executeNotifying: aBlock.
	undo originalMap: map copy.
	^ undo
]

{ #category : #accessing }
GtWardleyMapCompositeChange >> gtDiffElementClass [
	^ GtWardleyMapCompositeChangeDiffElement
]

{ #category : #'as yet unclassified' }
GtWardleyMapCompositeChange >> gtHighlightedModificationsIn: aView [
	<gtView>
	^ aView forward
		title: 'Highlighted changes';
		object: [ self highlightedModificationsInPreview ];
		view: #gtLiveFor:
]

{ #category : #accessing }
GtWardleyMapCompositeChange >> highlightedModificationsInPreview [
	| copy |
	copy := self copyForPreview.
	self changes ifNil: [ ^ copy map ].
	copy changes do: [ :each | each highlightModifications ].
	^ copy map
]

{ #category : #accessing }
GtWardleyMapCompositeChange >> map [
	^ map
]

{ #category : #accessing }
GtWardleyMapCompositeChange >> map: anObject [
	map := anObject
]

{ #category : #accessing }
GtWardleyMapCompositeChange >> originalMap [
	^ originalMap ifNil: [ originalMap := map copy ]
]

{ #category : #accessing }
GtWardleyMapCompositeChange >> originalMap: anObject [
	originalMap := anObject
]

{ #category : #copying }
GtWardleyMapCompositeChange >> previewMap [
	| previewChange |
	previewChange := self copyForPreview.
	previewChange execute.
	^ previewChange map
]
