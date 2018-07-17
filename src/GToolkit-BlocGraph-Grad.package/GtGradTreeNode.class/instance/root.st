accessing
root
	"Return the root of this tree"
	<return: #GtGradTreeNode>
	
	^ self hasParent
		ifTrue: [ self parent root ]
		ifFalse: [ self ]