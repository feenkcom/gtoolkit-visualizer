gt-inspector-extension
gtInspectorGeometryIn: aComposite
	<gtInspectorPresentationOrder: 12>

	^ aComposite bloc
		title: 'Geometry';
		element: [
			| picker |
			picker := GtDiagrammerGeometryPicker new.			
			picker
				when: GtDiagrammerGeometryPickerSelected
				do: [ :anEvent | self geometry: anEvent geometry ].
			picker ]