accessing
asElementDo: aBlock
	paintingStencilBuilder value: mondrianInstance.
	mondrianElement := mondrianInstance asPannableElement.
	mondrianElement
		when: BlClickEvent
		do: [ :event | 
			(event target graph isNode or: [ event target graph isEdge ])
				ifTrue: [ mondrianElement
						fireEvent:
							(GtPhlowObjectToSelect new
								object: event target graph model;
								sourceElement: event target) ] ].
	^ aBlock value: mondrianElement