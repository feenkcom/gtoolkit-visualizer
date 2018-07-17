api - adding
addAll: aCollectionOfNodes
	| aChildDepth |
	
	aChildDepth := self depth + 1.	
	aCollectionOfNodes
		do: [ :aTreeNode |
			aTreeNode parent: self.
			aTreeNode depth: aChildDepth ].

	self nodes addAll: aCollectionOfNodes