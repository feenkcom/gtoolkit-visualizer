Trait {
	#name : #TGtWardleyMapWithCoordinate,
	#instVars : [
		'coordinate'
	],
	#category : #'GToolkit-WardleyMap-! Models'
}

{ #category : #accessing }
TGtWardleyMapWithCoordinate >> coordinate [
	<return: #Point>

	^ coordinate
]

{ #category : #accessing }
TGtWardleyMapWithCoordinate >> coordinate: aPoint [
	coordinate := aPoint
]
