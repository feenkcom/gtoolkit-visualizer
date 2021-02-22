Trait {
	#name : #TGtWardleyMapWithSize,
	#instVars : [
		'size'
	],
	#category : #'GToolkit-WardleyMap-! Models'
}

{ #category : #'api - size' }
TGtWardleyMapWithSize >> notifySizeChanged [
	self explicitRequirement
]

{ #category : #'api - size' }
TGtWardleyMapWithSize >> size [
	<return: #Point>

	^ size
]

{ #category : #'api - size' }
TGtWardleyMapWithSize >> size: aNewSize [
	(self size closeTo: aNewSize)
		ifTrue: [ ^ self ].

	size := aNewSize.
	self notifySizeChanged.
]
