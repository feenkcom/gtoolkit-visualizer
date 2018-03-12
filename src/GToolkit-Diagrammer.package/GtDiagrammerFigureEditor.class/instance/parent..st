private - accessing
parent: aGtDiagrammerFigureEditor
	
	self
		assert: [ self hasParent not or: [ self parent == aGtDiagrammerFigureEditor ] ]
		description: [ 'I already have a different parent editor' ].

	parent := aGtDiagrammerFigureEditor