Class {
	#name : #GtGraphTreemapLayoutExamples,
	#superclass : #GtGraphLayoutExamples,
	#category : #'GToolkit-BlocGraph-Layouts-Examples'
}

{ #category : #'examples - squarify' }
GtGraphTreemapLayoutExamples >> basicRow [
	<gtExample>
	| aRow |
	aRow := GtGraphTreemapSquarifyRow new.
	self assert: aRow allRows size equals: 1.
	self assert: aRow allRows first equals: aRow.
	^ aRow
]

{ #category : #'examples - nodes' }
GtGraphTreemapLayoutExamples >> basicSliceHorizontal [
	<gtExample>
	| aSlice |
	aSlice := GtGraphTreemapSlice horizontal.
	self assert: aSlice length isZero.
	self assert: aSlice breadth isZero.
	self assert: aSlice nodes isEmpty.
	self assert: aSlice extent equals: 0@0.
	self assert: aSlice remainingExtent equals: 0@0.
	^ aSlice
]

{ #category : #'examples - nodes' }
GtGraphTreemapLayoutExamples >> basicSliceVertical [
	<gtExample>
	| aSlice |
	aSlice := GtGraphTreemapSlice vertical.
	self assert: aSlice length isZero.
	self assert: aSlice breadth isZero.
	self assert: aSlice nodes isEmpty.
	self assert: aSlice extent equals: 0@0.
	self assert: aSlice remainingExtent equals: 0@0.
	^ aSlice
]

{ #category : #'examples - squarify' }
GtGraphTreemapLayoutExamples >> basicSquarify [
	<gtExample>
	| aTree |
	aTree := GtGraphTreemap squarify.
	self assert: aTree area isZero.
	self assert: aTree nodes isEmpty.
	^ aTree
]

{ #category : #'examples - nodes' }
GtGraphTreemapLayoutExamples >> node [
	<gtExample>
	| aNode |
	aNode := GtGraphTreemapNode new.
	self assert: aNode weight isNil.
	^ aNode
]

{ #category : #'examples - numbers' }
GtGraphTreemapLayoutExamples >> numberElements [
	<gtExample>
	| theElements |
	theElements := self nodes: (1 to: 5).
	theElements do: [ :eachElement | 
		eachElement background: Color random.
		eachElement constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent.
			c treemap weight: (eachElement userData at: #model) ] ].
	^ theElements
]

{ #category : #'examples - numbers' }
GtGraphTreemapLayoutExamples >> numbers [
	<gtExample>
	| aView |
	aView := self view.
	aView addChildren: self numberElements.
	^ aView
]

{ #category : #'examples - numbers' }
GtGraphTreemapLayoutExamples >> numbersSliceHorizontal [
	<gtExample>
	| aView |
	aView := self numbers.
	aView layout: GtGraphTreemapLayout horizontalSlice.
	self applyLayoutIn: aView.
	^ aView
]

{ #category : #'examples - numbers' }
GtGraphTreemapLayoutExamples >> numbersSliceHorizontalAndVertical [
	<gtExample>
	| aView |
	aView := self numbers.
	aView layout: GtGraphTreemapLayout horizontalSlice.
	aView children last
		addChildren: (self numberElements);
		layout: GtGraphTreemapLayout verticalSlice.
	self applyLayoutIn: aView.
	^ aView
]

{ #category : #'examples - numbers' }
GtGraphTreemapLayoutExamples >> numbersSliceHorizontalWithMarginAndPadding [
	<gtExample>
	| aView |
	aView := BlElement new
		padding: (BlInsets all: 50);
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		layout: GtGraphTreemapSliceHorizontalLayout new;
		addChildren: (10 timesCollect: [ :anIndex |
			BlElement new
				size: 30@30;
				constraintsDo: [ :c |
				c margin: (BlInsets all: 2).
					c horizontal matchParent.
					c vertical matchParent.
					c treemap weight: anIndex ];
				background: (Color indexedColors at: anIndex) ]).
	^ aView
]

{ #category : #'examples - numbers' }
GtGraphTreemapLayoutExamples >> numbersSliceVertical [
	<gtExample>
	| aView |
	aView := self numbers.
	aView layout: GtGraphTreemapLayout verticalSlice.
	self applyLayoutIn: aView.
	^ aView
]

{ #category : #'examples - squarify' }
GtGraphTreemapLayoutExamples >> row [
	<gtExample>
	| aRow |
	aRow := self basicRow.
	aRow extent: 600 @ 400.
	self assert: aRow extent equals: 600@400.
	self assert: aRow allRows size equals: 1.
	self assert: aRow allRows first equals: aRow.
	^ aRow
]

{ #category : #'examples - squarify' }
GtGraphTreemapLayoutExamples >> rowWithOneNode [
	<gtExample>
	| aRow |
	aRow := self row.
	aRow addNode: (self node weight: 1/4) "6".
	"aRow rectangle layoutRow: aRow."
	self assert: aRow nodesCount equals: 1.
	self assert: aRow extent equals: 600@400.
	self assert: aRow allRows size equals: 1.
	self assert: aRow allRows first equals: aRow.
	self assert: aRow worst equals: 8/3 "2.6666666666666665".
	^ aRow
]

{ #category : #'examples - squarify' }
GtGraphTreemapLayoutExamples >> rowWithThreeNodes [
	<gtExample>
	| aRow |
	aRow := self rowWithTwoNodes.
	aRow addNode: (self node weight: 1/6) "4".
	aRow rectangle layoutRow: aRow.
	self assert: aRow nodesCount equals: 3.
	self assert: aRow extent equals: 600@400.
	self assert: aRow allRows size equals: 1.
	self assert: aRow allRows first equals: aRow.
	self assert: aRow worst equals: 4.
	^ aRow
]

{ #category : #'examples - squarify' }
GtGraphTreemapLayoutExamples >> rowWithTwoNodes [
	<gtExample>
	| aRow |
	aRow := self rowWithOneNode.
	aRow addNode: (self node weight: 1/4) "6".
	aRow rectangle layoutRow: aRow.
	self assert: aRow nodesCount equals: 2.
	self assert: aRow extent equals: 600@400.
	self assert: aRow allRows size equals: 1.
	self assert: aRow allRows first equals: aRow.
	self assert: aRow worst equals: 3/2.
	^ aRow
]

{ #category : #'examples - squarify' }
GtGraphTreemapLayoutExamples >> rowWorstWithOneAndTwoNodes [
	<gtExample>
	|  aRowOne aRowTwo |
	aRowOne := self rowWithOneNode.
	aRowTwo := self rowWithTwoNodes.
	self assert: aRowOne worst >= aRowTwo worst.
	^ { aRowOne. aRowTwo }
]

{ #category : #'examples - squarify' }
GtGraphTreemapLayoutExamples >> rowWorstWithTwoAndThreeNodes [
	<gtExample>
	|  aRowOne aRowTwo |
	aRowOne := self rowWithTwoNodes.
	aRowTwo := self rowWithThreeNodes.
	self assert: aRowOne worst < aRowTwo worst.
	^ { aRowOne. aRowTwo }
]

{ #category : #'examples - nodes' }
GtGraphTreemapLayoutExamples >> sliceHorizontal [
	<gtExample>
	| aSlice |
	aSlice := self basicSliceHorizontal.
	aSlice length: 300; breadth: 50.
	self assert: aSlice nodes isEmpty.
	self assert: aSlice length equals: 300.
	self assert: aSlice breadth equals: 50.
	self assert: aSlice extent equals: 300@50.
	self assert: aSlice remainingExtent equals: 300@50.
	^ aSlice
]

{ #category : #'examples - nodes' }
GtGraphTreemapLayoutExamples >> sliceHorizontalWithOneNode [
	<gtExample>
	| aSlice aNode |
	aSlice := self sliceHorizontal.
	aNode := self node weight: 0.3.
	aSlice addNode: aNode.
	self assert: aSlice nodes size equals: 1.
	self assert: aSlice nodes first equals: aNode.
	self assert: aNode position equals: 0@0.
	self assert: aNode extent equals: 90@50.
	self assert: aSlice extent equals: 300@50.
	self assert: aSlice remainingExtent equals: 210@50.
	^ aSlice
]

{ #category : #'examples - nodes' }
GtGraphTreemapLayoutExamples >> sliceHorizontalWithThreeNodes [
	<gtExample>
	| aSlice aNode |
	aSlice := self sliceHorizontalWithTwoNodes.
	aNode := self node weight: 0.5.
	aSlice addNode: aNode.
	self assert: aSlice nodes size equals: 3.
	self assert: aSlice nodes third equals: aNode.
	self assert: aSlice nodes first position equals: 0@0.
	self assert: aSlice nodes first extent equals: 90@50.
	self assert: aSlice nodes second position equals: 90@0.
	self assert: aSlice nodes second extent equals: 60@50.
	self assert: aNode position equals: 150@0.
	self assert: aNode extent equals: 150@50.
	self assert: aSlice extent equals: 300@50.
	self assert: aSlice remainingExtent equals: 0@50.
	^ aSlice
]

{ #category : #'examples - nodes' }
GtGraphTreemapLayoutExamples >> sliceHorizontalWithTwoNodes [
	<gtExample>
	| aSlice aNode |
	aSlice := self sliceHorizontalWithOneNode.
	aNode := self node weight: 0.2.
	aSlice addNode: aNode.
	self assert: aSlice nodes size equals: 2.
	self assert: aSlice nodes second equals: aNode.
	self assert: aSlice nodes first position equals: 0@0.
	self assert: aSlice nodes first extent equals: 90@50.
	self assert: aNode position equals: 90@0.
	self assert: aNode extent equals: 60@50.
	self assert: aSlice extent equals: 300@50.
	self assert: aSlice remainingExtent equals: 150@50.
	^ aSlice
]

{ #category : #'examples - nodes' }
GtGraphTreemapLayoutExamples >> sliceVertical [
	<gtExample>
	| aSlice |
	aSlice := self basicSliceVertical.
	aSlice length: 300; breadth: 50.
	self assert: aSlice nodes isEmpty.
	self assert: aSlice length equals: 300.
	self assert: aSlice breadth equals: 50.
	self assert: aSlice extent equals: 50@300.
	self assert: aSlice remainingExtent equals: 50@300.
	^ aSlice
]

{ #category : #'examples - nodes' }
GtGraphTreemapLayoutExamples >> sliceVerticalWithOneNode [
	<gtExample>
	| aSlice aNode |
	aSlice := self sliceVertical.
	aNode := self node weight: 0.3.
	aSlice addNode: aNode.
	self assert: aSlice nodes size equals: 1.
	self assert: aSlice nodes first equals: aNode.
	self assert: aNode position equals: 0@0.
	self assert: aNode extent equals: 50@90.
	^ aSlice
]

{ #category : #'examples - nodes' }
GtGraphTreemapLayoutExamples >> sliceVerticalWithThreeNodes [
	<gtExample>
	| aSlice aNode |
	aSlice := self sliceVerticalWithTwoNodes.
	aNode := self node weight: 0.5.
	aSlice addNode: aNode.
	self assert: aSlice nodes size equals: 3.
	self assert: aSlice nodes third equals: aNode.
	self assert: aSlice nodes first position equals: 0@0.
	self assert: aSlice nodes first extent equals: 50@90.
	self assert: aSlice nodes second position equals: 0@90.
	self assert: aSlice nodes second extent equals: 50@60.
	self assert: aNode position equals: 0@150.
	self assert: aNode extent equals: 50@150.
	self assert: aSlice extent equals: 50@300.
	self assert: aSlice remainingExtent equals: 50@0.
	^ aSlice
]

{ #category : #'examples - nodes' }
GtGraphTreemapLayoutExamples >> sliceVerticalWithTwoNodes [
	<gtExample>
	| aSlice aNode |
	aSlice := self sliceVerticalWithOneNode.
	aNode := self node weight: 0.2.
	aSlice addNode: aNode.
	self assert: aSlice nodes size equals: 2.
	self assert: aSlice nodes second equals: aNode.
	self assert: aSlice nodes first position equals: 0@0.
	self assert: aSlice nodes first extent equals: 50@90.
	self assert: aNode position equals: 0@90.
	self assert: aNode extent equals: 50@60.
	self assert: aSlice extent equals: 50@300.
	self assert: aSlice remainingExtent equals: 50@150.
	^ aSlice
]

{ #category : #'examples - squarify' }
GtGraphTreemapLayoutExamples >> squarify [
	<gtExample>
	| aTree |
	aTree := GtGraphTreemap squarify.
	aTree width: 600 height: 400.
	self assert: aTree extent equals: 600@400.
	self assert: aTree area equals: 600 * 400.
	self assert: aTree nodes isEmpty.
	^ aTree
]

{ #category : #'examples - squarify' }
GtGraphTreemapLayoutExamples >> squarifyWithFiveNodes [
	<gtExample>
	| aTree aNode |
	aTree := self squarifyWithFourNodes.
	aNode := self node weight: 1/12 "2".
	aTree addNode: aNode.
	self assert: aTree allRows size equals: 3.
	self assert: aTree nodes size equals: 5.
	self assert: aTree nodes first position equals: 0@0.
	self assert: aTree nodes first extent equals: 300@200.
	self assert: aTree nodes second position equals: 0@200.
	self assert: aTree nodes second extent equals: 300@200.
	self assert: aTree nodes third position equals: 300@0.
	self assert: aTree nodes third extent equals: ((1200/7)@(700/3)).
	self assert: aTree nodes fourth position equals: ((3300/7)@0).
	self assert: aTree nodes fourth extent equals: ((900/7)@(700/3)).
	self assert: aTree nodes fifth equals: aNode.
	self assert: aTree nodes fifth position equals: (300@(700/3)).
	self assert: aTree nodes fifth extent equals: (120@(500/3)).
	self assert: aTree extent equals: 600@400.
	self assert: aTree area equals: 600 * 400.
	^ aTree
]

{ #category : #'examples - squarify' }
GtGraphTreemapLayoutExamples >> squarifyWithFourNodes [
	<gtExample>
	| aTree aNode |
	aTree := self squarifyWithThreeNodes.
	aNode := self node weight: 1/8 "3".
	aTree addNode: aNode.
	self assert: aTree allRows size equals: 2.
	self assert: aTree nodes size equals: 4.
	self assert: aTree nodes first position equals: 0@0.
	self assert: aTree nodes first extent equals: 300@200.
	self assert: aTree nodes second position equals: 0@200.
	self assert: aTree nodes second extent equals: 300@200.
	self assert: aTree nodes third position equals: 300@0.
	self assert: aTree nodes third extent equals: ((1200/7)@(700/3)).
	self assert: aTree nodes fourth equals: aNode.
	self assert: aTree nodes fourth position equals: ((3300/7)@0).
	self assert: aTree nodes fourth extent equals: ((900/7)@(700/3)).
	self assert: aTree extent equals: 600@400.
	self assert: aTree area equals: 600 * 400.
	^ aTree
]

{ #category : #'examples - squarify' }
GtGraphTreemapLayoutExamples >> squarifyWithOneNode [
	<gtExample>
	| aTree aNode |
	aTree := self squarify.
	aNode := self node weight: 1/4 "6".
	aTree addNode: aNode.
	self assert: aTree nodes size equals: 1.
	self assert: aTree nodes first equals: aNode.
	self assert: aTree nodes first position equals: 0@0.
	self assert: aTree nodes first extent equals: 150@400.
	self assert: aTree extent equals: 600@400.
	self assert: aTree area equals: 600 * 400.
	^ aTree
]

{ #category : #'examples - squarify' }
GtGraphTreemapLayoutExamples >> squarifyWithSevenNodes [
	<gtExample>
	| aTree aNode |
	aTree := self squarifyWithSixNodes.
	aNode := self node weight: 1/24 "1".
	aTree addNode: aNode.
	self assert: aTree allRows size equals: 4.
	self assert: aTree nodes size equals: 7.
	self assert: aTree nodes first position equals: 0@0.
	self assert: aTree nodes first extent equals: 300@200.
	self assert: aTree nodes second position equals: 0@200.
	self assert: aTree nodes second extent equals: 300@200.
	self assert: aTree nodes third position equals: 300@0.
	self assert: aTree nodes third extent equals: ((1200/7)@(700/3)).
	self assert: aTree nodes fourth position equals: ((3300/7)@0).
	self assert: aTree nodes fourth extent equals: ((900/7)@(700/3)).
	self assert: aTree nodes fifth position equals: (300@(700/3)).
	self assert: aTree nodes fifth extent equals: (240@(250/3)).
	self assert: aTree nodes sixth position equals: (300@(950/3)).
	self assert: aTree nodes sixth extent equals: (240@(250/3)).
	self assert: aTree nodes seventh equals: aNode.
	self assert: aTree nodes seventh position equals: (540@(700/3)).
	self assert: aTree nodes seventh extent equals: (60@(500/3)).
	self assert: aTree extent equals: 600@400.
	self assert: aTree area equals: 600 * 400.
	^ aTree
]

{ #category : #'examples - squarify' }
GtGraphTreemapLayoutExamples >> squarifyWithSixNodes [
	<gtExample>
	| aTree aNode |
	aTree := self squarifyWithFiveNodes.
	aNode := self node weight: 1/12 "2".
	aTree addNode: aNode.
	self assert: aTree allRows size equals: 3.
	self assert: aTree nodes size equals: 6.
	self assert: aTree nodes first position equals: 0@0.
	self assert: aTree nodes first extent equals: 300@200.
	self assert: aTree nodes second position equals: 0@200.
	self assert: aTree nodes second extent equals: 300@200.
	self assert: aTree nodes third position equals: 300@0.
	self assert: aTree nodes third extent equals: ((1200/7)@(700/3)).
	self assert: aTree nodes fourth position equals: ((3300/7)@0).
	self assert: aTree nodes fourth extent equals: ((900/7)@(700/3)).
	self assert: aTree nodes fifth position equals: (300@(700/3)).
	self assert: aTree nodes fifth extent equals: (240@(250/3)).
	self assert: aTree nodes sixth equals: aNode.
	self assert: aTree nodes sixth position equals: (300@(950/3)).
	self assert: aTree nodes sixth extent equals: (240@(250/3)).
	self assert: aTree extent equals: 600@400.
	self assert: aTree area equals: 600 * 400.
	^ aTree
]

{ #category : #'examples - squarify' }
GtGraphTreemapLayoutExamples >> squarifyWithThreeNodes [
	<gtExample>
	| aTree aNode |
	aTree := self squarifyWithTwoNodes.
	aNode := self node weight: 1/6 "4".
	aTree addNode: aNode.
	self assert: aTree allRows size equals: 2.
	self assert: aTree nodes size equals: 3.
	self assert: aTree nodes first position equals: 0@0.
	self assert: aTree nodes first extent equals: 300@200.
	self assert: aTree nodes second position equals: 0@200.
	self assert: aTree nodes second extent equals: 300@200.
	self assert: aTree nodes third equals: aNode.
	self assert: aTree nodes third position equals: 300@0.
	self assert: aTree nodes third extent equals: 300@ (400/3).
	self assert: aTree extent equals: 600@400.
	self assert: aTree area equals: 600 * 400.
	^ aTree
]

{ #category : #'examples - squarify' }
GtGraphTreemapLayoutExamples >> squarifyWithTwoNodes [
	<gtExample>
	| aTree aNode |
	aTree := self squarifyWithOneNode.
	aNode := self node weight: 1/4 "6".
	aTree addNode: aNode.
	self assert: aTree allRows size equals: 1.
	self assert: aTree nodes size equals: 2.
	self assert: aTree nodes first position equals: 0@0.
	self assert: aTree nodes first extent equals: 300@200.
	self assert: aTree nodes second equals: aNode.
	self assert: aTree nodes second position equals: 0@200.
	self assert: aTree nodes second extent equals: 300@200.
	self assert: aTree extent equals: 600@400.
	self assert: aTree area equals: 600 * 400.
	^ aTree
]

{ #category : #'building - graph' }
GtGraphTreemapLayoutExamples >> view [
	^ super view
		constraintsDo: [ :constraints |
			constraints horizontal matchParent.
			constraints vertical matchParent ]
]
