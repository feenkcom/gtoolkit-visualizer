instance creation
icon
	^ BlElement new
		size: self iconSize;
		layout: BlFrameLayout new;
		addChild: ((BlTextElement text: 'None' asRopedText)
			constraintsDo: [ :c |
				c frame vertical alignCenter.
				c frame horizontal alignCenter ]);
		yourself