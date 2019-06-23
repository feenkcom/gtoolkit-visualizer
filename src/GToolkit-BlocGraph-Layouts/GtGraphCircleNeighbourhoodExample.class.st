Class {
	#name : #GtGraphCircleNeighbourhoodExample,
	#superclass : #Object,
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Circle'
}

{ #category : #'as yet unclassified' }
GtGraphCircleNeighbourhoodExample >> emptyNeighborhood [
	<gtExample>
	^ GtGraphCircleNeighbourhood new
]

{ #category : #'as yet unclassified' }
GtGraphCircleNeighbourhoodExample >> emptyNeighborhoodWithThreeCircles [
	<gtExample>
	| n |
	n := GtGraphCircleNeighbourhood new.
	n addCircle: (GtGraphCircle new 
		radius: 30;
		margin: 20).
	n addCircle: (GtGraphCircle new 
		radius: 30;
		margin: 20).
	n addCircle: (GtGraphCircle new 
		radius: 10;
		margin: 10).
	^ n
]

{ #category : #'as yet unclassified' }
GtGraphCircleNeighbourhoodExample >> emptyNeighborhoodWithThreeCirclesAndSpace [
	<gtExample>
	| n |
	n := GtGraphCircleNeighbourhood new.
	n 
		circles: { 
			GtGraphCircle new 
				radius: 30;
				margin: 20;
				center: 50@50.
			GtGraphCircle new 
				radius: 30;
				margin: 20;
				center: 130@130}
		neighbour: (
			GtGraphCircle new 
				radius: 20;
				margin: 10).
	^ n
]
