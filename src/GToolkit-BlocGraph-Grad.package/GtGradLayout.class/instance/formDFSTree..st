measure
formDFSTree: aRootElement
	| aDFSTree |
	aDFSTree := IdentityDictionary new.
	self dfs: aRootElement visited: Set new tree: aDFSTree.
	^ aDFSTree.
	