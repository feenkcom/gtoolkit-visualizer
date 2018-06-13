private
cachedConnectingNodes
	
	cachedConnectingNodes ifNil: [cachedConnectingNodes := IdentityDictionary new: 1000].
	^cachedConnectingNodes