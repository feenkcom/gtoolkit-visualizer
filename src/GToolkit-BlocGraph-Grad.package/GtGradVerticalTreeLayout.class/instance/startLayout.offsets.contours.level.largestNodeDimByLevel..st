calculating
startLayout: aNodeElement offsets: anOffsetsDict contours: aContoursDict level: aLevel largestNodeDimByLevel: maxLevelHeightsDict
	| nodeHeight maxHeight |

	nodeHeight := aNodeElement measuredBounds height.

	maxHeight := maxLevelHeightsDict
		at: aLevel
		ifAbsentPut: [ nodeHeight ].

	"if the current node height is greater than the recorded max height on a given level - make it the max height"
	nodeHeight > maxHeight
		ifTrue: [ maxLevelHeightsDict at: aLevel put: nodeHeight ].

	self setOffsetsAndContours: aNodeElement
		  offsets: anOffsetsDict
		  contours: aContoursDict
		  level: aLevel
		  largestNodeDimByLevel: maxLevelHeightsDict