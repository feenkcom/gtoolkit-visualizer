Extension { #name : #BlElement }

{ #category : #'*GToolkit-WardleyMap' }
BlElement >> wardley [
	^ self userData
		at: #wardley 
		ifAbsentPut: [ GtWardleyMapElementContext on: self ]
]
