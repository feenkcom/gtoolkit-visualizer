calculating
calculatePositionsFor: nodes root: aRootNode
	<return: #Collection of: #Point>
	| offsets positions contours bounds maxLevelHeights|
	
	offsets := IdentityDictionary new.
	positions := IdentityDictionary new.
	contours := IdentityDictionary new.
	maxLevelHeights := Dictionary new.
	nodes do: [ :node |
		offsets at: node put: 0@0.
		positions at: node put: 0@0.
		contours at: node put: NodeContour new.
	].
	positions at: aRootNode put: 0@0.
	
	self startLayout: aRootNode
		  offsets: offsets
		  contours: contours
		  level: 1
		  largestNodeDimByLevel: maxLevelHeights.
		
	bounds := self layout: aRootNode
						startX:50
						startY:50
						positions: positions
						offsets: offsets
						bounds: (BlBounds new left:0; right:0; top:0; bottom:0)
						level: 1
						largestNodeDimByLevel: maxLevelHeights.
			
	^ positions
