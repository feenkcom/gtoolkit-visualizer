*GToolkit-Diagrammer
editorForBackground
	| container colorContainer colorPresenter colorPicker alphaPicker |
	
	container := BlElement new.
	container layout: BlLinearLayout vertical.
	container constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical fitContent ].

	colorContainer := BlElement new.
	colorContainer padding: (BlInsets all: 10).
	colorContainer layout: BlLinearLayout horizontal.
	colorContainer constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical fitContent ].
	colorPresenter := GtDiagrammerColorPresenter new.
	colorPresenter constraintsDo: [ :c | c linear vertical alignCenter ].
	
	colorPicker := GtDiagrammerColorPicker new.
	colorPicker layout: BlFlowLayout horizontal.
	colorPicker constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical fitContent ].
	colorPicker margin: (BlInsets left: 7).
	colorPicker constraintsDo: [ :c | c linear vertical alignCenter ].
	colorPicker
		when: GtDiagrammerPickerSelected
		do: [ :anEvent | colorPresenter color: anEvent entity ].
	colorPicker
		when: GtDiagrammerPickerSelected
		do: [ :anEvent | self background: (BlBackground paint: anEvent entity) ].

	alphaPicker := GtDiagrammerNumberPicker new.
	alphaPicker format: [ :aNumber | aNumber printShowingDecimalPlaces: 1 ].
	alphaPicker display: [ (0 to: 1 by: 0.1) ].
	alphaPicker layout: BlFlowLayout horizontal.
	alphaPicker margin: (BlInsets top: 0 left: 10 bottom: 10 right: 0).
	alphaPicker constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical fitContent ].
	alphaPicker
		when: BrToggleActivatedEvent
		do: [ :anEvent | self background: (self background paint color alpha: anEvent model) ].

	colorContainer addChildren: { colorPresenter. colorPicker }.
	^ container addChildren: { colorContainer . alphaPicker }