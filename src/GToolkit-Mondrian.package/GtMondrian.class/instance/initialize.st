initialize
initialize
	stack := Stack new.
	stack push: (GtMondrianStep new 
		root: ((BlElement new
		clipChildren: false;
		constraintsDo: [ :constraints |
			constraints horizontal fitContent.
			constraints vertical fitContent.
			constraints padding: (BlInsets all: 10) ];
		background: (BlBackground paint: Color white);
		zIndex: 1)))