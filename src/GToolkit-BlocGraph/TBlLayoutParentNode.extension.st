Extension { #name : #TBlLayoutParentNode }

{ #category : #'*GToolkit-BlocGraph' }
TBlLayoutParentNode >> withGraphNodes [
	^ self withFilter: GtGraphLayoutNodeFilter uniqueInstance
]
