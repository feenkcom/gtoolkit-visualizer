initialization
initializeEntities
	self removeToggles.
	
	entities := displayBlock value.
	self addToggles: (entities collect: [ :anEntity |
		| anElement |

		anElement := shapeBlock cull: anEntity.
		anElement viewModel model: anEntity.
		anElement ]).
	
	self initializeSelection