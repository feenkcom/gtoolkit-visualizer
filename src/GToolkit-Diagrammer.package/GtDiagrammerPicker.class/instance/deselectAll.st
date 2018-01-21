actions
deselectAll

	self children do: [ :anElement |
		self entityOf: anElement do: [ :deselectedEntity |
			deselectedBlock cull: anElement cull: deselectedEntity.
			self dispatchEvent: (GtDiagrammerPickerDeselected new entity: deselectedEntity; shape: anElement) ] ]