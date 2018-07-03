calculating
setOffsetsAndContours: aNodeElement offsets: anOffsetsDict contours: aContoursDict level: aLevel largestNodeDimByLevel: largestNodeDimByLevel
	
	"Perform the initial layout pass along all the nodes going from the root to the leafs"
	aNodeElement graph connectedNodesAlongOutgoingEdges
		do: [ :aConnectedElement | 
			self startLayout: aConnectedElement
				  offsets: anOffsetsDict
				  contours: aContoursDict
				  level: aLevel + 1
				  largestNodeDimByLevel: largestNodeDimByLevel ].

	aNodeElement graph hasConnectedNodesAlongOutgoingEdges
		ifFalse: [ self layoutLeaf: aNodeElement countours: aContoursDict ]
		ifTrue: [
			| aHeight |
			
			aHeight := self
				mergeWithChildrenContours: aNodeElement
				offsets: anOffsetsDict
				contours: aContoursDict.
			self
				attachParent: aNodeElement
				height: aHeight
				offsets: anOffsetsDict
				contours: aContoursDict ]
