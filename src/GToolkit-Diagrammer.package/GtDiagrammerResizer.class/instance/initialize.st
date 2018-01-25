initialization
initialize
	super initialize.
	
	self border: (BlBorder paint: (Color blue alpha: 0.1) width: 5).
	
	topLeft := self newHandle.
	topLeft constraintsDo: [ :c |
		c frame horizontal alignLeft.
		c frame vertical alignTop ].
	
	topCenter := self newHandle.
	topCenter constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignTop ].
	
	topRight := self newHandle.
	topRight constraintsDo: [ :c |
		c frame horizontal alignRight.
		c frame vertical alignTop ].
	
	middleLeft := self newHandle.
	middleLeft constraintsDo: [ :c |
		c frame horizontal alignLeft.
		c frame vertical alignCenter ].
	
	middleRight := self newHandle.
	middleRight constraintsDo: [ :c |
		c frame horizontal alignRight.
		c frame vertical alignCenter ].

	bottomLeft := self newHandle.
	bottomLeft constraintsDo: [ :c |
		c frame horizontal alignLeft.
		c frame vertical alignBottom ].
	
	bottomCenter := self newHandle.
	bottomCenter constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignBottom ].
	
	bottomRight := self newHandle.
	bottomRight constraintsDo: [ :c |
		c frame horizontal alignRight.
		c frame vertical alignBottom ].
	
	bottomRight when: BlMouseEnterEvent do: [ self inform: bottomRight asString ].

	self addChildren: {
		topLeft . topCenter . topRight .
		middleLeft . middleRight .
		bottomLeft . bottomCenter . bottomRight .
	}