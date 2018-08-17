accessing
asElementDo: aBlock
	| pannableElement |
	paintingStencilBuilder value: mondrianInstance.
	pannableElement := mondrianInstance asPannableElement.
	pannableElement
		when: BlClickEvent
		do: [ :event | 
			event target graph isNode
				ifTrue: [ pannableElement
						fireEvent:
							(GtPhlowObjectToSelect new
								object: event target graph model;
								sourceElement: event target) ] ].
	^ aBlock value: pannableElement