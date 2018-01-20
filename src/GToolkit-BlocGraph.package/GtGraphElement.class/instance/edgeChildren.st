*GToolkit-BlocGraph
edgeChildren
	^ self element children select: [ :each | each graph isEdge ]