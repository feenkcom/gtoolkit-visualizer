api
isNode
	^ self userData at: #isMondrianNode ifAbsent: [ false ]