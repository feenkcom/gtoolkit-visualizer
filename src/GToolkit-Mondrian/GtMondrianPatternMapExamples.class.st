"
OBSOLETE — Superseded by {{gtClass:name=LepiterMondrianPageMap}} and {{gtClass:name=LepiterMondrianPageMapExamples}}. 

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

	^ (Array new: 18)
		at: 1 put: 183.9584903717041 @ 245.31882731119794;
		at: 2 put: 372.0 @ 243.91666666666669;
		at: 3 put: 399.2699890136719 @ 297.9166666666667;
		at: 4 put: 163.60298538208008 @ 351.9166666666667;
		at: 5 put: 392.554988861084 @ 354.51450602213544;
		at: 6 put: 187.3509864807129 @ 421.51450602213544;
		at: 7 put: 353.4189872741699 @ 420.51450602213544;
		at: 8 put: 139.4889907836914 @ 483.1123453776042;
		at: 9 put: 241.65098571777344 @ 483.1123453776042;
		at: 10 put: 296.35248756408686 @ 259.24401874840106;
		at: 11 put: 296.35248756408686 @ 274.480607193991;
		at: 12 put: 240.40558921191473 @ 274.91666666666663;
		at: 13 put: 446.214462664401 @ 327.5145060221354;
		at: 14 put: 242.26062520195012 @ 381.51450602213544;
		at: 15 put: 277.1290380863739 @ 381.51450602213544;
		at: 16 put: 320.310977935791 @ 367.70853786158517;
		at: 17 put: 198.32045400645478 @ 451.1123453776042;
		at: 18 put: 258.9006121692213 @ 451.1123453776042;
		yourself
]

{ #category : #example }
GtMondrianPatternMapExamples >> pageTitles [
	<gtExample>
	^ {
		'Moldable object'.
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
	^ {'Moldable Object'
			-> {'Viewable data wrapper'.
					'Project diary'.
					'Contextual playground'}.
		'Project diary' -> {'Example object'}.
		'Contextual playground'
			-> {'Viewable entity'.
					'Custom action'.
					'Example object'}.
		'Viewable entity'
			-> {'Simple view'.
					'Collection wrapper'}}
]

{ #category : #example }
GtMondrianPatternMapExamples >> patternMap [
	<gtExample>
	<noTest>
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
	<noTest>
	^ (self patternConnections
		collect: [ :each | 
			(LeDatabase gtBook pageNamed: each key)
				-> (each value collect: [ :name | LeDatabase gtBook pageNamed: name ]) ])
		asDictionary
]

{ #category : #example }
GtMondrianPatternMapExamples >> patternMapWithExplicitPositions [
	"Redraw the pattern map with the explicitly saved positions."

	<gtExample>
	<noTest>
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
	<noTest>
	^ self pageTitles collect: [ :title | LeDatabase gtBook pageNamed: title  ]
]
