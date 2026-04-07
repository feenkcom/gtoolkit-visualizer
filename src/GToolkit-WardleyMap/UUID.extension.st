Extension { #name : #UUID }

{ #category : #'*GToolkit-WardleyMap' }
UUID class >> gtFromString: aString [
	aString size = 36 ifTrue: [ ^ self fromString: aString ].
	^ (aString
		allSatisfy: [ :each | (each between: $0 and: $9) or: [ each asUppercase between: $A and: $Z ] ])
		ifTrue: [ self fromString36: aString ]
		ifFalse: [ self fromBase64EncodedString: aString ]
]
