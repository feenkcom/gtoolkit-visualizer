Class {
	#name : #GtGraphGridLayoutExamples,
	#superclass : #GtGraphLayoutExamples,
	#category : #'GToolkit-BlocGraph-Layouts-Examples'
}

{ #category : #example }
GtGraphGridLayoutExamples >> squareOfSquares [
	<gtExample>
	| aParentNode aLayout |

	aParentNode := self
		createNodes: 16
		extent: 20@20.

	aLayout := GtGraphGridLayout new.
	aLayout measure: aParentNode.
	
	self assert: aParentNode children measuredBounds equals: {
		(0.0@0.0) corner: (20.0@20.0).
		(25.0@0.0) corner: (45.0@20.0).
		(50.0@0.0) corner: (70.0@20.0).
		(75.0@0.0) corner: (95.0@20.0).
		(0.0@25.0) corner: (20.0@45.0).
		(25.0@25.0) corner: (45.0@45.0).
		(50.0@25.0) corner: (70.0@45.0).
		(75.0@25.0) corner: (95.0@45.0).
		(0.0@50.0) corner: (20.0@70.0).
		(25.0@50.0) corner: (45.0@70.0).
		(50.0@50.0) corner: (70.0@70.0).
		(75.0@50.0) corner: (95.0@70.0).
		(0.0@75.0) corner: (20.0@95.0).
		(25.0@75.0) corner: (45.0@95.0).
		(50.0@75.0) corner: (70.0@95.0).
		(75.0@75.0) corner: (95.0@95.0)
	}.

	^ aParentNode
]
