"
Pattern map with clickable pattern names that open the Lepiter pages.
NB: fragile if the pattern names change. In that case please update pageTitles and patternConnections (and probably explicitPositions).
"
Class {
	#name : #GtMondrianPatternMapExamples,
	#superclass : #Object,
	#category : #'GToolkit-Mondrian-Examples'
}

{ #category : #example }
GtMondrianPatternMapExamples >> explicitPositions [
	"Explicit positions saved after manually laying out the map.
	After altering the layout, save the new positions here by evaluating this snippet and copy-pasting the result:
	
	(self root children collect: #position) storeString"

	^ (Array new: 17)
		at: 1 put: 239.63483556111657 @ 308.2354939778646;
		at: 2 put: 398.08333333333337 @ 304.83333333333337;
		at: 3 put: 436.7093404134115 @ 353.83333333333337;
		at: 4 put: 218.87634023030603 @ 411.83333333333337;
		at: 5 put: 429.87533696492517 @ 411.4311726888021;
		at: 6 put: 200.35933812459314 @ 473.4311726888021;
		at: 7 put: 399.63134129842126 @ 479.4311726888021;
		at: 8 put: 139.36634190877282 @ 533.0290120442709;
		at: 9 put: 269.9023450215658 @ 536.0290120442709;
		at: 10 put: 346.9688351949056 @ 321.0439366412734;
		at: 11 put: 346.9688351949056 @ 336.09846445777083;
		at: 12 put: 292.784548124367 @ 337.83333333333337;
		at: 13 put: 480.8788125382617 @ 383.4311726888021;
		at: 14 put: 262.15413555454586 @ 441.4311726888021;
		at: 15 put: 326.88055778969 @ 441.4311726888021;
		at: 16 put: 199.23005168336604 @ 503.02901204427087;
		at: 17 put: 271.47170886348164 @ 503.02901204427087;
		yourself
]

{ #category : #example }
GtMondrianPatternMapExamples >> gtBook [
	<gtExample>
	<noTest>
	^ LeDatabasesRegistry uniqueInstance defaultLogicalDatabase databases
		detect: [ :db | db databaseName = 'Glamorous Toolkit Book' ]
]

{ #category : #example }
GtMondrianPatternMapExamples >> pageTitles [
	<gtExample>
	^ {'Moldable object'.
		'Viewable data wrapper'.
		'Project diary'.
		'Contextual playground'.
		'Example object'.
		'Viewable entity'.
		'Custom action'.
		'Simple view'.
		'Collection wrapper'}
]

{ #category : #example }
GtMondrianPatternMapExamples >> patternConnections [
	"Just the raw connections by page title."

	<gtExample>
	^ {'Moldable object'
			-> {'Viewable data wrapper'.
					'Project diary'.
					'Contextual playground'}.
		'Project diary' -> {'Example object'}.
		'Contextual playground'
			-> {'Viewable entity'.
					'Custom action'}.
		'Viewable entity'
			-> {'Simple view'.
					'Collection wrapper'}}
]

{ #category : #example }
GtMondrianPatternMapExamples >> patternMap [
	<gtExample>
	| m |
	m := GtMondrian new.
	m nodes
		stencil: [ :page | page asClickableLabel asStencil ];
		with: self patternPages.
	m edges
		fromNearestBounds;
		toNearestBounds;
		stencil: [ :page | 
			BlLineElement new
				border: (BlBorder paint: Color gray);
				toHead: (BlArrowheadSimpleArrow new border: (BlBorder paint: Color gray)) ];
		connectToAll: [ :each | self patternMapEdges at: each ifAbsent: [ {} ] ].
	m layout tree levelDistance: 20.
	^ m
]

{ #category : #example }
GtMondrianPatternMapExamples >> patternMapEdges [
	<gtExample>
	^ (self patternConnections
		collect: [ :each | 
			(self gtBook pageNamed: each key)
				-> (each value collect: [ :name | self gtBook pageNamed: name ]) ])
		asDictionary
]

{ #category : #example }
GtMondrianPatternMapExamples >> patternMapWithExplicitPositions [
	"Redraw the pattern map with the explicitly saved positions."

	<gtExample>
	| m |
	m := self patternMap.
	m layout custom: BlBasicLayout new.
	m root children
		withIndexDo: [ :child :n | child relocate: (self explicitPositions at: n) ].
	^ m
]

{ #category : #example }
GtMondrianPatternMapExamples >> patternPages [
	"NB: fragile -- the pattern names could change."

	<gtExample>
	^ self pageTitles collect: [ :title | self gtBook pageNamed: title ]
]
