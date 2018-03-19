*GToolkit-Diagrammer
editorForBackground
	| container colorPicker alphaPicker |
	
	container := BlElement new.
	container layout: BlLinearLayout vertical.
	container constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical fitContent ].
	
	colorPicker := GtDiagrammerColorPicker new.
	colorPicker layout: BlFlowLayout horizontal.
	colorPicker constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical fitContent ].
	colorPicker constraintsDo: [ :c | c linear vertical alignCenter ].
	colorPicker
		when: BrToggleActivatedEvent
		do: [ :anEvent | self background: (BlBackground paint: anEvent model) ].

	alphaPicker := GtDiagrammerNumberPicker new.
	alphaPicker format: [ :aNumber | aNumber printShowingDecimalPlaces: 1 ].
	alphaPicker display: [ (0 to: 1 by: 0.1) ].
	alphaPicker layout: BlFlowLayout horizontal.
	alphaPicker constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical fitContent ].
	alphaPicker
		when: BrToggleActivatedEvent
		do: [ :anEvent |  ].

	^ container addChildren: { colorPicker . "alphaPicker" }