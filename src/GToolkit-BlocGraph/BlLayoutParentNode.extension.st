Extension { #name : #BlLayoutParentNode }

{ #category : #'*GToolkit-BlocGraph' }
BlLayoutParentNode >> withGraphEdges [
	^ BlLayoutParentNodeWithEdges new
		parentNode: self;
		children: self children withGraphEdges
]
