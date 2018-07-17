api - visiting
accept: aVisitor
	aVisitor visitForest: self.
	self trees do: [ :aTreeNode | aTreeNode accept: aVisitor ]