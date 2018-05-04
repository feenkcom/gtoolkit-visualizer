measure
measurePositions: anElement with: anExtentSpec
	| theNodes aRadius thePosition |
	
	"BlElement is a root for all graphical components"

	"anElement children  -> an instance of BlChildren"
	theNodes := anElement children accountedByLayout
		select: [ :aChildElement | aChildElement graph isNode ].

	aRadius := self calculateRadiusFor: theNodes.
	thePosition := self calculatePositionsFor: theNodes radius: aRadius center: 0@0.

	"SequenceableCollection"
	theNodes with: thePosition do: [ :aNodeElement :aPosition |
		"to change position of a node"
		aNodeElement measuredBounds position: aPosition ]