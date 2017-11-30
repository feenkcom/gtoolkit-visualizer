uml
packageDependencies
	<gtExample>
	| view packages dependencies |
	view := self emptyView.
	BlUniverse reset.
packages := {'Glamour-Core' . 'Glamour-Presentations' . 'Glamour-Morphic-Renderer' . 'Glamour-Browsers'} collect: #asPackage.
dependencies := (packages flatCollect: [:p | 
	((p definedClasses flatCollect: #subclasses) groupedBy: #package) associations collect: [ :each | { p . each key . each value} ] ]).
	view nodes 
		shape: [ :p | BlElement new ];
		with: packages forEach: [:each | 
			view nodes 
				shape: [ :c | 
					BlElement new
						size: c methods size asPoint;
						background: Color gray];
				with: each definedClasses.
			view layout rectanglePack ].
	view edges 
		shape: [ :dep | BlParabollaArcElement new curvatureFraction: 0.2; border: (BlBorder paint: (Color gray alpha: 0.2) width: dep third size)];
		connect: dependencies
		from: #first
		to: #second.
	view layout circle radius: 500.
	^ view.
