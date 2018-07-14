deprecated
childrenContainers
	^ self userData 
		at: #mondrianChildrenContainers
		ifAbsentPut: [ Dictionary new ]