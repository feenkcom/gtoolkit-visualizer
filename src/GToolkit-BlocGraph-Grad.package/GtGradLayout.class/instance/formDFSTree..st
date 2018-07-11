measure
formDFSTree: aRootElement
	| aDFSTree |
	aDFSTree := IdentityDictionary new.
	self dfs: aRootElement visited: OrderedCollection new tree: aDFSTree.
	^ aDFSTree.
	