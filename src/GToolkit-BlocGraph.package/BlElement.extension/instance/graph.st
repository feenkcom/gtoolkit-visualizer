*GToolkit-BlocGraph
graph
	^ self userData
		at: #blocGraph 
		ifAbsentPut: [ GtGraphElement on: self ]