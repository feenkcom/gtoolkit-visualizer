Trait {
	#name : #TGtWardleyMapVisitable,
	#category : #'GToolkit-WardleyMap-Visitor'
}

{ #category : #visiting }
TGtWardleyMapVisitable >> acceptVisitor: aWardleyMapVisitor [
	^ self explicitRequirement
]
