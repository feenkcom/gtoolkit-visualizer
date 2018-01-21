*Gtoolkit-Mondrian
gtInspectorTraversedTargetsOnTreeIn: composite
	<gtInspectorPresentationOrder: 15>
	composite blocMondrian
		title: 'Tree';
		painting: [ :view |
			| thePairs |
			thePairs := Array streamContents: [ :aStream | self traversedTargets overlappingPairsDo: [ :from :to | aStream nextPut: from -> to ] ].
			view nodes
				shape: [ :aTarget |
					| text |
					text := aTarget gtDisplayString asRopedText.
					text attributes: {BrTextForegroundAttribute paint: Color gray}.
					BlTextEditElement new
						text: text;
						padding: (BlInsets all: 5) ];
				with: (self traversedTargets first target topMostParent withAllChildrenBreadthFirst).
			view edges 
				fromCenterBottom;
				toCenterTop;				
				connectFrom: #parent.
			view edges
				shape: [ :x |
					| color |
					color := Color red.
					(x value isKindOf: BlEventTraversalBubblingStep) ifTrue: [ color := Color blue ].
					(x value isKindOf: BlEventTraversalTargetStep) ifTrue: [ color := Color green ].
					(x value isKindOf: BlEventTraversalForwardingStep) ifTrue: [ color := Color gray ].
					BlParabollaArcElement new 
						border: (BlBorder paint: (color alpha: 0.4) width: 2);
						curvatureFraction: 0.2;
						toHead: (BlArrowheadSimpleArrow new
							border: (BlBorder builder paint: (color alpha: 0.4); width: 2; build)) ];
				passive;
				connect: thePairs from: [ :x | x key target ]
				to: [ :x | x value target].
			view layout tree verticalGap: 40 ]