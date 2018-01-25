initialization
initializeTools
	| aToolsCard |

	aToolsCard := GtDiagrammerCard new.
	aToolsCard title: 'Tools'.
	aToolsCard constraintsDo: [ :c | c horizontal matchParent ].
	aToolsCard content
		layout: (BlGridLayout vertical cellSpacing: 2);
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical fitContent ].

	tools := GtDiagrammerToolPicker new.
	tools layoutDo: [ :l | l cellSpacing: 5 ].
	tools display: [ self availableTools ].
	tools constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ].
	tools when: GtDiagrammerPickerSelected do: [ :anEvent | self tool: anEvent entity ].
	
	styles := GtDiagrammerPicker new.
	styles layoutDo: [ :l | l cellSpacing: 5 ].
	styles shape: [ :aStyle | BlElement new size: 20@20; background: Color random ].
	styles constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent ].
	styles when: GtDiagrammerPickerSelected do: [ :anEvent | self tool style: anEvent entity ].
	
	
	aToolsCard addChild: tools in: #content.
	aToolsCard addChild: styles in: #content.
	
	sidebar addChild: aToolsCard in: #tools.