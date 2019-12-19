Class {
	#name : #GtGraphTreemapLayoutExamples,
	#superclass : #GtGraphLayoutExamples,
	#category : #'GToolkit-BlocGraph-Layouts-Examples'
}

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

{ #category : #'examples - nodes' }
GtGraphTreemapLayoutExamples >> node [
	<gtExample>
	| aNode |
	aNode := GtGraphTreemapNode new.
	self assert: aNode weight isNil.
	^ aNode
]

{ #category : #'examples - numbers' }
GtGraphTreemapLayoutExamples >> numbers [
	<gtExample>
	| aView theElements |
	aView := self view.
	theElements := self nodes: (1 to: 5).
	theElements do: [ :eachElement | 
		eachElement background: Color random.
		eachElement constraintsDo: [ :c | 
			c treemap weight: (eachElement userData at: #model) ] ].
	aView addChildren: theElements.
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
GtGraphTreemapLayoutExamples >> numbersSliceVertical [
	<gtExample>
	| aView |
	aView := self numbers.
	aView layout: GtGraphTreemapLayout verticalSlice.
	self applyLayoutIn: aView.
	^ aView
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

{ #category : #'building - graph' }
GtGraphTreemapLayoutExamples >> view [
	^ super view
		constraintsDo: [ :constraints |
			constraints horizontal matchParent.
			constraints vertical matchParent ]
]
