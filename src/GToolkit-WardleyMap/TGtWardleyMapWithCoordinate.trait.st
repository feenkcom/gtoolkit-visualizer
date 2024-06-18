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
	"Note: x-value is NOT Wardley script maturity value.
	We reuse the coordinate code in couple of cases, and only some of them
	have relation with the Wardley maturity value. In those cases maturity == x."

	^ self coordinate x
]

{ #category : #'api - coordinate' }
TGtWardleyMapWithCoordinate >> x: aNumber [
	"Note: x-value is NOT Wardley script maturity value.
	We reuse the coordinate code in couple of cases, and only some of them
	have relation with the Wardley maturity value. In those cases maturity == x."

	self coordinate: aNumber @ self coordinate y
]

{ #category : #'api - coordinate' }
TGtWardleyMapWithCoordinate >> y [
	"Note: y-value is NOT Wardley script visibility value.
	We reuse the coordinate code in couple of cases, and only some of them
	have relation with the Wardley visibility value. In such cases visibility == 1 - y.
	In addition, in case of inner-nodes (nodes that are part of a pipeline), 
	the y-value is same as the pipeline-node y-value, therefore inner-node y-value 
	is not equal to the on-screen y-value, neither is equal to 1 - visibility."

	^ self coordinate y
]

{ #category : #'api - coordinate' }
TGtWardleyMapWithCoordinate >> y: aNumber [
	"Note: y-value is NOT Wardley script visibility value.
	We reuse the coordinate code in couple of cases, and only some of them
	have relation with the Wardley visibility value. In such cases visibility == 1 - y.
	In addition, in case of inner-nodes (nodes that are part of a pipeline), 
	the y-value is same as the pipeline-node y-value, therefore inner-node y-value 
	is not equal to the on-screen y-value, neither is equal to 1 - visibility."

	self coordinate: (self coordinate x @ aNumber)
]
