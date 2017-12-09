examples
packageDependencies
	<gtExample>
	| view packages dependencies |
	view := self emptyView.
	packages := {'Glamour-Core' . 'Glamour-Presentations' . 'Glamour-Morphic-Renderer' . 'Glamour-Browsers'} collect: #asPackage.
	dependencies := packages flatCollect: [:p | 
		((p definedClasses flatCollect: #subclasses) groupedBy: #package) associations 
			collect: [ :each | { p . each key . each value} ]
			thenSelect: [ :tuple | tuple first ~= tuple second ] ].
	view nodes 
		shape: [ :p | 
			| shape text label |
			shape := 	BlElement new.
			shape layout: (BlGridLayout vertical cellSpacing: 0).
			shape constraintsDo: [ :c |
				c vertical fitContent.
				c horizontal fitContent ].
			text := BrRopedText string: p name.
			label := GtShrinkingLabel new text: text.
			label constraintsDo: [ :c |
					c vertical fitContent.
					c horizontal matchParent ].
			shape addChild: label.
			shape addChild: (BlElement new
				layout: BlLinearLayout horizontal;
				constraintsDo: [ :c |
					c vertical fitContent.
					c horizontal fitContent ];
				background: Color white;
				padding: (BlInsets all: 5);
				beMondrianChildrenContainer: #default)
			 ];
		with: packages forEach: [:each | 
			view nodes 
				shape: [ :c | 
					BlElement new
						size: c methods size asPoint;
						background: Color gray];
				with: each definedClasses.
			view layout rectanglePack ].
	view edges
		fromNearestCircle;
		toNearestCircle;
		shape: [ :dep | 
			BlParabollaArcElement new 
				curvatureFraction: 0.2; 
				border: (BlBorder paint: (Color gray alpha: 0.2) width: dep third size);
				fromHead: (BlArrowheadSimpleArrow new
					arrowLengthFraction: 5;
					arrowNoseAngle: 60;
					border: (BlBorder builder paint: (Color gray alpha: 0.2); width: dep third size; build))];
		connect: dependencies
		from: #first
		to: #second.
	view layout circle radius: 300.
	^ view