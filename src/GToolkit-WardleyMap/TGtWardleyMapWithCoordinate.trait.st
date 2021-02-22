Trait {
	#name : #TGtWardleyMapWithCoordinate,
	#instVars : [
		'coordinate'
	],
	#category : #'GToolkit-WardleyMap-! Models'
}

{ #category : #'api - coordinate' }
TGtWardleyMapWithCoordinate >> coordinate [
	<return: #Point>

	^ coordinate
]

{ #category : #'api - coordinate' }
TGtWardleyMapWithCoordinate >> coordinate: aNewCoordinate [
	(self coordinate closeTo: aNewCoordinate)
		ifTrue: [ ^ self ].

	coordinate := aNewCoordinate.
	self notifyCoordinateChanged.
]

{ #category : #'api - coordinate' }
TGtWardleyMapWithCoordinate >> notifyCoordinateChanged [
	self explicitRequirement
]
