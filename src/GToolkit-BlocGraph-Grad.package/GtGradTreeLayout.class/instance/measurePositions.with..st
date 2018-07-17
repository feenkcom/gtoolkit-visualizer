measure
measurePositions: anElement with: anExtentSpec
	| theNodes aTreeForest |

	self resetCache.

	"BlElement is a root for all graphical components"
	"anElement children  -> an instance of BlChildren"
	theNodes := anElement children accountedByLayout
		select: [ :aChildElement | aChildElement graph isNode ].

	"reset all computed positions"
	theNodes do: [ :aNodeElement | aNodeElement constraints gradTree computedPosition: 0@0 ].

	aTreeForest := GtGradTreeForest from: theNodes.
	aTreeForest accept: (GtGradTreeLayoutPreparator on: self).
	aTreeForest accept: (GtGradTreeLayoutCalculator on: self).

	theNodes do: [ :aNodeElement |
		aNodeElement measuredBounds position: (aNodeElement constraints gradTree computedPosition) ]