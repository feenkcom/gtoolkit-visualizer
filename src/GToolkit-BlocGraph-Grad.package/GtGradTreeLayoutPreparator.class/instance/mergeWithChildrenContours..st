private - layout
mergeWithChildrenContours: aTreeNode
	| total width aFirstChildNode aNodeContour | 

	aFirstChildNode := aTreeNode nodes first.

	"store a reference to the parent's contour outside of the loop to eliminate unnecessary dictionary accesses"
	aNodeContour := aFirstChildNode element constraints gradTree computedContour.
	aTreeNode element constraints gradTree computedContour: aNodeContour.

	width := (aFirstChildNode width) + (2 * self nodeDistance).

	total := width.
	
	aTreeNode nodes
		select: [ :aChildNode | aChildNode ~~ aFirstChildNode ]
		thenDo: [ :aChildNode | 
				| aDeltaDistance |

				aDeltaDistance := self
					mergeContour: aNodeContour
					with: aChildNode element constraints gradTree computedContour.

				aChildNode element constraints gradTree computedOffset: 0@(width + aDeltaDistance).
				
				GtGradTreeLayoutOffsetSetSignal new
					node: aChildNode; 
					offsetX: 0; 
					offsetY: width + aDeltaDistance;
					emit.

				width := (aChildNode width) + (2 * self nodeDistance).
				total := total + width + aDeltaDistance ].

	^ total
	