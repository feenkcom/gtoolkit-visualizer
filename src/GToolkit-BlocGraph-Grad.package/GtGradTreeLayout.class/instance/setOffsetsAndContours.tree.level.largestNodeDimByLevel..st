calculating
setOffsetsAndContours: aNodeElement tree: aDFSTree level: aLevel largestNodeDimByLevel: largestNodeDimByLevel
	
	"Perform the initial layout pass along all the nodes going from the root to the leafs"
	
	(aDFSTree includesKey: aNodeElement)
		ifTrue: [  
			| aHeight |
			(aDFSTree at: aNodeElement)
			do: [ :aConnectedElement | 
				self startLayout: aConnectedElement
				  		tree: aDFSTree
				  		level: aLevel + 1
				  		largestNodeDimByLevel: largestNodeDimByLevel 
			].

			aHeight := self
				mergeWithChildrenContours: aNodeElement
				tree: aDFSTree.
			self
				attachParent: aNodeElement
				tree: aDFSTree
				height: aHeight
	]
	ifFalse: [ self layoutLeaf: aNodeElement ].

			