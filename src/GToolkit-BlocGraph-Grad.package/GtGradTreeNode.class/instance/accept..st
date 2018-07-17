api - visiting
accept: aVisitor
	self nodes do: [ :aTreeNode | aTreeNode accept: aVisitor ].
	
	aVisitor preVisitNode: self.
	
	aVisitor visitNode: self.
	
	self isRoot
		ifTrue: [ aVisitor visitRootNode: self ].
	
	self nodes
		ifEmpty: [ aVisitor visitLeafNode: self ]
		ifNotEmpty: [ aVisitor visitCompositeNode: self ].

	aVisitor postVisitNode: self.