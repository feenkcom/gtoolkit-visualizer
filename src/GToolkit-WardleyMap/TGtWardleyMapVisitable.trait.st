Trait {
	#name : #TGtWardleyMapVisitable,
	#category : #'GToolkit-WardleyMap-Visitor'
}

{ #category : #visiting }
TGtWardleyMapVisitable >> accept: aWardleyMapVisitor [
	^ self explicitRequirement
]
