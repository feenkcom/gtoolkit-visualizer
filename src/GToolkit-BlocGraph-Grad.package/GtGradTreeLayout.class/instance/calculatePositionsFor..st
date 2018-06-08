calculating
calculatePositionsFor: aRootNode
	<return: #Collection of: #Point>
	| offsets positions|
	
	offsets := IdentityDictionary new.
	positions := IdentityDictionary new.
	
	self startLayout: aRootNode offsets: offsets.
