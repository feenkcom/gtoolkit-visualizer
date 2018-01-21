*GToolkit-Diagrammer
editorForGeometry
	| picker |

	picker := GtDiagrammerGeometryPicker new.
	picker
		when: GtDiagrammerGeometryPickerSelected
		do: [ :anEvent | self geometry: anEvent geometry ].
	^ picker