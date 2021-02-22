Trait {
	#name : #TGtWardleyMapWithWidth,
	#instVars : [
		'width'
	],
	#category : #'GToolkit-WardleyMap-! Models'
}

{ #category : #'api - width' }
TGtWardleyMapWithWidth >> notifyWidthChanged [
	self explicitRequirement
]

{ #category : #'api - width' }
TGtWardleyMapWithWidth >> width [
	<return: #Number>

	^ width
]

{ #category : #'api - width' }
TGtWardleyMapWithWidth >> width: aNewWidth [
	(self width closeTo: aNewWidth)
		ifTrue: [ ^ self ].

	width := aNewWidth.
	self notifyWidthChanged.
]
