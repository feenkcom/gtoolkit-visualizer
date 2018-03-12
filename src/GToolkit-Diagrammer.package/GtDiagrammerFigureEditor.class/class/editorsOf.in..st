instance creation
editorsOf: anObject in: aComposite
	((Pragma
		allNamed: #diagrammerEditor:
		from: anObject class
		to: BlElement)
		sorted: [ :a :b | (a argumentAt: 1) < (b argumentAt: 1) ])
		do: [ :aPragma | anObject perform: aPragma methodSelector with: aComposite ]