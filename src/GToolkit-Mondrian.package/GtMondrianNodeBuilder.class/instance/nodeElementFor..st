scripting
nodeElementFor: anObject
		| nodeElement |
	nodeElement := elementBlock 
		ifNotNil: [ elementBlock cull: anObject cull: self defaultNodeElement ]
		ifNil: [ self defaultNodeElement ].
	nodeElement graph model: anObject.
	nodeElement graph beNode.
	^ nodeElement 