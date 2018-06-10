measure
measurePositions: anElement with: anExtentSpec
	| theNodes thePositions theRoot |
	
	"BlElement is a root for all graphical components"
	"anElement children  -> an instance of BlChildren"
	theNodes := anElement children accountedByLayout
		select: [ :aChildElement | aChildElement graph isNode ].

	theRoot := theNodes first.
	thePositions := self calculatePositionsFor: theNodes root: theRoot.
	
	thePositions keysDo: [ :aNodeElement |
		aNodeElement measuredBounds position: (thePositions at: aNodeElement) ]
	