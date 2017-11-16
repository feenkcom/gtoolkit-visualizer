private - adding / removing
removeLink: aLink
	| aSourceElement aTargetElement |
	
	aSourceElement := self
		elementWithMethod: aLink source
		ifAbsent: [ ^ self ].
		
	aTargetElement := self
		elementWithMethod: aLink target
		ifAbsent: [ ^ self ].

	self removeEdgeFrom: aSourceElement to: aTargetElement