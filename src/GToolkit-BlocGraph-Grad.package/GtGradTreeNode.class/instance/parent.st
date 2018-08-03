accessing
parent
	<return: #GtGradTreeNode>

	self
		assert: [ self hasParent ]
		description: [ 'Can not access parent if it does not exist' ].

	^ parent