editing
edit: anElement
	| theEditors |
	
	theEditors := GtDiagrammerFigureEditor editorsOf: anElement.
	
	sidebar
		childrenContaner: #editor
		ifFound: [ :anEditorList | anEditorList dataSource editors: theEditors ]
		ifNone: [ self error: 'Editor list must exist' ]