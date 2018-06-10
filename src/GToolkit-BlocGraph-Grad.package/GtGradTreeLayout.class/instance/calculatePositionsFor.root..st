calculating
calculatePositionsFor: nodes root: aRootNode
	<return: #Collection of: #Point>
	| offsets positions|
	
	offsets := IdentityDictionary new.
	positions := IdentityDictionary new.
	nodes do: [ :node |
		offsets at: node put: 0@0.
		positions at: node put: 0@0.	
	].
	positions at: aRootNode put: 50@50.
	
	self startLayout: aRootNode offsets: offsets.
	self verticalLayout: aRootNode startX:50 startY:50  positions:positions offsets:offsets.

	^ positions
