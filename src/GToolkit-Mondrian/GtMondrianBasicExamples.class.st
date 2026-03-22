"
1. Mondrian basics
Mondrian is an engine for graph-based visualization. While its roots date back to 2005, there have been multiple incarnations since then. The current version is based on Bloc and makes extensive use of its mechanisms. As a result it requires a very short implementation that is specific to visualizing graphs. It turns out that most of the things we need for graphs are actually generic concepts that can be used for all sorts of other graphical needs.

To get a more concrete idea of what Mondrian is about, let's consider some examples. 
1. # A few examples

The first example shows a tree made of nodes and interconnecting edges that are organized as a radial tree. Except that there are also two red edges that do not affect the layout.

{{gtExample:GtMondrianBasicExamples>>#passiveEdges|previewExpanded|noCode=|previewShow=#gtLiveFor:}}

Another one shows a UML-like visualization of a class hierarchy.

{{gtExample:GtMondrianDomainExamples>>#umlClasses|previewExpanded|noCode=|previewShow=#gtLiveFor:|previewHeight=400}}

Each of these examples are similar in that they are constructed as transformations of some input data into pictures. Yet, the transformation is different: 
- One shows a tree with nodes represented as rectangles. Another one shows nodes represented as UML class elements. 
- One shows only simple nodes. Another one also shows nested nodes.
- Most drawn edges affect the visualization, except for two red ones that even if thicker they are passive ones.
1. # A tutorial
## Nodes, edges and layouts

The most basic parts of a Mondrian view are:
1. Nodes
2. Edges
3. Layout

Let's see how we create these. First the nodes.

{{gtExample:GtMondrianBasicExamples>>#multipleNodes|previewExpanded}}

Given those nodes, we can build edges.

{{gtExample:GtMondrianBasicExamples>>#edgesBetweenNodes|previewExpanded}}

And finally, we lay them out.

{{gtExample:GtMondrianBasicExamples>>#layoutOnEdgesBetweenNodes|previewExpanded}}
1. ## Shapes

The look and feel of nodes and edges is specified by Shapes, which can be included in the construction of nodes and edges.

A shape can be defined by a block that takes the node's model object as its argument and returns an instance of a Bloc element. In the example below, we see nine nodes drawn as circles with black borders, whose sizes depend on the number which each node represents.

{{gtExample:GtMondrianBasicExamples>>#nodesWithEllipses|previewExpanded}}

We can define the shape of edges in a similar way. In the example below, the nodes are connected by blue edges whose width varies depending on the node it tries to connect.

{{gtExample:GtMondrianBasicExamples>>#edgesWithThickerLines|previewExpanded}}
1. ## Nesting

Mondrian graphs can also be nested. In other words, a node can have a subgraph.

{{gtExample:GtMondrianBasicExamples>>#nestedNodes|previewExpanded}}

Nested nodes behave like leaf nodes in that they can be connected through edges and laid out accordingly.

{{gtExample:GtMondrianBasicExamples>>#nestedWithEdges|previewExpanded}}
1. # Differences to previous incarnations of Mondrian

The API has changed in comparison with the Roassal version because of the constraints and opportunities offered by Bloc:
- Nodes are defined through `view nodes with: { ... }`, instead of `view nodes: { ... }`. One reason is to make the definition more similar to the one of edges.
- Shapes are defined within the scope of a `view nodes` or `view edges` definition.
- Shapes are mainly defined explicitly by instantiating of `BlElement` and its subclasses.
- The `forEach:` clause can be cascaded after `view nodes with: {...}`. This allows us to have multiple `forEach:` statements per one nodes definition.
- The new `forEach:in:` allows the user to define the id of the container for the children. In this way, we can define children in different parts of the parent node.


"
Class {
	#name : #GtMondrianBasicExamples,
	#superclass : #Object,
	#category : #'GToolkit-Mondrian-Examples'
}

{ #category : #'debugging edge creation' }
GtMondrianBasicExamples >> capturingEdgesNotCreated [
	<gtExample>
	<noTest>
	"The example it not sound.

	it does
		l := MemoryLogger new.
		l runDuring: [ ].
		self assert: l recordings size equals: 3.

	which is not thread safe (edited) 
	if there is another thread that sends signals in the meantime, then there will be more recordings in 	the memory logger"
	
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

{ #category : #'tutorial - nodes, edges, layouts' }
GtMondrianBasicExamples >> edgesBetweenNodes [
	<gtExample>
	<return: #GtMondrian>
	| view |
	view := self multipleNodes.
	view edges
		connect: {1.
				2.
				3.
				4}
		from: [ :x | x // 2 ]
		to: [ :x | x ].
	self assert: view topStep root graph edgeChildren size equals: 3.
	^ view
]

{ #category : #'tutorial - shapes' }
GtMondrianBasicExamples >> edgesWithChangingColorsOnHover [
	<gtExample>
	<return: #GtMondrian>
	| m |
	m := GtMondrian new.
	m nodes
		stencil: [ :x | 
			BlElement new
				border: (BlBorder paint: Color black);
				geometry: BlEllipseGeometry new;
				size: (x * 2) @ (x * 2);
				when: BlMouseEnterEvent
					do: [ :anEvent | 
						anEvent currentTarget graph connectedEdges
							do: [ :inner | inner element border: (BlBorder paint: (Color red alpha: 0.5)) ] ];
				when: BlMouseLeaveEvent
					do: [ :anEvent | 
						anEvent currentTarget graph connectedEdges
							do: [ :inner | inner element border: (BlBorder paint: (Color blue alpha: 0.5)) ] ] ];
		with: (1 to: 9).
	m edges
		stencil: [ :x | 
			BlLineElement new
				zIndex: -1;
				border: (BlBorder paint: (Color blue alpha: 0.5)) ];
		connectFrom: [ :x | x // 2 ].
	m layout tree.
	^ m
]

{ #category : #'tutorial - shapes' }
GtMondrianBasicExamples >> edgesWithTextAndThickerLinesHorizontalTree [
	<gtExample>
	<return: #GtMondrian>
	| view |
	view := self nodesWithText.
	view edges
		fromRightCenter;
		toLeftCenter;
		stencil: [ :x | 
			BlLineElement new
				border: (BlBorder paint: (Color lightGray alpha: 0.4) width: x) ];
		connectFrom: [ :x | x // 2 ].
	view topStep root graph edgeChildren
		do: [ :edgeChild | self assert: edgeChild border width > 1 ].
	view layout horizontalTree levelDistance: 40.
	^ view
]

{ #category : #'tutorial - shapes' }
GtMondrianBasicExamples >> edgesWithThickerLines [
	<gtExample>
	<return: #GtMondrian>
	| view |
	view := self nodesWithEllipses.
	view edges
		stencil: [ :x | BlLineElement new border: (BlBorder paint: (Color blue alpha: 0.5) width: x) ];
		connectFrom: [ :x | x // 2 ].
	view topStep root graph edgeChildren
		do: [ :edgeChild | 
			self
				assert: edgeChild border width = edgeChild graph connectedNodes asArray last graph model ].
	view layout tree.
	^ view
]

{ #category : #'tutorial - shapes' }
GtMondrianBasicExamples >> edgesWithThickerLinesDependingOnTheFromNode [
	<gtExample>
	<return: #GtMondrian>
	| view |
	view := self nodesWithEllipses.
	view edges
		stencil: [ :aNumber :fromElement :toElement | 
			BlLineElement new
				border: (BlBorder paint: (Color blue alpha: 0.5) width: fromElement graph model) ];
		connectFrom: [ :x | x // 2 ].
	view topStep root graph edgeChildren
		do: [ :edgeChild | 
			self
				assert: edgeChild border width
						= edgeChild graph connectedNodes asArray first graph model ].
	view layout tree.
	^ view
]

{ #category : #'tutorial - shapes' }
GtMondrianBasicExamples >> edgesWithThickerLinesHorizontalTree [
	<gtExample>
	<return: #GtMondrian>
	| view |
	view := self nodesWithEllipses.
	view edges
		stencil: [ :x | BlLineElement new border: (BlBorder paint: (Color blue alpha: 0.5) width: x) ];
		connectFrom: [ :x | x // 2 ].
	view root graph edgeChildren
		do: [ :edgeElement | self assert: edgeElement border width > 1 ].
	view layout horizontalTree.
	^ view
]

{ #category : #'examples shapes' }
GtMondrianBasicExamples >> elipseWithCustomShape [
	<gtExample>
	<return: #GtMondrian>
	| view |
	view := GtMondrian new.
	view nodes
		stencil: [ :anInteger | 
			BlElement new
				geometry: BlEllipseGeometry new;
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
	<return: #GtMondrian>
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
	<return: #GtMondrian>
	| view |
	view := GtMondrian new.
	view nodes
		stencil: [ :anInteger :anElement | 
			anElement
				geometry: BlEllipseGeometry new;
				size: (anInteger max: 5) asPoint;
				constraintsDo: [ :constraints | constraints padding: (BlInsets all: 10) ] ];
		with: (1 to: 20).
	view layout circle radius: 200.
	^ view
]

{ #category : #'tutorial - nodes, edges, layouts' }
GtMondrianBasicExamples >> emptyView [
	<gtExample>
	<return: #GtMondrian>
	| view |
	view := GtMondrian new.
	self assert: view topStep root children isEmpty.
	^ view
]

{ #category : #'tutorial - nodes, edges, layouts' }
GtMondrianBasicExamples >> layoutOnEdgesBetweenNodes [
	<gtExample>
	<return: #GtMondrian>
	| view |
	view := self edgesBetweenNodes.
	view layout tree.
	self assert: (view root layout isKindOf: BlOnceLayout).
	self assert: view root layout layout notNil.
	^ view
]

{ #category : #'tutorial - nodes, edges, layouts' }
GtMondrianBasicExamples >> multipleNodes [
	<gtExample>
	<return: #GtMondrian>
	| view |
	view := self emptyView.
	view nodes
		with: {1.
				2.
				3.
				4}.
	self assert: view topStep root children size equals: 4.
	^ view
]

{ #category : #'tutorial - nesting' }
GtMondrianBasicExamples >> nestedNodes [
	<gtExample>
	<return: #GtMondrian>
	| view |
	view := self emptyView.
	view nodes
		stencil: [ :x | 
			BlElement new
				background: Color paleOrange;
				constraintsDo: [ :c | c margin: (BlInsets all: 10) ] ];
		with: (1 to: 9)
			forEach: [ :each | 
				view nodes
					stencil: [ :x | BlTextElement new text: x asString asRopedText ];
					with: (10 * each to: 10 * each + 4).
				view layout circle radius: 20 ].
	self assert: view root children size = 9.
	view root children do: [ :child | self assert: child children size = 5 ].
	^ view
]

{ #category : #'node creation' }
GtMondrianBasicExamples >> nestedNodesInDifferentContainers [
	<gtExample>
	<return: #GtMondrian>
	| view |
	view := GtMondrian new.
	view nodes
		stencil: [ :anObject | 
			| label labelContainer contents1 contents2 grid |
			label := BlTextElement new
					text: anObject asString asRopedText;
					padding: (BlInsets all: 5);
					constraintsDo: [ :c | c frame horizontal alignCenter ].
			labelContainer := BlElement new.
			labelContainer
				layout: BlFrameLayout new;
				background: Color white;
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
					addChildren: {labelContainer.
							contents1.
							contents2} ];
		with: {1.
				2};
		forEach: [ :each | 
				view nodes
					with: {10.
							11.
							12} ]
			in: #one;
		forEach: [ :each | 
				view nodes
					with: {20.
							21} ]
			in: #two.
	view layout grid.
	^ view
]

{ #category : #'node creation' }
GtMondrianBasicExamples >> nestedNodesWithDefaultUMLClassShape [
	<gtExample>
	<return: #GtMondrian>
	| view |
	view := GtMondrian new.
	view nodes
		stencil: [ :each | GtMondrianUMLClassElement withDefaultContainer ];
		with: (1 to: 10);
		forEach: [ :each | view nodes with: (1 to: 10) ].
	^ view
]

{ #category : #'tutorial - advanced' }
GtMondrianBasicExamples >> nestedNodesWithGlobalEdges [
	<gtExample>
	<return: #GtMondrian>
	| view |
	view := self emptyView.
	view nodes
		stencil: [ :each | GtMondrianUMLClassElement withDefaultContainer label: each asString ];
		with: {1 to: 3.
					4 to: 6}
			forEach: [ :collection | 
				view nodes
					stencil: [ :x | BlTextElement new text: x asString asRopedText ];
					with: collection.
				view layout circle ].
	view edges
		connect: {1 -> 2.
				3 -> 1.
				1 -> 4.
				4 -> 6.
				5 -> 6}
		from: [ :x | x key ]
		to: [ :x | x value ].
	view layout circle radius: 100.
	self
		assert: (view root children select: [ :each | each graph isEdge ]) size = 5.
	^ view
]

{ #category : #'node creation' }
GtMondrianBasicExamples >> nestedNodesWithUMLClassShape [
	<gtExample>
	<return: #GtMondrian>
	| view |
	view := GtMondrian new.
	view nodes
		stencil: [ :each | GtMondrianUMLClassElement withContainers: #(one two) ];
		with: (1 to: 10);
		forEach: [ :each | view nodes with: (1 to: 10) ] in: #one;
		forEach: [ :each | view nodes with: (1 to: 20) ] in: #two.
	^ view
]

{ #category : #'tutorial - nesting' }
GtMondrianBasicExamples >> nestedWithEdges [
	<gtExample>
	<return: #GtMondrian>
	| view |
	view := self nestedNodes.
	view edges
		fromCenterBottom;
		toCenterTop;
		connectFrom: [ :x | x // 2 ].
	view layout tree.
	self
		assert: (view root children select: [ :each | each graph isEdge ]) size = 8.
	^ view
]

{ #category : #'tutorial - shapes' }
GtMondrianBasicExamples >> nodesWithEllipses [
	<gtExample>
	<return: #GtMondrian>
	| view |
	view := GtMondrian new.
	view nodes
		stencil: [ :x | 
			BlElement new
				border: (BlBorder paint: Color black);
				geometry: BlEllipseGeometry new;
				size: (x * 2) @ (x * 2) ];
		with: (1 to: 9).
	self assert: view topStep root graph nodeChildren size = 9.
	^ view
]

{ #category : #'tutorial - shapes' }
GtMondrianBasicExamples >> nodesWithText [
	<gtExample>
	<return: #GtMondrian>
	| view |
	view := GtMondrian new.
	view nodes
		stencil: [ :x | 
			BlTextElement new
				text: x gtDisplayString asRopedText;
				padding: (BlInsets all: 5);
				geometry: BlEllipseGeometry new ];
		with: (1 to: 9).
	^ view
]

{ #category : #'node creation' }
GtMondrianBasicExamples >> oneNode [
	<gtExample>
	<return: #GtMondrian>
	| view |
	view := self emptyView.
	view nodes with: {1}.
	self assert: view topStep root children size equals: 1.
	^ view
]

{ #category : #'tutorial - advanced' }
GtMondrianBasicExamples >> passiveEdgeBetweenTwoNodes [
	<gtExample>
	<return: #GtMondrian>
	| m nodeElements |
	m := GtMondrian new.
	m nodes
		with: {1.
				2}.
	m edges
		passive;
		connect: {1 -> 2}
			from: #key
			to: #value.
	m layout tree.
	m root forceLayout.
	nodeElements := m root graph allNodeChildren.
	self assert: nodeElements size = 2.
	self assert: m root graph allEdgeChildren size = 1.
	self assert: nodeElements first bounds top = nodeElements last bounds top.
	^ m
]

{ #category : #'tutorial - advanced' }
GtMondrianBasicExamples >> passiveEdges [
	<gtExample>
	<return: #GtMondrian>
	| view |
	view := self emptyView.
	view nodes
		stencil: [ :x | BlTextElement new text: x asString asRopedText ];
		with: (1 to: 100).
	view edges connectFrom: [ :x | x // 2 ].
	view edges
		shape: [ :x | BlLineElement new border: (BlBorder paint: (Color red alpha: 0.5) width: 2) ];
		passive;
		connect: {1 -> 12.
					11 -> 19}
			from: #key
			to: #value.
	view layout tree.
	^ view
]

{ #category : #'tutorial - advanced' }
GtMondrianBasicExamples >> passiveEdgesWithNesting [
	<gtExample>
	<return: #GtMondrian>
	| view |
	view := self emptyView.
	view nodes
		stencil: [ :x | 
			BlElement new
				geometry: BlEllipseGeometry new;
				border: (BlBorder paint: Color black);
				constraintsDo: [ :c | c padding: (BlInsets all: 10) ] ];
		with: (1 to: 9)
			forEach: [ :each | 
				view nodes
					shape: [ :x | BlTextElement new text: x asString asRopedText ];
					with: (10 * each to: 10 * each + 9).
				view layout circle radius: 50 ].
	view edges
		fromCenterBottom;
		toCenterTop;
		connectFrom: [ :x | x // 2 ].
	view edges
		shape: [ :x | BlLineElement new border: (BlBorder paint: (Color red alpha: 0.5) width: 5) ];
		passive;
		connect: {1 -> 53.
					11 -> 19}
			from: #key
			to: #value.
	view layout tree.
	^ view
]

{ #category : #'node creation' }
GtMondrianBasicExamples >> twoNodesWithEmptyForEach [
	<gtExample>
	<return: #GtMondrian>
	| view |
	view := self emptyView.
	view nodes
		with: {1.
				2}
		forEach: [ :each |  ].
	self assert: view topStep root children size equals: 2.
	^ view
]

{ #category : #'node creation' }
GtMondrianBasicExamples >> twoNodesWithNodesInForEach [
	<gtExample>
	<return: #GtMondrian>
	| view |
	view := self emptyView.
	view nodes
		with: {{1.
					2.
					3}.
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
