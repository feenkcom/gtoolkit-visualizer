initialization
initializeEditor
	editor := BrTextEditor new.
	editorElement := BrEditorElement new.
	editorElement editor: editor.
	editorElement beDiagrammerSelectionLeaf.
	editorElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent.
		c frame horizontal alignCenter.
		c frame vertical alignCenter.
		c padding: (BlInsets all: 5)].
	
	self addChild: editorElement