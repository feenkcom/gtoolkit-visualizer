initialization
initializeEntities
	self removeChildren.
	
	self addChildren: (displayBlock value collect: [ :anEntity |
		| anElement |
		
		anElement := shapeBlock cull: anEntity.
		anElement userData at: #pickerEntity put: anEntity.
		anElement
			addEventHandlerOn: BlMouseDownEvent
			do: [ :anEvent |
				anEvent consumed: true.
				self select: anEntity ] ]).
		
	self deselectAll