editing
closeEditor
	sidebar
		childNamed: #editor
		ifFound: [ :anEditorList | anEditorList dataSource editors: #() ]
		ifNone: [ self error: 'Editor list must exist' ]