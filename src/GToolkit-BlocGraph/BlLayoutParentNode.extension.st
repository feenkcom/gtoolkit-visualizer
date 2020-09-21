Extension { #name : #BlLayoutParentNode }

{ #category : #'*GToolkit-BlocGraph' }
BlLayoutParentNode >> withGraphEdges [
	^ self copy children: self children withGraphEdges
]
