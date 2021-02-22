Trait {
	#name : #TGtWardleyMapWithArrow,
	#instVars : [
		'arrow'
	],
	#category : #'GToolkit-WardleyMap-! Models'
}

{ #category : #'api - arrow' }
TGtWardleyMapWithArrow >> arrow [
	<return: #Boolean>

	^ arrow
]

{ #category : #'api - arrow' }
TGtWardleyMapWithArrow >> arrow: aNewArrow [
	self arrow = aNewArrow
		ifTrue: [ ^ self ].

	arrow := aNewArrow.
	self notifyArrowChanged.
]

{ #category : #'api - arrow' }
TGtWardleyMapWithArrow >> notifyArrowChanged [
	self explicitRequirement
]
