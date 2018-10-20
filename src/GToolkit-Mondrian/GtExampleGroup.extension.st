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
							geometry: BlEllipse new;
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
GtExampleGroup >> paintMapWith: view [
	view nodes
		umlClassShapeWithName: [ :each | each key name ];
		with: (self examples groupedBy: #methodClass) associations 
		forEach: [ :assoc | 
			view nodes
				stencil: [ :each |
					BlElement new
						geometry: BlEllipse new;
						border: (BlBorder paint: Color black);
						zIndex: 5;
						size: 20@20;
						constraintsDo: [ :constraints | constraints padding: (BlInsets all: 10) ] ];
				with: assoc value.
			view layout tree levelDistance: 100 ].
	view edges 
		fromCenterBottom;
		toCenterTop;
		stencil: [ :each | 
			BlLineElement new
				zIndex: 4;
				border: (BlBorder paint: (Color gray alpha: 0.2) width: 2) ];
		connect: self examples 
		from: #yourself 
		toAll: [:each | 
			self select: [:exampleWithResult | 
				each example directDependencies anySatisfy: [ :dependency | exampleWithResult example = dependency ]] ].
	view layout custom: (BlGridLayout horizontal columnCount: 10)
]
