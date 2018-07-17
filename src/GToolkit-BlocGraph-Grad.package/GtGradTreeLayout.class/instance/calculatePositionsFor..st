calculating
calculatePositionsFor: theNodeElements
	<return: #Collection of: #Point>
	| dfsTrees bounds maxLevelHeights startX startY |

	"reset all computed positions"
	theNodeElements do: [ :aNodeElement | aNodeElement constraints gradTree computedPosition: 0@0 ].

	maxLevelHeights := Dictionary new.
	
	dfsTrees := self formDFSTrees: theNodeElements.

	startX := 50.
	startY := 50.

	dfsTrees do: [ :aTree |
		
		GtGradProcessingTreeSignal new
							root: (aTree root);
							edgesByNode: (aTree connectedNodes);
							emit.

		self startLayout: aTree root
		  tree: aTree connectedNodes
		  level: 1
		  largestNodeDimByLevel: maxLevelHeights.
		
		bounds := self layout: aTree root
						tree: aTree connectedNodes
						startX: startX
						startY: startY
						bounds: 0@0
						level: 1
						largestNodeDimByLevel: maxLevelHeights.

			maxLevelHeights removeAll.
			
			startX := startX + bounds x + self treesDistance ]