"
!How does Mondrian relate to Bloc

Mondrian is a graph visualization engine that works directly with the generic Bloc graphical engine. In essence, Mondrian acts like a builder of a Bloc scene. This means that everything that can be achieved with Mondrian can also be achieved using plain Bloc elements. At the same time, it also means that Mondrian can benefit from all widgets and abilities already present in Bloc.


!!Understanding nodes

Let us consider a simple example with a visualization showing a few nodes:

${example:GtMondrianVsBlocExplanation>>#multipleNodes|previewExpanded=}$


Mondrian does not have its own internal model for representing the graph. Instead it builds directly an ${class:BlElement}$:

${example:GtMondrianVsBlocExplanation>>#rootWithMultipleNodes|previewExpanded=}$

The root element holds the elements that represent our nodes. Mondrian is only a shallow builder of elements and this offers quite some flexibility in customizing the rendering. For example, if we want to specify a custom element for each node, we can do that like this:

${example:GtMondrianVsBlocExplanation>>#multipleNodesWithStencil|previewExpanded=}$


!!Working with Bloc

Mondrian being a builder for Bloc, also means that the same result can be obtained by working directly with Bloc:

${example:GtMondrianVsBlocExplanation>>#blocWithMultipleNodes|previewExpanded=}$


!!The graph extensions in Bloc

By default, the Bloc model does not know about graphs. For example, an element does not know that it is supposed to be a node in a graph, and it does not know how to get to the other connected nodes. That is mandatory as Bloc is generic and a graph imposes a specific kind of contraints. Nevertheless, when working with graphs, it would still be useful to navigate a scene using a high level graph knowledge.

This is achieved through a ==graph== extension. For example, below we see how to query the ${method:GtGraphElementContext>>#nodeChildren}$, and how the resulting collection of elements answers ==true== to ${method:GtGraphElementContext>>#isNode}$.

${example:GtMondrianVsBlocExplanation>>#graphNodeChildrenOfRoot}$

For more details about the graph API, please browse ${class:GtGraphElementContext}$.


!!Dealing with lines and edges

A key benefit of using Mondrian is the ability of creating edges in a declarative manner, without having to maintain an intermediate data structure or to traverse the nodes explicitly.

${example:GtMondrianVsBlocExplanation>>#multipleNodesWithEdges|previewExpanded=}$

As Mondrian works directly with Bloc, we can also combine the two worlds. For example, in the example below we create edges explicitly and add them to the root element created with Mondrian. To create these edges, we traverse the nodes and then explicitly connect them. There are two things to note: 
# The newly created edges do affect the layout, but they do not have corresponding visible lines. This is because in Bloc, an edge is only a constraint. To create a line, we need an explicit line element. Mondrian creates both at the same time.
# There is extra code that is required when working directly with Bloc.

${example:GtMondrianVsBlocExplanation>>#rootWithHybridEdges|previewExpanded=}$




"
Class {
	#name : #GtMondrianVsBlocExplanation,
	#superclass : #Object,
	#category : #'GToolkit-Mondrian-Examples'
}

{ #category : #accessing }
GtMondrianVsBlocExplanation >> blocWithMultipleNodes [
	<gtExample>
	| root |
	root := BlElement new constraintsDo: [ :c |
	    c horizontal fitContent.
	    c vertical fitContent ].
	(1 to: 9) do: [ :x |
		root addChild: ( BlTextElement new text: x asString asRopedText )].
	root layout: (BlGridLayout new 
		columnCount: root children size sqrt asInteger;
		cellSpacing: 2).
	^ root asPannableElement
]

{ #category : #accessing }
GtMondrianVsBlocExplanation >> graphNodeChildrenOfRoot [
	<gtExample>
	| root nodeChildren |
	root := self rootWithMultipleNodes.
	nodeChildren := root graph nodeChildren.
	self assert:nodeChildren size = 9.
	nodeChildren do: [ :aChild| 
		self assert: aChild graph isNode
	].
	^ nodeChildren 
]

{ #category : #accessing }
GtMondrianVsBlocExplanation >> multipleNodes [
	<gtExample>
	| m |
	m := GtMondrian new.
	m nodes with: (1 to: 9).
	m layout grid.
	^ m
]

{ #category : #accessing }
GtMondrianVsBlocExplanation >> multipleNodesWithEdges [
	<gtExample>
	| m |
	m := self multipleNodesWithStencil.
	m edges connect: { 5->1 . 5->3 . 5->8} from: #key to: #value.
	self assert: m root graph edgeChildren size = 3.
	m root graph edgeChildren do: [ :aChild |
		self assert: aChild graph isEdge ].
	^ m
]

{ #category : #accessing }
GtMondrianVsBlocExplanation >> multipleNodesWithStencil [
	<gtExample>
	| m |
	m := GtMondrian new.
	m nodes 
		stencil: [ :x | BlTextElement new text: x asString asRopedText ];
		with: (1 to: 9).
	m layout grid.
	^ m
]

{ #category : #accessing }
GtMondrianVsBlocExplanation >> rootWithHybridEdges [
	<gtExample>
	| m root node6 node7 node9 |
	m := self multipleNodesWithEdges.
	root := m root.
	node6 := root graph nodeChildren detect: [ :aChild | aChild graph model = 6].
	node7 := root graph nodeChildren detect: [ :aChild | aChild graph model = 7].
	node9 := root graph nodeChildren detect: [ :aChild | aChild graph model = 9].
	node6 graph connectTo: node7.
	node6 graph connectTo: node9.
	root layout: GtGradVerticalTreeLayout new.
	^ root
]

{ #category : #accessing }
GtMondrianVsBlocExplanation >> rootWithMultipleNodes [
	<gtExample>
	| m |
	m := self multipleNodes.
	self assert: (m root isKindOf: BlElement).
	self assert: m root children size = 9.
	^ m root
]
