calculating
calculatePositionsFor: nodes root: aRootNode
	<return: #Collection of: #Point>
	| offsets positions contours bounds|
	
	offsets := IdentityDictionary new.
	positions := IdentityDictionary new.
	contours := IdentityDictionary new.
	nodes do: [ :node |
		offsets at: node put: 0@0.
		positions at: node put: 0@0.
		contours at: node put: NodeContour new.
	].
	positions at: aRootNode put: 0@0.
	
	self startLayout: aRootNode offsets: offsets contours: contours.

	bounds := self layout: aRootNode startX:50 startY:50  positions: positions offsets: offsets bounds: nil.
	
	Halt now.

	^ positions
