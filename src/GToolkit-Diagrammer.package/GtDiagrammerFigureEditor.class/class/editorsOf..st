instance creation
editorsOf: anObject
	^ ((Pragma
		allNamed: #diagrammerEditor:
		in: anObject class)
		sorted: [ :a :b | (a argumentAt: 1) < (b argumentAt: 1) ])
		collect: [ :aPragma | 
			| anEditor |
			anEditor := GtDiagrammerFigureEditor new.
			anObject perform: aPragma methodSelector with: anEditor.
			anEditor ]