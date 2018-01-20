api
isEdge
	^ self userData at: #isMondrianEdge ifAbsent: [ false ]