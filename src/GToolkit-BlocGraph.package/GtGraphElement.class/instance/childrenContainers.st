*GToolkit-BlocGraph
childrenContainers
	^ self userData 
		at: #mondrianChildrenContainers
		ifAbsentPut: [ Dictionary new ]