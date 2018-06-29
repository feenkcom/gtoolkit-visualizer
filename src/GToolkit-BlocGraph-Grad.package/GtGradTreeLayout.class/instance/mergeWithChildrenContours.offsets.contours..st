calculating
mergeWithChildrenContours: aNode offsets: anOffsetsDict contours: aContoursDict
	| total width firstChild | 
	
	firstChild := (aNode graph connectedNodesAlongOutgoingEdges) first.
	aContoursDict at: aNode put: (aContoursDict at: firstChild).
	width := (firstChild measuredBounds width) + (2 * self nodeDistance).
	total := width.
		
	(aNode graph connectedNodesAlongOutgoingEdges) do: [ :child | 

		child = firstChild
			ifFalse: [
				| d |

				d := self mergeContours: aNode child: child contours: aContoursDict.
				anOffsetsDict at: child put: 0@(width + d).
				GtGradLayoutOffsetSetSignal new
									node: aNode; 
									offsetX: 0; 
									offsetY: width + d;
									emit.
			
				width := (child measuredBounds width) + (2 * self nodeDistance).
				total := total + width + d.
		].
	].

	^ total
	