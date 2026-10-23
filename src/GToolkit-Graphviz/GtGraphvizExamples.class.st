"
Native integration examples. Require installed Graphviz libraries and plugins.
"
Class {
	#name : #GtGraphvizExamples,
	#superclass : #Object,
	#category : #'GToolkit-Graphviz-Examples'
}

{ #category : #examples }
GtGraphvizExamples >> layoutAttributeEscaping [
	<gtExample>
	| layout quoted |
	layout := GtGraphvizLayout new.
	quoted := layout quotedDotValue: 'a"b\c', String lf.
	self assert: quoted equals: '"a\"b\\c\n"'.
	^ layout
]

{ #category : #'examples - options' }
GtGraphvizExamples >> layoutBottomToTop [
	<gtExample>
	^ self sceneWithRankDirection: 'BT'
]

{ #category : #'examples - engines' }
GtGraphvizExamples >> layoutCirco [
	<gtExample>
	^ self sceneWithLayout: (GtGraphvizLayout new engine: 'circo'; yourself)
]

{ #category : #'examples - engines' }
GtGraphvizExamples >> layoutDot [
	<gtExample>
	^ self sceneWithLayout: (GtGraphvizLayout new engine: 'dot'; yourself)
]

{ #category : #'examples - options' }
GtGraphvizExamples >> layoutEdgeAttributes [
	<gtExample>
	| scene gap |
	scene := self sceneWithLayout: (GtGraphvizLayout new edgeAttribute: 'minlen' value: 3; edgeAttribute: 'weight' value: 2; yourself).
	gap := scene children second position y - scene children first bounds bottom.
	self assert: gap > 72.
	^ scene
]

{ #category : #'examples - engines' }
GtGraphvizExamples >> layoutFdp [
	<gtExample>
	^ self sceneWithLayout: (GtGraphvizLayout new engine: 'fdp'; overlap: false; graphAttribute: 'start' value: 42; yourself)
]

{ #category : #'examples - options' }
GtGraphvizExamples >> layoutGraphAttributes [
	<gtExample>
	^ self sceneWithLayout: (GtGraphvizLayout new graphAttribute: 'ordering' value: 'out'; graphAttribute: 'ranksep' value: '0.5 equally'; yourself)
]

{ #category : #'examples - options' }
GtGraphvizExamples >> layoutLeftToRight [
	<gtExample>
	^ self sceneWithRankDirection: 'LR'
]

{ #category : #'examples - engines' }
GtGraphvizExamples >> layoutNeato [
	<gtExample>
	^ self sceneWithLayout: (GtGraphvizLayout new engine: 'neato'; overlap: false; graphAttribute: 'start' value: 42; yourself)
]

{ #category : #'examples - options' }
GtGraphvizExamples >> layoutNodeAttributes [
	<gtExample>
	"Shape informs Graphviz geometry; it does not change the Bloc element's appearance."
	^ self sceneWithLayout: (GtGraphvizLayout new nodeAttribute: 'shape' value: 'ellipse'; yourself)
]

{ #category : #'examples - options' }
GtGraphvizExamples >> layoutNodeSeparation [
	<gtExample>
	| scene a b c gap |
	scene := BlElement new size: 500 @ 400; layout: (GtGraphvizLayout new nodeSeparation: 1; yourself).
	a := BlElement new size: 40 @ 40; background: Color lightBlue.
	b := BlElement new size: 40 @ 40; background: Color lightGreen.
	c := BlElement new size: 40 @ 40; background: Color lightRed.
	{ a. b. c } do: [ :node | node graph beNode. scene addChild: node ].
	a graph connectTo: b; connectTo: c.
	scene forceLayout.
	gap := (b position x - c position x) abs - 40.
	self assert: gap >= 71.
	^ scene
]

{ #category : #'examples - options' }
GtGraphvizExamples >> layoutOrthogonalSplines [
	<gtExample>
	"Exercises Graphviz routing, but only node geometry is applied to Bloc."
	^ self sceneWithLayout: (GtGraphvizLayout new splines: 'ortho'; yourself)
]

{ #category : #'examples - engines' }
GtGraphvizExamples >> layoutOsage [
	<gtExample>
	^ self sceneWithLayout: (GtGraphvizLayout new engine: 'osage'; yourself)
]

{ #category : #'examples - options' }
GtGraphvizExamples >> layoutOverlapRemoval [
	<gtExample>
	| scene rectangles |
	scene := self layoutNeato.
	rectangles := scene children collect: [ :node | node position extent: node extent ].
	1 to: rectangles size do: [ :i |
		i + 1 to: rectangles size do: [ :j |
			self assert: ((rectangles at: i) intersects: (rectangles at: j)) not ] ].
	^ scene
]

{ #category : #'examples - engines' }
GtGraphvizExamples >> layoutPatchwork [
	<gtExample>
	"Treemap geometry may resize nodes; patchwork does not preserve fixed input sizes."
	^ self sceneWithLayout: (GtGraphvizLayout new engine: 'patchwork'; nodeAttribute: 'area' value: 2; yourself)
]

{ #category : #'examples - options' }
GtGraphvizExamples >> layoutRankSeparation [
	<gtExample>
	| scene gap |
	scene := self sceneWithLayout: (GtGraphvizLayout new rankSeparation: 1; yourself).
	gap := scene children second position y - scene children first bounds bottom.
	self assert: gap >= 71.
	^ scene
]

{ #category : #'examples - options' }
GtGraphvizExamples >> layoutRightToLeft [
	<gtExample>
	^ self sceneWithRankDirection: 'RL'
]

{ #category : #'examples - engines' }
GtGraphvizExamples >> layoutSfdp [
	<gtExample>
	^ self sceneWithLayout: (GtGraphvizLayout new engine: 'sfdp'; overlap: false; yourself)
]

{ #category : #'examples - options' }
GtGraphvizExamples >> layoutTopToBottom [
	<gtExample>
	^ self sceneWithRankDirection: 'TB'
]

{ #category : #'examples - engines' }
GtGraphvizExamples >> layoutTwopi [
	<gtExample>
	^ self sceneWithLayout: (GtGraphvizLayout new engine: 'twopi'; graphAttribute: 'root' value: 'n1'; overlap: false; yourself)
]

{ #category : #examples }
GtGraphvizExamples >> nativeLayoutFdp [
	<gtExample>
	| scene |
	scene := self nativeLayoutScene.
	scene layout: (GtGraphvizLayout new engine: 'fdp'; overlap: false; graphAttribute: 'start' value: 42; yourself).
	scene forceLayout.
	self assert: scene children first position ~= scene children second position.
	^ scene
]

{ #category : #examples }
GtGraphvizExamples >> nativeLayoutLeftToRight [
	<gtExample>
	| scene nodes |
	scene := self nativeLayoutScene.
	scene layout: (GtGraphvizLayout new rankDirection: 'LR'; nodeSeparation: 0.4; rankSeparation: 0.8; yourself).
	scene forceLayout.
	nodes := scene children.
	self assert: nodes first position x < nodes second position x.
	self assert: nodes second position x < nodes third position x.
	^ scene
]

{ #category : #examples }
GtGraphvizExamples >> nativeLayoutScene [
	<gtExample>
	| scene a b c |
	scene := BlElement new layout: GtGraphvizLayout new; size: 400 @ 400.
	a := BlElement new size: 80 @ 40; background: Color lightBlue.
	b := BlElement new size: 100 @ 50; background: Color lightGreen.
	c := BlElement new size: 60 @ 30; background: Color lightRed.
	{ a. b. c } do: [ :node | node graph beNode. scene addChild: node ].
	a graph connectTo: b.
	b graph connectTo: c.
	scene forceLayout.
	self assert: a position y < b position y.
	self assert: b position y < c position y.
	self assert: (a extent x - 80) abs < 1.
	self assert: (b extent y - 50) abs < 1.
	^ scene
]

{ #category : #examples }
GtGraphvizExamples >> plainEdgeConversion [
	<gtExample>
	| routes points |
	routes := GtGraphvizLayout new edgeRoutesFromPlain: 'graph 1 4 3', String lf, 'edge n1 n2 4 1 2 1 1.5 2 1 3 0.5 solid black', String lf, 'stop'.
	points := (routes at: 'n1' -> 'n2') first.
	self assert: points first equals: 72 @ 72.
	self assert: points last equals: 216 @ 180.
	^ routes
]

{ #category : #examples }
GtGraphvizExamples >> plainGeometryConversion [
	<gtExample>
	| geometry |
	geometry := GtGraphvizLayout new geometryFromPlain: 'graph 1 4 3', String lf, 'node n1 1 2 2 1 "" solid box black lightgrey', String lf, 'stop'.
	self assert: (geometry at: 'n1') equals: (0 @ 36 extent: 144 @ 72).
	^ geometry
]

{ #category : #examples }
GtGraphvizExamples >> plainParallelEdges [
	<gtExample>
	| routes |
	routes := GtGraphvizLayout new edgeRoutesFromPlain: 'graph 1 4 3', String lf,
		'edge n1 n2 4 1 2 1 1.5 2 1 3 0.5 solid black', String lf,
		'edge n1 n2 4 2 2 2 1.5 3 1 4 0.5 solid black', String lf, 'stop'.
	self assert: (routes at: 'n1' -> 'n2') size equals: 2.
	self assert: (routes at: 'n1' -> 'n2') first ~= (routes at: 'n1' -> 'n2') last.
	^ routes
]

{ #category : #examples }
GtGraphvizExamples >> platformLibraryNames [
	<gtExample>
	| gvc cgraph |
	gvc := GtGraphvizGvcLibrary uniqueInstance.
	cgraph := GtGraphvizCgraphLibrary uniqueInstance.
	self assert: gvc unixLibraryName equals: 'libgvc.so.6'.
	self assert: cgraph unixLibraryName equals: 'libcgraph.so.6'.
	self assert: gvc win32LibraryName equals: 'gvc.dll'.
	self assert: cgraph win32LibraryName equals: 'cgraph.dll'.
	self assert: (gvc macLibraryName endsWith: 'libgvc.dylib').
	self assert: (cgraph macLibraryName endsWith: 'libcgraph.dylib').
	^ { gvc. cgraph }
]

{ #category : #examples }
GtGraphvizExamples >> rejectsEmbeddedNull [
	<gtExample>
	| rejected |
	rejected := false.
	[ GtGraphvizLayout new plainLayoutFor: 'digraph {}', Character null asString ]
		on: Error do: [ :error | self assert: error messageText equals: 'DOT input contains a null character'. rejected := true ].
	self assert: rejected.
	^ rejected
]

{ #category : #'examples - scenes' }
GtGraphvizExamples >> routedEdgesAfterRelayout [
	<gtExample>
	| scene before after curves |
	scene := self workflowWithRoutedArrows.
	curves := scene children select: [ :child | child isKindOf: GtGraphvizLineElement ].
	before := curves collect: [ :edge | edge anchorPositions copy ].
	scene layout: (GtGraphvizLayout new rankDirection: 'LR'; yourself).
	scene forceLayout.
	after := curves collect: [ :edge | edge anchorPositions copy ].
	self assert: before ~= after.
	scene forceLayout.
	self assert: (curves collect: [ :edge | edge anchorPositions copy ]) equals: after.
	^ scene
]

{ #category : #'examples - scenes' }
GtGraphvizExamples >> routedWorkflowForm [
	<gtExample>
	"Exercise actual native path construction, including multi-segment cubic curves and arrowheads."
	| scene form |
	scene := self workflowWithRoutedArrows.
	form := BlExporter form element: scene; export.
	self assert: form width > 0.
	self assert: form height > 0.
	^ form
]

{ #category : #private }
GtGraphvizExamples >> sceneWithLayout: aLayout [
	"Keep the same graph and measured node sizes across layout variations."
	| scene |
	scene := self nativeLayoutScene.
	scene layout: aLayout.
	scene forceLayout.
	self assert: scene children size equals: 3.
	scene children do: [ :node |
		self assert: node extent x > 0.
		self assert: node extent y > 0.
		self assert: node position x isFinite.
		self assert: node position y isFinite ].
	^ scene
]

{ #category : #private }
GtGraphvizExamples >> sceneWithRankDirection: direction [
	| scene first last |
	scene := self sceneWithLayout: (GtGraphvizLayout new rankDirection: direction; yourself).
	first := scene children first position.
	last := scene children last position.
	direction = 'TB' ifTrue: [ self assert: first y < last y ].
	direction = 'BT' ifTrue: [ self assert: first y > last y ].
	direction = 'LR' ifTrue: [ self assert: first x < last x ].
	direction = 'RL' ifTrue: [ self assert: first x > last x ].
	^ scene
]

{ #category : #examples }
GtGraphvizExamples >> straightLineIgnoresGraphvizRoutes [
	<gtExample>
	| line geometry routes |
	line := BlLineElement new.
	geometry := line geometry.
	routes := Dictionary new.
	line graphvizApplyRoutes: routes nodeIds: IdentityDictionary new sourceCenters: IdentityDictionary new.
	self assert: line geometry == geometry.
	self assert: routes isEmpty.
	^ line
]

{ #category : #private }
GtGraphvizExamples >> workflowNode: label color: color width: width [
	| node text |
	node := BlElement new
		size: width @ 48;
		layout: BlFrameLayout new;
		geometry: (BlRoundedRectangleGeometry cornerRadius: 8);
		background: color;
		border: (BlBorder paint: Color gray width: 1).
	text := BlTextElement new text: label asRopedText.
	text constraintsDo: [ :c | c frame horizontal alignCenter. c frame vertical alignCenter ].
	node addChild: text.
	node graph beNode: label.
	^ node
]

{ #category : #'examples - scenes' }
GtGraphvizExamples >> workflowWithEdges [
	"A branching and merging workflow. As in GtGradExamples, graph connectivity is explicit; separate anchored lines visualize those connections."

	<gtExample>
	| scene labels nodes pairs |
	labels := #('Request' 'Validate' 'Reject' 'Authorize' 'Inventory' 'Payment' 'Pack' 'Notify' 'Ship' 'Complete').
	pairs := #(#(1 2) #(2 3) #(2 4) #(4 5) #(4 6) #(5 7) #(6 7) #(3 8) #(7 9) #(9 8) #(8 10)).
	scene := BlElement new
			layout: (GtGraphvizLayout new
					rankDirection: 'TB';
					nodeSeparation: 0.5;
					rankSeparation: 0.65;
					yourself);
			constraintsDo: [ :c | 
				c horizontal fitContent.
				c vertical fitContent ].
	nodes := labels
			withIndexCollect: [ :label :index | 
				self
					workflowNode: label
					color: (index = 3 ifTrue: [ Color lightRed ] ifFalse: [ Color lightBlue ])
					width: 150 + (label size * 3) ].
	nodes do: [ :node | scene addChild: node ].
	pairs
		do: [ :pair | 
			| source target line |
			source := nodes at: pair first.
			target := nodes at: pair second.
			source graph connectTo: target.
			line := BlLineElement new
					border: (BlBorder paint: Color darkGray width: 2);
					fromAnchor: (BlElementBottomCenterAnchor element: source);
					toAnchor: (BlElementTopCenterAnchor element: target);
					toHead: (BlArrowheadSimpleArrow new border: (BlBorder paint: Color darkGray width: 2)).
			line constraints ignoreByLayout.
			scene addChild: line ].
	scene forceLayout.
	self assert: scene children size equals: labels size + pairs size.
	pairs
		do: [ :pair | 
			self
				assert: (nodes at: pair first) position y < (nodes at: pair second) position y ].
	nodes do: [ :node | self assert: node extent y equals: 48 ].
	^ scene
]

{ #category : #'examples - scenes' }
GtGraphvizExamples >> workflowWithOrthogonalEdges [
	<gtExample>
	| scene |
	scene := self workflowWithRoutedEdges.
	scene layout: (GtGraphvizLayout new splines: 'ortho'; rankSeparation: 0.65; yourself).
	scene forceLayout.
	scene children do: [ :child |
		(child isKindOf: GtGraphvizLineElement) ifTrue: [ | points |
			points := child anchorPositions.
			1 to: points size - 1 do: [ :i | | delta |
				delta := (points at: i + 1) - (points at: i).
				self assert: (delta x abs < 0.01 or: [ delta y abs < 0.01 ]) ] ] ].
	^ scene
]

{ #category : #'examples - scenes' }
GtGraphvizExamples >> workflowWithRoutedArrows [
	<gtExample>
	| scene |
	scene := self workflowWithRoutedEdges.
	scene children do: [ :child |
		(child isKindOf: GtGraphvizLineElement) ifTrue: [
			child toHead: (BlArrowheadSimpleArrow new border: (BlBorder paint: Color darkGray width: 2)) ] ].
	scene forceLayout.
	scene children do: [ :child |
		(child isKindOf: GtGraphvizLineElement) ifTrue: [
			self assert: child toPosition equals: child anchorPositions last.
			self assert: child hasToHead ] ].
	^ scene
]

{ #category : #'examples - scenes' }
GtGraphvizExamples >> workflowWithRoutedEdges [
	<gtExample>
	| scene lines |
	scene := self workflowWithEdges.
	lines := scene children select: [ :child | child isKindOf: BlLineElement ].
	lines do: [ :line | | edge |
		edge := GtGraphvizLineElement from: line fromAnchor referenceElement to: line toAnchor referenceElement.
		edge border: (BlBorder paint: Color darkGray width: 2).
		scene removeChild: line.
		scene addChild: edge ].
	scene forceLayout.
	self assert: (scene children count: [ :child | child isKindOf: GtGraphvizLineElement ]) equals: lines size.
	scene children do: [ :child |
		(child isKindOf: GtGraphvizLineElement) ifTrue: [
			self assert: child geometry controlPoints size >= 4.
			self assert: (child geometry controlPoints size - 1) \\ 3 equals: 0 ] ].
	^ scene
]
