initialization
initializeTools
	| aToolsCard |

	aToolsCard := BlElement new.
	aToolsCard constraintsDo: [ :c | c horizontal matchParent ].
	aToolsCard layout: (BlGridLayout new cellSpacing: 2; columnCount: 1).
	aToolsCard constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical fitContent ].

	tools := GtDiagrammerToolPicker new.
	tools layout: BlLinearLayout horizontal.
	tools look: BrShadowLook new.
	tools margin: (BlInsets all: 5).
	tools display: [ self availableTools ].
	tools when: BrToggleActivatedEvent do: [ :anEvent | self tool: anEvent model ].

	styles := GtDiagrammerPicker new.
	styles padding: (BlInsets empty).
	styles shape: [ :aStyle |
		BrToggle new
			size: 20@20;
			background: Color random ].
	styles constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent ].
	styles when: BrToggleActivatedEvent do: [ :anEvent | self tool style: anEvent model ].
	
	aToolsCard addChild: tools.
	aToolsCard addChild: styles.
	
	topbar addChild: aToolsCard