actions
select: anEntity
	
	selected = anEntity
		ifTrue: [ ^ self ].
		
	selected := anEntity.

	self deselectAll.
	
	self entity: anEntity do: [ :anElement |
		selectedBlock cull: anElement cull: anEntity.
		self dispatchEvent: (GtDiagrammerPickerSelected new entity: anEntity; shape: anElement) ]