Trait {
	#name : #TGtWardleyMapWithIsVisible,
	#instVars : [
		'isVisible'
	],
	#category : #'GToolkit-WardleyMap-! Models'
}

{ #category : #'api - visibility' }
TGtWardleyMapWithIsVisible >> isVisible [
	<return: #Boolean>

	^ isVisible ifNil: [ true ]
]

{ #category : #'api - visibility' }
TGtWardleyMapWithIsVisible >> isVisible: aNewBoolean [
	(self isVisible = aNewBoolean)
		ifTrue: [ ^ self ].

	isVisible := aNewBoolean.
	self notifyVisibilityChanged.
]

{ #category : #'api - visibility' }
TGtWardleyMapWithIsVisible >> notifyVisibilityChanged [
	self explicitRequirement
]
