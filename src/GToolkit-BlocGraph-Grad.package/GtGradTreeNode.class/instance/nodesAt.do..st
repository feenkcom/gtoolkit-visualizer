api - enumeration
nodesAt: aDepth do: aBlock

	"Already deeper than needed"
	self depth > aDepth
		ifTrue: [ ^ self ].

	self depth = aDepth
		ifTrue: [
			aBlock value: self.
			^ self ].

	self nodes do: [ :aTreeNode | aTreeNode nodesAt: aDepth do: aBlock ]