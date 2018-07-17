calculating
mergeWithChildrenContours: aNodeElement tree: aDFSTree
	| total width firstChild aNodeContour | 

	firstChild := (aDFSTree at: aNodeElement) first.

	"store a reference to the parent's contour outside of the loop to eliminate unnecessary dictionary accesses"
	aNodeContour := firstChild constraints gradTree computedContour.
	aNodeElement constraints gradTree computedContour: aNodeContour.

	width := (firstChild measuredBounds width) + (2 * self nodeDistance).

	total := width.
	
	(aDFSTree at: aNodeElement)
		select: [ :aChildElement | aChildElement ~~ firstChild ]
		thenDo: [ :aChildElement | 
				| aDeltaDistance |

				aDeltaDistance := self
					mergeContour: aNodeContour
					with: aChildElement constraints gradTree computedContour.

				aChildElement constraints gradTree computedOffset: 0@(width + aDeltaDistance).
				
				GtGradTreeLayoutOffsetSetSignal new
									node: aNodeElement; 
									offsetX: 0; 
									offsetY: width + aDeltaDistance;
									emit.
			
				width := (aChildElement measuredBounds width) + (2 * self nodeDistance).
				total := total + width + aDeltaDistance ].

	^ total
	