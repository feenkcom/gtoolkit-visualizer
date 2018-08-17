measure
measurePositions: anElement with: anExtentSpec
	| theNodes |
	
	"BlElement is a root for all graphical components"

	"anElement children  -> an instance of BlChildren"
	theNodes := anElement children accountedByLayout
		select: [ :aChildElement | aChildElement graph isNode ].
		
	self initializeLayout: theNodes.
	self layout: theNodes.

	theNodes do: [ :aNodeElement |
		aNodeElement measuredBounds position: (aNodeElement constraints gradTree computedPosition) ]