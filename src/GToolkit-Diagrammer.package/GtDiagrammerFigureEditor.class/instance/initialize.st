initialization
initialize
	super initialize.

	editorDeclarations := OrderedCollection new.

	title := ''.
	editorBlock := [ BlElement new size: 0@0 ].
	condition := true