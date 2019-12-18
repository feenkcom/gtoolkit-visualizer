Class {
	#name : #GtGraphRectangleTreemapLayoutExamples,
	#superclass : #GtGraphLayoutExamples,
	#category : #'GToolkit-BlocGraph-Layouts-Examples'
}

{ #category : #'examples - numbers' }
GtGraphRectangleTreemapLayoutExamples >> numbers [
	<gtExample>
	| aView theElements |
	aView := self view.
	theElements := self nodes: (1 to: 5).
	theElements do: [ :eachElement | 
		eachElement background: Color random.
		eachElement constraintsDo: [ :c | 
			c treemap weight: (eachElement userData at: #model) ] ].
	aView addChildren: theElements.
	aView layout: GtGraphRectangleTreemapLayout new.
	self applyLayoutIn: aView.
	^ aView
]

{ #category : #'building - graph' }
GtGraphRectangleTreemapLayoutExamples >> view [
	^ super view
		constraintsDo: [ :constraints |
			constraints horizontal matchParent.
			constraints vertical matchParent ]
]
