actions
edit: anElement
	| theEditors |
	
	editor removeChildren.
	
	theEditors := ((Pragma
		allNamed: #diagrammerEditor:
		in: anElement class)
		sorted: [ :a :b | (a argumentAt: 1) < (b argumentAt: 1) ])
		collect: [ :aPragma | 
			| anEditor |
			anEditor := GtDiagrammerFigureEditor new.
			anElement perform: aPragma methodSelector with: anEditor.
			anEditor ].
		
	theEditors do: [ :anEditor |
		| aTitle |
		aTitle := BlTextEditElement new text: (anEditor title asRopedText).
		aTitle margin: (BlInsets all: 5). 
		editor addChild: aTitle.
		editor addChild: anEditor editor ]