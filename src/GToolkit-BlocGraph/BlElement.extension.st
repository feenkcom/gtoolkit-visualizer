Extension { #name : #BlElement }

{ #category : #'*GToolkit-BlocGraph' }
BlElement >> graph [
	^ self userData
		at: #blocGraph 
		ifAbsentPut: [ GtGraphElementContext on: self ]
]
