private - adding / removing
link: anElement
	"I create a logical edge between elements (not visible)"

	self
		assert: [ anElement isConnectorTarget ]
		description: [ 'An element must be a target' ].

	(self sourcesWithTarget: anElement connectorTarget)
		do: [ :anInnerElement |
			(self elementsWithMethod: anInnerElement connectorSource)
				do: [ :aSourceElement | self addEdgeFrom: aSourceElement to: anElement ] ]