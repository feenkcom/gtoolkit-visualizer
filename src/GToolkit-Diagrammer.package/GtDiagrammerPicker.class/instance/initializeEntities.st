initialization
initializeEntities
	self removeChildren.
	
	entities := displayBlock value.
	selected := nil.
	
	self addChildren: (entities collect: [ :anEntity |
		| anElement |
		
		anElement := shapeBlock cull: anEntity.
		anElement userData at: #pickerEntity put: anEntity.
		anElement
			addEventHandlerOn: BlMouseDownEvent
			do: [ :anEvent |
				anEvent consumed: true.
				self select: anEntity ] ]).
		
	self deselectAll