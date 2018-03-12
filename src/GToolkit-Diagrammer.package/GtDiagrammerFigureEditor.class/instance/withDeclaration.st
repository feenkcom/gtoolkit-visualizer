instance creation
withDeclaration
	| aDeclaration |
	
	aDeclaration := self newDeclaration.
	editorDeclarations add: aDeclaration.
	
	^ aDeclaration