*GToolkit-Diagrammer
editorForGeometry
	| picker |

	picker := GtDiagrammerGeometryPicker new.
	picker
		when: BrToggleActivatedEvent
		do: [ :anEvent | self geometry: anEvent model class new ].
	^ picker