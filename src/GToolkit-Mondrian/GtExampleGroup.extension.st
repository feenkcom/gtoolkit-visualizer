Extension { #name : #GtExampleGroup }

{ #category : #'*GToolkit-Mondrian' }
GtExampleGroup >> gtInspectorMondrianMapIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite blocMondrian
		title: 'Map (Bloc)';
		painting: [ :view :example :mondrian |
			view nodes
				umlClassShapeWithName: [ :each | each key name ];
				with: (self examples groupedBy: #methodClass) associations forEach: [ :assoc | 
				view nodes
					shape: [ :each |
						BlElement new 	
							geometry: BlEllipseGeometry new;
							border: (BlBorder paint: Color black width: 2);
							size: 20@20;
							constraintsDo: [ :constraints |
								constraints padding: (BlInsets all: 10) ];
							 addEventHandlerOn: BlMouseDownEvent do: [ :anEvent | mondrian selection: each ]	];
					with: assoc value.
				view layout tree levelDistance:  100 ].
			view edges 
				fromCenterBottom;
				toCenterTop;
				shape: [ :each | 
					BlLineElement new
						border: (BlBorder paint: (Color gray alpha: 0.2) width: 1) ];
				connect: self examples 
					from: #yourself 
					toAll: [:each | 
						self select: [:exampleWithResult | 
							each directDependencies anySatisfy: [ :dependency | exampleWithResult example = dependency ]]].
			view layout custom: GtGraphGridLayout new ]
]

{ #category : #'*GToolkit-Mondrian' }
GtExampleGroup >> paintMapWith: m [
	| grouped all local |
	local := self examples select: #isMethodDefined.
	all := local withDeepCollect: #directDependencies as: Set.
	grouped := all groupedBy: [:each | each method methodClass ].
	m nodes 
		stencil: [:assoc | 
			| pane default |
			pane := BlElement new
				constraintsDo: [:c | 
					c horizontal fitContent.
					c vertical fitContent ];
				layout: BlLinearLayout vertical alignCenter;
				background: Color white;
				look: BrShadowLook;
				margin: (BlInsets all: 10);
				padding: (BlInsets top: 0 left: 10 bottom: 10 right: 10).
			default := BlElement new
				constraintsDo: [:c | 
					c horizontal fitContent.
					c vertical fitContent ].
			default graph beChildrenContainer: #default.
			pane addChild: (BrLabel new text: assoc key name; look: (BrGlamorousLabelLook new foreground: Color gray); margin: (BlInsets bottom: 10)).
			pane addChild: default.
			pane ];
		with: grouped associations;
		forEach: [:assoc | 
			m nodes 
				stencil: [ :anExample | | element |
					element := BlElement new.
					element
						geometry: BlEllipseGeometry new;
						constraintsDo: [ :c | c horizontal fitContent. c vertical fitContent];
						border: (BlBorder paint: Color black width: 2);
						background: anExample color;
						size: 20@20;
						when: BlClickEvent do: [:anEvent | anEvent target phlow spawnObject: anExample];
						look: (BrGlamorousWithTooltipLook2 new 
							contentStencil: [ | container |
							container := BrVerticalPane new fitContent addChild: ((GtMethodCoder forExample: anExample) expanded: true) asElement.
							container 
								when: GtPhlowObjectToSpawn do: [:e | 
									element phlow spawnTool: e tool ] ];
								preferredExtent: 200@200;
								showDelay: 100 milliSeconds;
								hideDelay: 200 milliSeconds ).
					anExample announcer weak when: GtExampleExecuted do: [ :anEvent | 
						element enqueueTask: (BlTaskAction new action: [ element background: anExample color ]) ].
					(local includes: anExample) ifFalse: [element border: (BlBorder paint: Color gray width: 2)].
					element ];
		with: assoc value. 
	m layout horizontalTree nodeDistance: 2; treesDistance: 4; levelDistance: 10.].
	m edges 
		fromNearestTightCircle;
		toNearestTightCircle;
		stencil: [ :each | 
			BlParabollaArcElement new curvatureFraction: 0.1;
						border: (BlBorder paint: (Color gray alpha: 0.2) width: 2);
						toHead: (BlArrowheadSimpleArrow new
							border: (BlBorder builder paint: (Color gray alpha: 0.2); width: 2; build))];
		connect: all toAll: #directDependencies.
	m layout rectanglePack.
m
]
