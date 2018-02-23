instance creation
editorsOf: anObject
	^ ((Pragma
		allNamed: #diagrammerEditor:
		from: anObject class
		to: BlElement)
		sorted: [ :a :b | (a argumentAt: 1) < (b argumentAt: 1) ])
		collect: [ :aPragma | 
			| anEditor |
			anEditor := GtDiagrammerFigureEditor new.
			anObject perform: aPragma methodSelector with: anEditor.
			anEditor ]