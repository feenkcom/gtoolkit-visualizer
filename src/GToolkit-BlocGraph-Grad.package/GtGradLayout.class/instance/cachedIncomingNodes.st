private
cachedIncomingNodes
	
	cachedIncomingNodes ifNil: [cachedIncomingNodes := IdentityDictionary new: 1000].
	^cachedIncomingNodes