deprecated
identifyChildrenContainers
	| childrenContainers |
	childrenContainers := Dictionary new.
	self element
		allChildrenBreadthFirstDo: [ :each | 
			each graph isChildrenContainer ifTrue: [ 
				childrenContainers at: each graph childrenContainerName put: each ] ].
	childrenContainers isEmpty ifTrue: [ 
		childrenContainers at: #default put: self element ].
	self userData at: #mondrianChildrenContainers put: childrenContainers