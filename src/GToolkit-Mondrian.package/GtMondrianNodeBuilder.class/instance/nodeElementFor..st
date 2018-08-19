scripting
nodeElementFor: anObject
		| nodeElement |
	nodeElement := elementStencilBuilder 
		ifNotNil: [ elementStencilBuilder cull: anObject cull: self defaultNodeElement ]
		ifNil: [ self defaultNodeElement ].
	nodeElement graph model: anObject.
	nodeElement graph beNode.
	nodeElement addEventHandler: BlPullHandler new.

	^ nodeElement