private
cachedOutgoingNodes
	
	cachedOutgoingNodes ifNil: [cachedOutgoingNodes := IdentityDictionary new: 1000].
	^cachedOutgoingNodes