*Gtoolkit-Mondrian
gtInspectorTraversedTargetsOnTreeIn: composite
	<gtInspectorPresentationOrder: 15>
	
	composite blocMondrian
		title: 'Tree';
		painting: [ :view |
			| thePairs |
			
			thePairs := Array streamContents: [ :aStream | self traversedTargets overlappingPairsDo: [ :from :to | aStream nextPutAll: { from . to } ] ].
			view nodes
				shape: [ :aTarget |
					BlTextEditElement new
						text: (aTarget gtDisplayString asRopedText);
						padding: (BlInsets all: 5) ];
				with: (self traversedTargets first target topMostParent withAllChildrenBreadthFirst).
			
			view edges connectFrom: #parent.
			
			thePairs pairsDo: [ :from :to |
				view edges
					shape: [ :x |
						BlParabollaArcElement new 
							border: (BlBorder paint: (Color red alpha: 0.2) width: 10);
							curvatureFraction: 0.4;
							toHead: (BlArrowheadSimpleArrow new
								arrowLengthFraction: 1;
								arrowNoseAngle: 60;
								border: (BlBorder builder paint: (Color red alpha: 0.2); width: 10; build)) ];
					passive;
					connectFrom: [ :x | from target ]
					to: [ :x | to target] ].
			view layout tree ]