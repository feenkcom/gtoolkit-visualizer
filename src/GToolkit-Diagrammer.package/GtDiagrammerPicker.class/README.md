I am a scriptable toogle group to display a uniform collection of selectable values.

[[[
| picker |
picker := GtDiagrammerPicker new.
picker layout: BlFlowLayout horizontal.
picker display: [ { 'Hello' . 'World' . 'I' . 'am' . 'a' . 'picker' } ].
picker shape: [ :aString | BrToggle new
	look: BrMaterialToggleLabelledLook;
	margin: (BlInsets all: 3);
	label: aString ].
picker constraintsDo: [ :c |
	c horizontal exact: 400.
	c vertical fitContent ].
picker when: BrToggleActivatedEvent do: [ :anEvent | self inform: anEvent model ].
picker
]]]