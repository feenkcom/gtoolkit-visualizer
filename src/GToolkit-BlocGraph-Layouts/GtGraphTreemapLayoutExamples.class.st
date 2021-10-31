"
I exemplify {{gtClass:GtGraphTreemap}} layout algorithm.


"
Class {
	#name : #GtGraphTreemapLayoutExamples,
	#superclass : #GtGraphLayoutExamples,
	#category : 'GToolkit-BlocGraph-Layouts-Examples'
}

{ #category : #'examples - slice algorithm - code' }
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

{ #category : #'examples - slice algorithm - code' }
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

{ #category : #'examples - squarify algorithm - core' }
GtGraphTreemapLayoutExamples >> basicSquarify [
	<gtExample>
	| aTree |
	aTree := GtGraphTreemap squarify.
	self assert: aTree nodes isEmpty.
	^ aTree
]

{ #category : #'examples - squarify algorithm - steps' }
GtGraphTreemapLayoutExamples >> basicStep [
	<gtExample>
	| aStep |
	aStep := GtGraphTreemapSquarifyStep new.
	self assert: aStep extent equals: 0@0.
	self assert: aStep allSteps size equals: 1.
	self assert: aStep allSteps first equals: aStep.
	self assert: aStep nodes isEmpty.
	self assert: aStep worstValue isNaN.
	^ aStep
]

{ #category : #'examples - squarify algorithm - worst' }
GtGraphTreemapLayoutExamples >> basicWorstAspectRatio [
	<gtExample>
	| aWorst |
	aWorst := GtGraphTreemapSquarifyWorstAspectRatio new.
	self assert: aWorst nodes isEmpty.
	self assert: aWorst value isNaN.
	^ aWorst
]

{ #category : #'examples - utilities' }
GtGraphTreemapLayoutExamples >> graphUtilities [
	<gtExample>
	^ GtGraphUtilities default
]

{ #category : #'examples - slice algorithm - code' }
GtGraphTreemapLayoutExamples >> node [
	<gtExample>
	| aNode |
	aNode := GtGraphTreemapNode new.
	self assert: aNode weight isZero.
	^ aNode
]

{ #category : #'building - graph' }
GtGraphTreemapLayoutExamples >> numberElements [
	<gtExample>
	<noTest>
	| theElements |
	theElements := self nodes: #(6 6 4 3 2 2 1).
	theElements do: [ :eachElement | 
		eachElement background: Color random.
		eachElement constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent.
			c treemap weight: (eachElement userData at: #model) ] ].
	^ theElements
]

{ #category : #'building - graph' }
GtGraphTreemapLayoutExamples >> numbers [
	<gtExample>
	<noTest>
	| aView |
	aView := self view.
	aView addChildren: self numberElements.
	^ aView
]

{ #category : #'examples - layouts' }
GtGraphTreemapLayoutExamples >> numbersSliceHorizontal [
	<gtExample>
	<noTest>
	| aView |
	aView := self numbers.
	aView layout: GtGraphTreemapLayout horizontalSlice.
	self applyLayoutIn: aView.
	^ aView
]

{ #category : #'examples - layouts' }
GtGraphTreemapLayoutExamples >> numbersSliceHorizontalAndVertical [
	<gtExample>
	<noTest>
	| aView |
	aView := self numbers.
	aView layout: GtGraphTreemapLayout horizontalSlice.
	aView children last
		addChildren: (self numberElements);
		layout: GtGraphTreemapLayout verticalSlice.
	self applyLayoutIn: aView.
	^ aView
]

{ #category : #'examples - layouts' }
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

{ #category : #'examples - layouts' }
GtGraphTreemapLayoutExamples >> numbersSliceVertical [
	<gtExample>
	<noTest>
	| aView |
	aView := self numbers.
	aView layout: GtGraphTreemapLayout verticalSlice.
	self applyLayoutIn: aView.
	^ aView
]

{ #category : #'examples - layouts' }
GtGraphTreemapLayoutExamples >> numbersSquarified [
	<gtExample>
	<noTest>
	| aView |
	aView := self numbers.
	aView layout: GtGraphTreemapLayout squarify.
	self applyLayoutIn: aView.
	^ aView
]

{ #category : #'examples - utilities' }
GtGraphTreemapLayoutExamples >> rectangle [
	<gtExample>
	| aRectangle |
	aRectangle := GtGraphTreemapSquarifyAreaRectangle new.
	self assert: aRectangle position equals: 0 @ 0.
	self assert: aRectangle extent equals: 0 @ 0.
	self assert: aRectangle original equals: aRectangle.
	^ aRectangle
]

{ #category : #'examples - utilities' }
GtGraphTreemapLayoutExamples >> rectangleAsElementWithInformation [
	<gtExample>
	| aRectangle anElement |
	aRectangle := self rectangle.
	aRectangle 
		position: 3@6; 
		extent: 9@12.
	anElement := aRectangle asElementWithInformation.
	self assert: anElement isNotNil.
	self assert: (anElement isKindOf: BlElement).
	^ aRectangle
]

{ #category : #'examples - utilities' }
GtGraphTreemapLayoutExamples >> rectangleWithMarginAndInformationUtility [
	<gtExample>
	| anElement |
	anElement := self graphUtilities rectangleOn: self extent: 600@400 margin: (BlInsets all: 20).
	self graphUtilities informationForRectangle: anElement bounds: (0@0 extent: 600@400).
	^ anElement asScalableElement
]

{ #category : #'examples - utilities' }
GtGraphTreemapLayoutExamples >> rectangleWithMarginUtility [
	<gtExample>
	| anElement |
	anElement := self graphUtilities rectangleOn: self extent: 600@400 margin: (BlInsets all: 20).
	self assert: anElement childrenCount equals: 2.
	^ anElement asScalableElement
]

{ #category : #'examples - utilities' }
GtGraphTreemapLayoutExamples >> rectangleWithOriginalAsElementWithInformation [
	<gtExample>
	| aRectangle anElement anOriginal |
	anOriginal := self rectangle.
	anOriginal 
		position: 7@14; 
		extent: 108@72.
	aRectangle := self rectangle.
	aRectangle 
		original: anOriginal;
		position: 14@21; 
		extent: 21@12.
	anElement := aRectangle asElementWithInformation.
	self assert: anElement isNotNil.
	self assert: (anElement isKindOf: BlElement).
	^ aRectangle
]

{ #category : #'examples - slice algorithm - code' }
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

{ #category : #'examples - slice algorithm - code' }
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

{ #category : #'examples - slice algorithm - code' }
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

{ #category : #'examples - slice algorithm - code' }
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

{ #category : #'examples - slice algorithm - code' }
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

{ #category : #'examples - slice algorithm - code' }
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

{ #category : #'examples - slice algorithm - code' }
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

{ #category : #'examples - slice algorithm - code' }
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

{ #category : #'examples - squarify algorithm - core' }
GtGraphTreemapLayoutExamples >> squarify [
	<gtExample>
	| aTree |
	aTree := self basicSquarify.
	aTree width: 600 height: 400.
	self assert: aTree extent equals: 600@400.
	self assert: aTree nodes isEmpty.
	^ aTree
]

{ #category : #'examples - squarify algorithm - core' }
GtGraphTreemapLayoutExamples >> squarifyWithFiveNodes [
	<gtExample>
	| aTree aNode |
	aTree := self squarifyWithFourNodes.
	aNode := self node value: 2; totalValue: 24; weight: 1 / 12. "2"
	aTree addNode: aNode.
	self assert: aTree allSteps size equals: 7.
	self assert: aTree nodes size equals: 5.
	self assert: aTree nodes first position equals: 0 @ 0.
	self assert: aTree nodes first extent equals: 300 @ 200.
	self assert: aTree nodes second position equals: 0 @ 200.
	self assert: aTree nodes second extent equals: 300 @ 200.
	self assert: aTree nodes third position equals: 300 @ 0.
	self assert: aTree nodes third extent equals: (1200 / 7) @ (700 / 3).
	self assert: aTree nodes fourth position equals: (3300 / 7) @ 0.
	self assert: aTree nodes fourth extent equals: (900 / 7) @ (700 / 3).
	self assert: aTree nodes fifth equals: aNode.
	self assert: aTree nodes fifth position equals: 300 @ (700 / 3).
	self assert: aTree nodes fifth extent equals: 120 @ (500 / 3).
	self assert: aTree extent equals: 600 @ 400.
	^ aTree
]

{ #category : #'examples - squarify algorithm - core' }
GtGraphTreemapLayoutExamples >> squarifyWithFourNodes [
	<gtExample>
	| aTree aNode |
	aTree := self squarifyWithThreeNodes.
	aNode := self node value: 3; totalValue: 24; weight: 1 / 8.	"3"
	aTree addNode: aNode.
	self assert: aTree allSteps size equals: 5.
	self assert: aTree nodes size equals: 4.
	self assert: aTree nodes first position equals: 0 @ 0.
	self assert: aTree nodes first extent equals: 300 @ 200.
	self assert: aTree nodes second position equals: 0 @ 200.
	self assert: aTree nodes second extent equals: 300 @ 200.
	self assert: aTree nodes third position equals: 300 @ 0.
	self assert: aTree nodes third extent equals: (1200 / 7) @ (700 / 3).
	self assert: aTree nodes fourth equals: aNode.
	self assert: aTree nodes fourth position equals: (3300 / 7) @ 0.
	self assert: aTree nodes fourth extent equals: (900 / 7) @ (700 / 3).
	self assert: aTree extent equals: 600 @ 400.
	^ aTree
]

{ #category : #'examples - squarify algorithm - core' }
GtGraphTreemapLayoutExamples >> squarifyWithFourNodesFirstArea [
	<gtExample>
	| anArea |
	anArea := self squarifyWithFourNodes allSteps first.
	self assert: anArea nodesCount equals: 1.
	^ anArea
]

{ #category : #'examples - squarify algorithm - core' }
GtGraphTreemapLayoutExamples >> squarifyWithFourNodesSecondArea [
	<gtExample>
	| anArea |
	anArea := self squarifyWithFourNodes allSteps second.
	self assert: anArea nodesCount equals: 2.
	^ anArea
]

{ #category : #'examples - squarify algorithm - core' }
GtGraphTreemapLayoutExamples >> squarifyWithOneNode [
	<gtExample>
	| aTree aNode |
	aTree := self squarify.
	aNode := self node value: 6; totalValue: 24; weight: 1/4 "6".
	aTree addNode: aNode.
	self assert: aTree nodes size equals: 1.
	self assert: aTree nodes first equals: aNode.
	self assert: aTree nodes first position equals: 0@0.
	self assert: aTree nodes first extent equals: 150@400.
	self assert: aTree extent equals: 600@400.
	^ aTree
]

{ #category : #'examples - squarify algorithm - core' }
GtGraphTreemapLayoutExamples >> squarifyWithSevenNodes [
	<gtExample>
	| aTree aNode |
	aTree := self squarifyWithSixNodes.
	aNode := self node value: 1; totalValue: 24; weight: 1 / 24.	"1"
	aTree addNode: aNode.
	self assert: aTree allSteps size equals: 11.
	self assert: aTree nodes size equals: 7.
	self assert: aTree nodes first position equals: 0 @ 0.
	self assert: aTree nodes first extent equals: 300 @ 200.
	self assert: aTree nodes second position equals: 0 @ 200.
	self assert: aTree nodes second extent equals: 300 @ 200.
	self assert: aTree nodes third position equals: 300 @ 0.
	self assert: aTree nodes third extent equals: (1200 / 7) @ (700 / 3).
	self assert: aTree nodes fourth position equals: (3300 / 7) @ 0.
	self assert: aTree nodes fourth extent equals: (900 / 7) @ (700 / 3).
	self assert: aTree nodes fifth position equals: 300 @ (700 / 3).
	self assert: aTree nodes fifth extent equals: 120 @ (500 / 3).
	self assert: aTree nodes sixth position equals: 420 @ (700 / 3).
	self assert: aTree nodes sixth extent equals: 120 @ (500 / 3).
	self assert: aTree nodes seventh equals: aNode.
	self assert: aTree nodes seventh position equals: 540 @ (700 / 3).
	self assert: aTree nodes seventh extent equals: 60 @ (500 / 3).
	self assert: aTree extent equals: 600 @ 400.
	^ aTree
]

{ #category : #'examples - squarify algorithm - core' }
GtGraphTreemapLayoutExamples >> squarifyWithSevenNodesFifthStep [
	<gtExample>
	| aTree aStep |
	aTree := self squarifyWithSevenNodes.
	aStep := aTree allSteps fifth.
	self assert: aStep nodesCount equals: 2.
	^ aStep
]

{ #category : #'examples - squarify algorithm - core' }
GtGraphTreemapLayoutExamples >> squarifyWithSevenNodesFirstStep [
	<gtExample>
	| aTree aStep |
	aTree := self squarifyWithSevenNodes.
	aStep := aTree allSteps first.
	self assert: aStep nodesCount equals: 1.
	^ aStep
]

{ #category : #'examples - squarify algorithm - core' }
GtGraphTreemapLayoutExamples >> squarifyWithSevenNodesFourthStep [
	<gtExample>
	| aTree aStep |
	aTree := self squarifyWithSevenNodes.
	aStep := aTree allSteps fourth.
	self assert: aStep nodesCount equals: 1.
	^ aStep
]

{ #category : #'examples - squarify algorithm - core' }
GtGraphTreemapLayoutExamples >> squarifyWithSevenNodesSecondStep [
	<gtExample>
	| aTree aStep |
	aTree := self squarifyWithSevenNodes.
	aStep := aTree allSteps second.
	self assert: aStep nodesCount equals: 2.
	^ aStep
]

{ #category : #'examples - squarify algorithm - core' }
GtGraphTreemapLayoutExamples >> squarifyWithSevenNodesSeventhStep [
	<gtExample>
	| aTree aStep |
	aTree := self squarifyWithSevenNodes.
	aStep := aTree allSteps seventh.
	self assert: aStep nodesCount equals: 1.
	^ aStep
]

{ #category : #'examples - squarify algorithm - core' }
GtGraphTreemapLayoutExamples >> squarifyWithSevenNodesSixthStep [
	<gtExample>
	| aTree aStep |
	aTree := self squarifyWithSevenNodes.
	aStep := aTree allSteps sixth.
	self assert: aStep nodesCount equals: 3.
	^ aStep
]

{ #category : #'examples - squarify algorithm - core' }
GtGraphTreemapLayoutExamples >> squarifyWithSevenNodesThirdStep [
	<gtExample>
	| aTree aStep |
	aTree := self squarifyWithSevenNodes.
	aStep := aTree allSteps third.
	self assert: aStep nodesCount equals: 3.
	^ aStep
]

{ #category : #'examples - squarify algorithm - core' }
GtGraphTreemapLayoutExamples >> squarifyWithSixNodes [
	<gtExample>
	| aTree aNode |
	aTree := self squarifyWithFiveNodes.
	aNode := self node value: 2; totalValue: 24; weight: 1 / 12.	"2"
	aTree addNode: aNode.
	self assert: aTree allSteps size equals: 9.
	self assert: aTree nodes size equals: 6.
	self assert: aTree nodes first position equals: 0 @ 0.
	self assert: aTree nodes first extent equals: 300 @ 200.
	self assert: aTree nodes second position equals: 0 @ 200.
	self assert: aTree nodes second extent equals: 300 @ 200.
	self assert: aTree nodes third position equals: 300 @ 0.
	self assert: aTree nodes third extent equals: (1200 / 7) @ (700 / 3).
	self assert: aTree nodes fourth position equals: (3300 / 7) @ 0.
	self assert: aTree nodes fourth extent equals: (900 / 7) @ (700 / 3).
	self assert: aTree nodes fifth position equals: 300 @ (700 / 3).
	self assert: aTree nodes fifth extent equals: 120 @ (500 / 3).
	self assert: aTree nodes sixth equals: aNode.
	self assert: aTree nodes sixth position equals: 420 @ (700 / 3).
	self assert: aTree nodes sixth extent equals: 120 @ (500 / 3).
	self assert: aTree extent equals: 600 @ 400.
	^ aTree
]

{ #category : #'examples - squarify algorithm - core' }
GtGraphTreemapLayoutExamples >> squarifyWithThreeNodes [
	<gtExample>
	| aTree aNode |
	aTree := self squarifyWithTwoNodes.
	aNode := self node value: 4; totalValue: 24; weight: 1 / 6.	"4"
	aTree addNode: aNode.
	self assert: aTree allSteps size equals: 4.
	self assert: aTree nodes size equals: 3.
	self assert: aTree nodes first position equals: 0 @ 0.
	self assert: aTree nodes first extent equals: 300 @ 200.
	self assert: aTree nodes second position equals: 0 @ 200.
	self assert: aTree nodes second extent equals: 300 @ 200.
	self assert: aTree nodes third equals: aNode.
	self assert: aTree nodes third position equals: 300 @ 0.
	self assert: aTree nodes third extent equals: 300 @ (400 / 3).
	self assert: aTree extent equals: 600 @ 400.
	^ aTree
]

{ #category : #'examples - squarify algorithm - core' }
GtGraphTreemapLayoutExamples >> squarifyWithTwoNodes [
	<gtExample>
	| aTree aNode |
	aTree := self squarifyWithOneNode.
	aNode := self node value: 6; totalValue: 24; weight: 1 / 4.	"6"
	aTree addNode: aNode.
	self assert: aTree allSteps size equals: 2.
	self assert: aTree nodes size equals: 2.
	self assert: aTree nodes first position equals: 0 @ 0.
	self assert: aTree nodes first extent equals: 300 @ 200.
	self assert: aTree nodes second equals: aNode.
	self assert: aTree nodes second position equals: 0 @ 200.
	self assert: aTree nodes second extent equals: 300 @ 200.
	self assert: aTree extent equals: 600 @ 400.
	^ aTree
]

{ #category : #'examples - squarify algorithm - core' }
GtGraphTreemapLayoutExamples >> squarifyZeroHeight [
	<gtExample>
	| aTree |
	aTree := self basicSquarify.
	aTree width: 600 height: 0.
	self assert: aTree extent equals: 600@0.
	self assert: aTree nodes isEmpty.
	^ aTree
]

{ #category : #'examples - squarify algorithm - core' }
GtGraphTreemapLayoutExamples >> squarifyZeroHeightWithOneNode [
	<gtExample>
	| aTree aNode |
	aTree := self squarifyZeroHeight.
	aNode := self node value: 6; totalValue: 24; weight: 1/4 "6".
	aTree addNode: aNode.
	self assert: aTree nodes size equals: 1.
	self assert: aTree nodes first equals: aNode.
	self assert: aTree nodes first position equals: 0@0.
	self assert: aTree nodes first extent equals: 0@0.
	self assert: aTree extent equals: 600@0.
	^ aTree
]

{ #category : #'examples - squarify algorithm - core' }
GtGraphTreemapLayoutExamples >> squarifyZeroWidth [
	<gtExample>
	| aTree |
	aTree := self basicSquarify.
	aTree width: 0 height: 400.
	self assert: aTree extent equals: 0@400.
	self assert: aTree nodes isEmpty.
	^ aTree
]

{ #category : #'examples - squarify algorithm - core' }
GtGraphTreemapLayoutExamples >> squarifyZeroWidthWithOneNode [
	<gtExample>
	| aTree aNode |
	aTree := self squarifyZeroWidth.
	aNode := self node value: 6; totalValue: 24; weight: 1/4 "6".
	aTree addNode: aNode.
	self assert: aTree nodes size equals: 1.
	self assert: aTree nodes first equals: aNode.
	self assert: aTree nodes first position equals: 0@0.
	self assert: aTree nodes first extent equals: 0@0.
	self assert: aTree extent equals: 0@400.
	^ aTree
]

{ #category : #'examples - squarify algorithm - steps' }
GtGraphTreemapLayoutExamples >> step [
	<gtExample>
	| aStep |
	aStep := self basicStep.
	aStep extent: 600 @ 400.
	self assert: aStep extent equals: 600@400.
	self assert: aStep allSteps size equals: 1.
	self assert: aStep allSteps first equals: aStep.
	^ aStep
]

{ #category : #'examples - squarify algorithm - steps' }
GtGraphTreemapLayoutExamples >> stepWithOneNode [
	<gtExample>
	| aStep |
	aStep := self step.
	aStep addNode: (self node value: 6; totalValue: 24; weight: 1 / 4).	"6"
	aStep squarifyNodes.
	self assert: aStep nodesCount equals: 1.
	self assert: aStep extent equals: 600 @ 400.
	self assert: aStep allSteps size equals: 1.
	self assert: aStep allSteps first equals: aStep.
	self assert: aStep worstValue equals: 8 / 3.	"2.6666666666666665"
	^ aStep
]

{ #category : #'examples - squarify algorithm - steps' }
GtGraphTreemapLayoutExamples >> stepWithThreeNodes [
	<gtExample>
	| aStep |
	aStep := self stepWithTwoNodes.
	aStep addNode: (self node value: 4; totalValue: 24; weight: 1 / 6).	"4"
	aStep squarifyNodes.
	self assert: aStep nodesCount equals: 3.
	self assert: aStep extent equals: 600 @ 400.
	self assert: aStep allSteps size equals: 1.
	self assert: aStep allSteps first equals: aStep.
	self assert: aStep worstValue equals: 4.
	^ aStep
]

{ #category : #'examples - squarify algorithm - steps' }
GtGraphTreemapLayoutExamples >> stepWithTwoNodes [
	<gtExample>
	| aStep |
	aStep := self stepWithOneNode.
	aStep addNode: (self node value: 6; totalValue: 24; weight: 1 / 4).	"6"
	aStep squarifyNodes.
	self assert: aStep nodesCount equals: 2.
	self assert: aStep extent equals: 600 @ 400.
	self assert: aStep allSteps size equals: 1.
	self assert: aStep allSteps first equals: aStep.
	self assert: aStep worstValue equals: 3 / 2.
	^ aStep
]

{ #category : #'examples - squarify algorithm - steps' }
GtGraphTreemapLayoutExamples >> stepWorstWithOneAndTwoNodes [
	<gtExample>
	|  aStepOne aStepTwo |
	aStepOne := self stepWithOneNode.
	aStepTwo := self stepWithTwoNodes.
	self assert: aStepOne worst >= aStepTwo worst.
	^ { aStepOne. aStepTwo }
]

{ #category : #'examples - squarify algorithm - steps' }
GtGraphTreemapLayoutExamples >> stepWorstWithTwoAndThreeNodes [
	<gtExample>
	|  aStepOne aStepTwo |
	aStepOne := self stepWithTwoNodes.
	aStepTwo := self stepWithThreeNodes.
	self assert: aStepTwo worst >= aStepOne worst.
	^ { aStepOne. aStepTwo }
]

{ #category : #'building - graph' }
GtGraphTreemapLayoutExamples >> view [
	^ super view
		constraintsDo: [ :constraints |
			constraints horizontal matchParent.
			constraints vertical matchParent ]
]

{ #category : #'examples - squarify algorithm - worst' }
GtGraphTreemapLayoutExamples >> worstAspectRatio [
	<gtExample>
	| aWorst |
	aWorst := self basicWorstAspectRatio.
	aWorst totalArea: 600 * 400.
	aWorst length: 400.
	self assert: aWorst totalArea equals: 600 * 400.
	self assert: aWorst length equals: 400.
	^ aWorst
]

{ #category : #'examples - squarify algorithm - worst' }
GtGraphTreemapLayoutExamples >> worstAspectRatioWithOneNode [
	<gtExample>
	| aWorst |
	aWorst := self worstAspectRatio.
	aWorst addNode: (self node weight: 1/4) "6".
	self assert: aWorst value equals: 400/150.
	^ aWorst
]

{ #category : #'examples - squarify algorithm - worst' }
GtGraphTreemapLayoutExamples >> worstAspectRatioWithOneNodeInSecondArea [
	<gtExample>
	| aWorst |
	aWorst := self worstAspectRatio.
	aWorst length: 300.
	aWorst addNode: (self node weight: 1/6) "4".
	self assert: aWorst value equals: 2.25.
	^ aWorst
]

{ #category : #'examples - squarify algorithm - worst' }
GtGraphTreemapLayoutExamples >> worstAspectRatioWithOneNodeInThirdArea [
	<gtExample>
	| aWorst |
	aWorst := self worstAspectRatio.
	aWorst length: 400 - (700/3).
	aWorst addNode: (self node weight: 1/12) "2".
	self assert: aWorst value equals: 25/18 "1.3988".
	^ aWorst
]

{ #category : #'examples - squarify algorithm - worst' }
GtGraphTreemapLayoutExamples >> worstAspectRatioWithThreeNodes [
	<gtExample>
	| aWorst |
	aWorst := self worstAspectRatio.
	aWorst addNode: (self node weight: 1/4) "6".
	aWorst addNode: (self node weight: 1/4) "6".
	aWorst addNode: (self node weight: 1/6) "4".
	self assert: aWorst value equals: 4.
	^ aWorst
]

{ #category : #'examples - squarify algorithm - worst' }
GtGraphTreemapLayoutExamples >> worstAspectRatioWithTwoNodes [
	<gtExample>
	| aWorst |
	aWorst := self worstAspectRatio.
	aWorst addNode: (self node weight: 1/4) "6".
	aWorst addNode: (self node weight: 1/4) "6".
	self assert: aWorst value equals: 1.5.
	^ aWorst
]

{ #category : #'examples - squarify algorithm - worst' }
GtGraphTreemapLayoutExamples >> worstAspectRatioWithTwoNodesInThirdArea [
	<gtExample>
	| aWorst |
	aWorst := self worstAspectRatio.
	aWorst length: 400 - (700/3).
	aWorst addNode: (self node weight: 1/12) "2".
	aWorst addNode: (self node weight: 1/12) "2".
	self assert: aWorst value equals: 72/25 "2.88".
	^ aWorst
]
