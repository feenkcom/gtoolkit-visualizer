measure
measurePositions: anElement with: anExtentSpec
	| theNodes thePositions |
	
	"BlElement is a root for all graphical components"
	"anElement children  -> an instance of BlChildren"
	theNodes := anElement children accountedByLayout
		select: [ :aChildElement | aChildElement graph isNode ].

	thePositions := self calculatePositionsFor: theNodes.

	thePositions keysAndValuesDo: [ :aNodeElement :aPosition | aNodeElement measuredBounds position: aPosition ]