editing
edit: anElement
	| theEditors |
	
	theEditors := GtDiagrammerFigureEditor editorsOf: anElement.

	sidebar
		childNamed: #editor
		ifFound: [ :anEditorList | anEditorList dataSource editors: theEditors ]
		ifNone: [ self error: 'Editor list must exist' ]