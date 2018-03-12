api - script
with
	| anEditor aDeclaration |
	
	anEditor := self class new.

	aDeclaration := self withDeclaration.
	aDeclaration editor: anEditor.

	^ anEditor