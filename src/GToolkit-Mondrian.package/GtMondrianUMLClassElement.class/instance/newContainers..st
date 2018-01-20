accessing
newContainers: aCollectionOfSymbols
	aCollectionOfSymbols
		do: [ :each | 
			| element |
			element := BlElement new
						layout: BlLinearLayout horizontal;
						constraintsDo: [ :c | 
							c vertical fitContent.
							c horizontal fitContent ];
						background: Color white;
						padding: (BlInsets all: 5).
			element graph beChildrenContainer: each.
			self addChild: element ]