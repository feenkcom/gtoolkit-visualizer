Class {
	#name : #GtGraphCirclePackLayoutExamples,
	#superclass : #GtGraphLayoutExamples,
	#category : #'GToolkit-BlocGraph-Layouts-Examples'
}

{ #category : #example }
GtGraphCirclePackLayoutExamples >> squaredNodes [
	<gtExample>
	<return: #BlLayoutParentNodeWithEdges>
	| aParentNode aLayout |
	aParentNode := self createNodes: 20 extent: 50 @ 50.

	aLayout := GtGraphCirclePackLayout new.
	aLayout measure: aParentNode.	"self assert: aParentNode children layoutBounds equals: {
		(200@100) corner: (220@120).
		(195@131) corner: (215@151).
		(181@159) corner: (201@179).
		(159@181) corner: (179@201).
		(131@195) corner: (151@215).
		(100@200) corner: (120@220).
		(69@195) corner: (89@215).
		(41@181) corner: (61@201).
		(19@159) corner: (39@179).
		(5@131) corner: (25@151).
		(0@100) corner: (20@120).
		(5@69) corner: (25@89).
		(19@41) corner: (39@61).
		(41@19) corner: (61@39).
		(69@5) corner: (89@25).
		(100@0) corner: (120@20).
		(131@5) corner: (151@25).
		(159@19) corner: (179@39).
		(181@41) corner: (201@61).
		(195@69) corner: (215@89)
	}."

	^ aParentNode
]
