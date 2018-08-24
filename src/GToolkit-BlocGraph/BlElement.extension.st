Extension { #name : #BlElement }

{ #category : #'*GToolkit-BlocGraph' }
BlElement >> graph [
	^ self userData
		at: #blocGraph 
		ifAbsentPut: [ GtGraphElement on: self ]
]
