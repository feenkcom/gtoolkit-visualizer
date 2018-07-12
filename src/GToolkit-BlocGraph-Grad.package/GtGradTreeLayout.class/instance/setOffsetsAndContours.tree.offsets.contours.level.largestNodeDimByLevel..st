calculating
setOffsetsAndContours: aNodeElement tree: aDFSTree offsets: anOffsetsDict contours: aContoursDict level: aLevel largestNodeDimByLevel: largestNodeDimByLevel
	
	"Perform the initial layout pass along all the nodes going from the root to the leafs"
	
	(aDFSTree includesKey: aNodeElement)
		ifTrue: [  
			| aHeight |
			(aDFSTree at: aNodeElement)
			do: [ :aConnectedElement | 
				self startLayout: aConnectedElement
				  		tree: aDFSTree
				 	 	offsets: anOffsetsDict
	  				   contours: aContoursDict
				  		level: aLevel + 1
				  		largestNodeDimByLevel: largestNodeDimByLevel 
			].

			aHeight := self
				mergeWithChildrenContours: aNodeElement
				tree: aDFSTree
				offsets: anOffsetsDict
				contours: aContoursDict.
			self
				attachParent: aNodeElement
				tree: aDFSTree
				height: aHeight
				offsets: anOffsetsDict
				contours: aContoursDict 
	]
	ifFalse: [ self layoutLeaf: aNodeElement countours: aContoursDict ].

			