calculating
calculatePositionsFor: theNodeElements
	<return: #Collection of: #Point>
	| dfsTrees offsets positions contours bounds maxLevelHeights startX startY |

	offsets := IdentityDictionary new.
	positions := IdentityDictionary new.
	contours := IdentityDictionary new.
	maxLevelHeights := Dictionary new.
	
	dfsTrees := self formDFSTrees: theNodeElements.
	
	theNodeElements do: [ :aNodeElement |
		offsets at: aNodeElement put: 0@0.
		positions at: aNodeElement put: 0@0.
		contours at: aNodeElement put: NodeContour new ].

	startX := 50.
	startY := 50.

	dfsTrees do: [ :aTree |
		
		GtGradProcessingTreeSignal new
							root: (aTree root);
							edgesByNode: (aTree connectedNodes);
							emit.

		self startLayout: aTree root
		  tree: aTree connectedNodes
		  offsets: offsets
		  contours: contours
		  level: 1
		  largestNodeDimByLevel: maxLevelHeights.
		
		bounds := self layout: aTree root
						tree: aTree connectedNodes
						startX: startX
						startY: startY
						positions: positions
						offsets: offsets
						bounds: 0@0
						level: 1
						largestNodeDimByLevel: maxLevelHeights.

			maxLevelHeights removeAll.
			
			startX := startX + bounds x + self treesDistance.

	].

	^ positions