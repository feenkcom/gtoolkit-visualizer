Class {
	#name : #GtWardleyMapCompositeChange,
	#superclass : #RBCompositeRefactoryChange,
	#instVars : [
		'map'
	],
	#category : #'GToolkit-WardleyMap-Changes'
}

{ #category : #copying }
GtWardleyMapCompositeChange >> copyForPreview [
	| copy previewMap mapping |
	previewMap := map copy.
	mapping := IdentityDictionary new.
	map nodes with: previewMap nodes do: [ :node :pre | mapping at: node put: pre ].
	map edges with: previewMap edges do: [ :edge :pre | mapping at: edge put: pre ].
	map notes with: previewMap notes do: [ :note :pre | mapping at: note put: pre ].
	copy := self class new.
	copy map: previewMap.
	copy
		changes: (changes collect: [ :each | each copyForPreviewIn: previewMap using: mapping ]).
	^ copy
]

{ #category : #accessing }
GtWardleyMapCompositeChange >> map [
	^ map
]

{ #category : #accessing }
GtWardleyMapCompositeChange >> map: anObject [
	map := anObject
]

{ #category : #copying }
GtWardleyMapCompositeChange >> previewMap [
	| previewChange |
	previewChange := self copyForPreview.
	previewChange execute.
	^ previewChange map
]
