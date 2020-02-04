Extension { #name : #BlElement }

{ #category : #'*GToolkit-BlocGraph' }
BlElement >> graph [
	^ self userData
		at: #graph 
		ifAbsentPut: [ GtGraphElementContext on: self ]
]
