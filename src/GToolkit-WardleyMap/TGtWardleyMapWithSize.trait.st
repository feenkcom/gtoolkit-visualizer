Trait {
	#name : #TGtWardleyMapWithSize,
	#instVars : [
		'size'
	],
	#category : #'GToolkit-WardleyMap-! Models'
}

{ #category : #'api - size' }
TGtWardleyMapWithSize >> height [
	^ self size y
]

{ #category : #'api - size' }
TGtWardleyMapWithSize >> height: aNumber [
	self size: self width @ aNumber
]

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

{ #category : #'api - size' }
TGtWardleyMapWithSize >> width [
	^ self size x
]

{ #category : #'api - size' }
TGtWardleyMapWithSize >> width: aNumber [
	self size: aNumber @ self height
]
