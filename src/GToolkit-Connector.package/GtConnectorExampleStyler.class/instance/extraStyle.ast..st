private
extraStyle: aText ast: ast
	| selfSendsExamples newLinks createdLinks deletedLinks |
	
	newLinks := OrderedCollection new.
	
	selfSendsExamples := self findExampleSendsIn: ast.
	selfSendsExamples do: [ :each | 
		| buttonAttribute targetExampleMethod aLink |
		
		targetExampleMethod := ast methodNode methodClass lookupSelector: each selector.
		
		aLink := GtConnectorLink
			source: ast method
			target: targetExampleMethod.
		newLinks add: aLink.

		buttonAttribute := GtConnectorTextButtonAttribute link: aLink.
		buttonAttribute actionBlock: [ :anEvent | exampleAction valueWithEnoughArguments: { targetExampleMethod . each . anEvent currentTarget } ].
		aText 
			attributes: { buttonAttribute } 
			from: each stop - 1
			to: each stop.
			
		self fireEvent: (GtConnectorButtonAttributeCreatedEvent new attribute: buttonAttribute) ].
	
	createdLinks := newLinks difference: previousLinks.
	deletedLinks := previousLinks difference: newLinks.
	previousLinks := newLinks.
	
	deletedLinks do: [ :aLink | self fireEvent: (GtConnectorLinkDeletedEvent link: aLink) ].
	createdLinks do: [ :aLink | self fireEvent: (GtConnectorLinkCreatedEvent link: aLink) ].