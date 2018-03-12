accessing
parent
	<return: #GtDiagrammerFigureEditor>
	self
		assert: [ self hasParent ]
		description: [ 'Parent can not be accessed if it does not exist' ].

	^ parent