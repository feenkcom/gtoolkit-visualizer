private - adding / removing
addLink: aLink
	| aSourceElement aTargetElement |
	
	aSourceElement := self
		elementWithMethod: aLink source
		ifAbsent: [ ^ self ].
		
	aTargetElement := self
		elementWithMethod: aLink target
		ifAbsent: [ ^ self ].

	self addEdgeFrom: aSourceElement to: aTargetElement