actions
edit: anElement
	| theEditors |
	
	editor removeChildren.
	
	theEditors := GtDiagrammerFigureEditor editorsOf: anElement.
		
	theEditors do: [ :anEditor |
		| aTitle |
		aTitle := BlTextEditElement new text: (anEditor title asRopedText).
		aTitle margin: (BlInsets all: 5). 
		editor addChild: aTitle.
		editor addChild: anEditor editor ]