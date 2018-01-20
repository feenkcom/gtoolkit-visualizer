*GToolkit-BlocGraph
nodeChildren
	^ self element children select: [ :each | each graph isNode ]