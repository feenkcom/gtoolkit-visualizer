ui
colorPicker
	<gtExample>
	| container presenter picker |

	container := BlElement new.
	container layout: BlLinearLayout horizontal.
	container constraintsDo: [ :c | 
		c horizontal fitContent.
		c vertical fitContent ].

	presenter := GtDiagrammerColorPresenter new.
	presenter constraintsDo: [ :c | 
		c linear vertical alignCenter ].

	picker := GtDiagrammerColorPicker new.
	picker constraintsDo: [ :c | 
		c linear vertical alignCenter ].

	picker
		when: GtDiagrammerPickerSelected
		do: [ :anEvent | presenter color: anEvent entity ].

	container addChildren: { presenter . picker }.

	^ container