measure
measurePositions: anElement with: anExtentSpec
	| theNodes thePositions theRoot dfsTrees |
	
	"BlElement is a root for all graphical components"
	"anElement children  -> an instance of BlChildren"
	theNodes := anElement children accountedByLayout
		select: [ :aChildElement | aChildElement graph isNode ].

	dfsTrees := self formDFSTrees: theNodes.
	theRoot := self findRoot: theNodes.
	thePositions := self calculatePositionsFor: theNodes.

	thePositions keysAndValuesDo: [ :aNodeElement :aPosition | aNodeElement measuredBounds position: aPosition ]