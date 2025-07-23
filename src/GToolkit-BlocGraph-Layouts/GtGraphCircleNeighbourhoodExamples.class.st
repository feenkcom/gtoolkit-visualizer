Class {
	#name : #GtGraphCircleNeighbourhoodExamples,
	#superclass : #Object,
	#category : #'GToolkit-BlocGraph-Layouts-Examples'
}

{ #category : #'as yet unclassified' }
GtGraphCircleNeighbourhoodExamples >> emptyNeighborhood [
	<gtExample>
	<return: #GtGraphCircleNeighbourhood>
	^ GtGraphCircleNeighbourhood new
]

{ #category : #'as yet unclassified' }
GtGraphCircleNeighbourhoodExamples >> emptyNeighborhoodWithThreeCircles [
	<gtExample>
	<return: #GtGraphCircleNeighbourhood>
	| n |
	n := GtGraphCircleNeighbourhood new.
	n
		addCircle: (GtGraphCircle new
				radius: 30;
				margin: 20).
	n
		addCircle: (GtGraphCircle new
				radius: 30;
				margin: 20).
	n
		addCircle: (GtGraphCircle new
				radius: 10;
				margin: 10).
	^ n
]

{ #category : #'as yet unclassified' }
GtGraphCircleNeighbourhoodExamples >> emptyNeighborhoodWithThreeCirclesAndSpace [
	<gtExample>
	<return: #GtGraphCircleNeighbourhood>
	| n |
	n := GtGraphCircleNeighbourhood new.
	n
		circles: {GtGraphCircle new
					radius: 30;
					margin: 20;
					center: 50 @ 50.
				GtGraphCircle new
					radius: 30;
					margin: 20;
					center: 130 @ 130}
		neighbour: (GtGraphCircle new
				radius: 20;
				margin: 10).
	^ n
]
