*GToolkit-Diagrammer
editorForGeometry
	| picker |

	picker := GtDiagrammerGeometryPicker new.
	picker
		when: GtDiagrammerPickerSelected
		do: [ :anEvent | self geometry: anEvent entity ].
	^ picker