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

{ #category : #'api - coordinate' }
TGtWardleyMapWithCoordinate >> x [
	^ self coordinate x
]

{ #category : #'api - coordinate' }
TGtWardleyMapWithCoordinate >> x: aNumber [
	self coordinate: (aNumber @ self coordinate y)
]

{ #category : #'api - coordinate' }
TGtWardleyMapWithCoordinate >> y [
	^ self coordinate y
]

{ #category : #'api - coordinate' }
TGtWardleyMapWithCoordinate >> y: aNumber [
	"Note: y-value is NOT Wardley script visibility value.
	We reuse the coordinate code in couple of cases, and only some of them
	have relation with the Wardley visibility value (visibility == 1 - y)."

	self coordinate: (self coordinate x @ aNumber)
]
