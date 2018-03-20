comparing
= anObject
	self == anObject
		ifTrue: [ ^ true ].	
	
	self class = anObject class
		ifTrue: [ ^ true ].

	(anObject isKindOf: self create class)
		ifTrue: [ ^ self compareTo: anObject ].
	
	^ false