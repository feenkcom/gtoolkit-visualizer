initialization
initializeTools
	| aToolsCard |

	aToolsCard := BlElement new.
	aToolsCard constraintsDo: [ :c | c horizontal matchParent ].
	aToolsCard layout: (BlGridLayout vertical cellSpacing: 2).
	aToolsCard constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical fitContent ].

	tools := GtDiagrammerToolPicker new.
	tools layout: BlLinearLayout horizontal.
	tools look: BrShadowLook new.
	tools margin: (BlInsets all: 5).
	tools display: [ self availableTools ].
	tools when: BrToggleActivatedEvent do: [ :anEvent | self tool: anEvent target viewModel model ].

	styles := GtDiagrammerPicker new.
	styles layoutDo: [ :l | l cellSpacing: 5 ].
	styles shape: [ :aStyle | BlElement new size: 20@20; background: Color random ].
	styles constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent ].
	styles when: GtDiagrammerPickerSelected do: [ :anEvent | self tool style: anEvent entity ].
	
	aToolsCard addChild: tools.
	aToolsCard addChild: styles.
	
	topbar addChild: aToolsCard