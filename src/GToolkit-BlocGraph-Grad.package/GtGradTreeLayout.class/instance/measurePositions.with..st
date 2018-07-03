measure
measurePositions: anElement with: anExtentSpec
	| theNodes thePositions theRoot |
	
	"BlElement is a root for all graphical components"
	"anElement children  -> an instance of BlChildren"
	theNodes := anElement children accountedByLayout
		select: [ :aChildElement | aChildElement graph isNode ].

	theRoot := self findRoot: theNodes.
	thePositions := self calculatePositionsFor: theNodes root: theRoot.

	thePositions keysAndValuesDo: [ :aNodeElement :aPosition | aNodeElement measuredBounds position: aPosition ]