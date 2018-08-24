Class {
	#name : #GtMondrianBasicExamples,
	#superclass : #Object,
	#category : 'GToolkit-Mondrian-Examples'
}

{ #category : #'debugging edge creation' }
GtMondrianBasicExamples >> capturingEdgesNotCreated [
	<gtExample>
	| l view |
	l := MemoryLogger new.
	l runDuring: [ 
		view := GtMondrian new.
		view nodes with: (1 to: 2).
		view edges connect: { 1->3 . 0->2 . 4->5 } from: #key to: #value.
		view ].
	self assert: l recordings size = 3.
	l recordings allSatisfy: [ :signal | signal isKindOf: GtMondrianEdgeNotCreated ].
	self assert: l recordings first fromModel = 1. 
	self assert: l recordings first fromElement notNil. 
	self assert: l recordings first toModel = 3.
	self assert: l recordings first toElement isNil.
	self assert: l recordings second fromModel = 0. 
	self assert: l recordings second fromElement isNil.
	self assert: l recordings second toModel = 2. 
	self assert: l recordings second toElement notNil. 
	self assert: l recordings third fromModel = 4.
	self assert: l recordings third fromElement isNil. 
	self assert: l recordings third toModel = 5.
	self assert: l recordings third toElement isNil. 
	^ l
]

{ #category : #'tutorial - shapes' }
GtMondrianBasicExamples >> edgesWithTextAndThickerLinesHorizontalTree [
	<gtExample>
	| view |
	view := self nodesWithText.
	view edges
		fromRightCenter;
		toLeftCenter;
		shape: [ :x | BlLineElement new border: (BlBorder paint: (Color lightGray alpha: 0.4)) ];
		connectFrom: [ :x | x // 2 ].
	view layout horizontalTree levelDistance: 40.
	^ view
]

{ #category : #'tutorial - shapes' }
GtMondrianBasicExamples >> edgesWithThickerLines [
	<gtExample>
	| view |
	view := self nodesWithEllipses.
	view edges
		shape: [ :x | 
			BlLineElement new
				border: (BlBorder paint: (Color blue alpha: 0.5) width: x) ];
		connectFrom: [ :x | x // 2 ].
	view layout tree.
	^ view
]

{ #category : #'tutorial - shapes' }
GtMondrianBasicExamples >> edgesWithThickerLinesHorizontalTree [
	<gtExample>
	| view |
	view := self nodesWithEllipses.
	view edges
		shape: [ :x | 
			BlLineElement new
				border: (BlBorder paint: (Color blue alpha: 0.5) width: x) ];
		connectFrom: [ :x | x // 2 ].
	view layout horizontalTree.
	^ view
]

{ #category : #'examples shapes' }
GtMondrianBasicExamples >> elipseWithCustomShape [
	<gtExample>
	| view |
	view := GtMondrian new.
	view nodes
		shape: [ :anInteger | 
			BlElement new
				geometry: BlEllipse new;
				border: (BlBorder paint: Color black width: 2);
				size: (anInteger max: 5) asPoint;
				constraintsDo: [ :constraints | constraints padding: (BlInsets all: 10) ] ];
		with: (1 to: 20).
	view layout circle radius: 200.
	^ view
]

{ #category : #'examples shapes' }
GtMondrianBasicExamples >> elipseWithFactoryMethod [
	<gtExample>
	| view |
	view := GtMondrian new.
	view nodes
		ellipse: [ :anInteger :anEllipseElement | 
			anEllipseElement
				size: (anInteger max: 5) asPoint;
				constraintsDo: [ :constraints | constraints padding: (BlInsets all: 10) ] ];
		with: (1 to: 20).
	view layout circle radius: 200.
	^ view
]

{ #category : #'examples shapes' }
GtMondrianBasicExamples >> elipseWithReusedShape [
	<gtExample>
	| view |
	view := GtMondrian new.
	view nodes
		shape: [ :anInteger :anElement | 
			anElement
				geometry: BlEllipse new;
				size: (anInteger max: 5) asPoint;
				constraintsDo: [ :constraints | constraints padding: (BlInsets all: 10) ] ];
		with: (1 to: 20).
	view layout circle radius: 200.
	^ view
]

{ #category : #'tutorial - nodes, edges, layouts' }
GtMondrianBasicExamples >> emptyView [
	<gtExample>
	| view |
	view := GtMondrian new.
	self assert: view topStep root children isEmpty.
	^ view
]

{ #category : #'tutorial - nodes, edges, layouts' }
GtMondrianBasicExamples >> layoutOnOneEdgeBetweenTwoNodes [
	<gtExample>
	| view |
	view := self oneEdgeBetweenTwoNodes.
	view layout tree.
	^ view
]

{ #category : #'tutorial - nesting' }
GtMondrianBasicExamples >> nestedNodes [
	<gtExample>
	| view |
	view := self emptyView.
	view nodes
		shape: [ :x | 
			BlElement new 
				geometry: BlEllipse new; 
				background: (BlBackground paint: Color paleOrange);
				constraintsDo: [ :c | c padding: (BlInsets all: 10) ] ];
		with: (1 to: 9)
		forEach: [ :each |
			view nodes 
				shape: [ :x | BlTextElement new text: (x asString asRopedText attributes: {BrTextForegroundAttribute paint: Color gray}) ];
				with: (10 * each to: (10 * each + 4)).
			view layout circle radius: 20 ].
	^ view
]

{ #category : #'node creation' }
GtMondrianBasicExamples >> nestedNodesInDifferentContainers [
	<gtExample>
	| view |
	view := GtMondrian new.
	view nodes
		shape: [ :anObject | 
			| label labelContainer contents1 contents2 grid |
			label := BlTextElement new
				text: anObject asString asRopedText;
				padding: (BlInsets all: 5);
				constraintsDo: [ :c | c frame horizontal alignCenter ].
			labelContainer := BlElement new.
			labelContainer
				layout: BlFrameLayout new;
				background: (BlBackground paint: Color white);
				border: (BlBorder paint: Color gray);
				constraintsDo: [ :c | 
					c horizontal fitContent.
					c vertical fitContent ];
				addChild: label.
			contents1 := BlElement new
				layout: BlLinearLayout horizontal;
				constraintsDo: [ :c | 
					c vertical fitContent.
					c horizontal fitContent ];
				background: Color yellow;
				padding: (BlInsets all: 5).
			contents1 graph beChildrenContainer: #one.
			contents2 := BlElement new
				layout: BlLinearLayout horizontal;
				constraintsDo: [ :c | 
					c vertical fitContent.
					c horizontal fitContent ];
				background: Color orange;
				padding: (BlInsets all: 5).
			contents2 graph beChildrenContainer: #two.
			grid := GtWidthExpandingElement new
				layout: (BlGridLayout vertical cellSpacing: 1);
				constraintsDo: [ :c | 
					c vertical fitContent.
					c horizontal fitContent ];
				background: Color white;
				border: (BlBorder paint: Color gray);
				addChildren:
					{labelContainer.
					contents1.
					contents2} ];
		with: {1 . 2};
		forEach: [ :each | view nodes with: {10 . 11 . 12} ] in: #one;
		forEach: [ :each | view nodes with: {20 . 21} ] in: #two.
	view layout grid.
	^ view
]

{ #category : #'node creation' }
GtMondrianBasicExamples >> nestedNodesWithDefaultUMLClassShape [
	<gtExample>
	| view |
	view := GtMondrian new.
	view nodes 
		shape: [ :each | GtMondrianUMLClassElement withDefaultContainer ];
		with: (1 to: 10 ); 
		forEach: [:each | view nodes with: (1 to: 10) ].
	^ view
]

{ #category : #'tutorial - advanced' }
GtMondrianBasicExamples >> nestedNodesWithGlobalEdges [
	<gtExample>
	| view |
	view := self emptyView.
	view nodes
		shape: [ :each | 
			BlElement new
				border: (BlBorder paint: Color black width: 2);
				constraintsDo: [ :constraints | constraints padding: (BlInsets all: 10) ] ].
	view nodes
		with:
			{(1 to: 3).
			(4 to: 6)}
		forEach: [ :collection | 
			view nodes
				shape: [ :x | BlTextElement new text: x asString asRopedText ];
				with: collection.
			view layout circle ].
	view edges
		connect:
			{(1 -> 2).
			(3 -> 1).
			(1 -> 4).
			(4 -> 6).
			(5 -> 6)}
		from: [ :x | x key ]
		to: [ :x | x value ].
	view layout circle radius: 100.
	^ view
]

{ #category : #'node creation' }
GtMondrianBasicExamples >> nestedNodesWithUMLClassShape [
	<gtExample>
	| view |
	view := GtMondrian new.
	view nodes 
		shape: [ :each | GtMondrianUMLClassElement withContainers: #(one two) ];
		with: (1 to: 10 ); 
		forEach: [:each | view nodes with: (1 to: 10) ] in: #one;
		forEach: [:each | view nodes with: (1 to: 20) ] in: #two.
	^ view
]

{ #category : #'tutorial - nesting' }
GtMondrianBasicExamples >> nestedWithEdges [
	<gtExample>
	| view |
	view := self nestedNodes.
	view edges 
		fromCenterBottom;
		toCenterTop;
		connectFrom: [ :x | x // 2 ].
	view layout tree.
	^ view
]

{ #category : #'tutorial - shapes' }
GtMondrianBasicExamples >> nodesWithEllipses [
	<gtExample>
	| view |
	view := GtMondrian new.
	view nodes
		shape: [ :x | 
			BlElement new 
				border: (BlBorder paint: Color black);
				geometry: BlEllipse new; 
				size: (x * 2) @ (x * 2) ];
		with: (1 to: 9).
	^ view
]

{ #category : #'tutorial - shapes' }
GtMondrianBasicExamples >> nodesWithText [
	<gtExample>
	| view |
	view := GtMondrian new.
	view nodes
		shape: [ :x | 
			BlTextElement new
				text: x gtDisplayString asRopedText;
				padding: (BlInsets all: 5);
				geometry: BlEllipse new ];
		with: (1 to: 9).
	^ view
]

{ #category : #'tutorial - nodes, edges, layouts' }
GtMondrianBasicExamples >> oneEdgeBetweenTwoNodes [
	<gtExample>
	| view |
	view := self twoNodes.
	view edges connect: {1 . 2} from: [ :x | x + 1 ] to: [ :x | x ].
	self assert: view topStep root graph edgeChildren size equals: 1.
	^ view
]

{ #category : #'node creation' }
GtMondrianBasicExamples >> oneNode [
	<gtExample>
	| view |
	view := self emptyView.
	view nodes with: {1}.
	self assert: view topStep root children size equals: 1.
	^ view
]

{ #category : #'tutorial - advanced' }
GtMondrianBasicExamples >> passiveEdges [
	<gtExample>
	| view |
	view := self emptyView.
	view nodes
		shape: [ :x | BlTextElement new text: x asString asRopedText ];
		with: (1 to: 100).
	view edges connectFrom: [ :x | x // 2 ].
	view edges
		shape: [ :x | 
			BlLineElement new
				border: (BlBorder paint: (Color red alpha: 0.5) width: 2) ];
		passive;
		connect:
			{(1 -> 12).
			(11 -> 19)}
			from: #key
			to: #value.
	view layout radialTree.
	^ view
]

{ #category : #'tutorial - advanced' }
GtMondrianBasicExamples >> passiveEdgesWithNesting [
	<gtExample>
	| view |
	view := self emptyView.
	view nodes
		shape: [ :x | 
			BlElement new 
				geometry: BlEllipse new; 
				border: (BlBorder paint: Color black);
				constraintsDo: [ :c | c padding: (BlInsets all: 10) ] ];
		with: (1 to: 9)
		forEach: [ :each |
			view nodes 
				shape: [ :x | BlTextElement new text: x asString asRopedText ];
				with: (10 * each to: (10 * each + 9)).
			view layout circle radius: 50 ].
	view edges 
		fromCenterBottom;
		toCenterTop;
		connectFrom: [ :x | x // 2 ].
	view edges 
		shape: [ :x |
			BlLineElement new
				border: (BlBorder paint: (Color red alpha: 0.5) width: 5) ];
		passive; 
		connect: { 1->53 . 11 -> 19 } from: #key to: #value.
	view layout tree.
	^ view
]

{ #category : #'tutorial - nodes, edges, layouts' }
GtMondrianBasicExamples >> twoNodes [
	<gtExample>
	| view |
	view := self emptyView.
	view nodes with: {1 . 2}.
	self assert: view topStep root children size equals: 2.
	^ view
]

{ #category : #'node creation' }
GtMondrianBasicExamples >> twoNodesWithEmptyForEach [
	<gtExample>
	| view |
	view := self emptyView.
	view nodes with: {1 . 2} forEach: [ :each |  ].
	self assert: view topStep root children size equals: 2.
	^ view
]

{ #category : #'node creation' }
GtMondrianBasicExamples >> twoNodesWithNodesInForEach [
	<gtExample>
	| view |
	view := self emptyView.
	view nodes
		with:
			{{1 . 2 . 3}.
			{4}}
		forEach: [ :collection | view nodes with: collection ].
	self assert: view topStep root children size equals: 2.
	self assert: view topStep root children first children size equals: 3.
	self assert: view topStep root children last children size equals: 1.
	self
		assert: view topStep root children last children first graph model
		equals: 4.
	^ view
]
