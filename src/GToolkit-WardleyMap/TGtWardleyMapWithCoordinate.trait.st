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
TGtWardleyMapWithCoordinate >> coordinate: aPoint [
	(coordinate closeTo: aPoint)
		ifTrue: [ ^ self ].

	coordinate := aPoint.
	self notifyMoved
]

{ #category : #'api - coordinate' }
TGtWardleyMapWithCoordinate >> notifyMoved [
	self explicitRequirement
]
