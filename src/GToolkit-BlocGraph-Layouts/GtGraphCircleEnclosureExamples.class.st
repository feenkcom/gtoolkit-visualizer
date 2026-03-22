Class {
	#name : #GtGraphCircleEnclosureExamples,
	#superclass : #Object,
	#category : #'GToolkit-BlocGraph-Layouts-Examples'
}

{ #category : #accessing }
GtGraphCircleEnclosureExamples >> emptyEnclosure [
	<gtExample>
	<return: #GtGraphCircleEnclosure>
	^ GtGraphCircleEnclosure new
]

{ #category : #'as yet unclassified' }
GtGraphCircleEnclosureExamples >> enclosureWithFourCircles [
	<gtExample>
	<return: #GtGraphCircleEnclosure>
	^ self enclosureWithThreeCircles
		addCircle: (GtGraphCircle new
				radius: 20;
				margin: 10;
				center: 240 @ 50)
]

{ #category : #'as yet unclassified' }
GtGraphCircleEnclosureExamples >> enclosureWithOneCircle [
	<gtExample>
	<return: #GtGraphCircleEnclosure>
	^ self emptyEnclosure
		addCircle: (GtGraphCircle new
				radius: 40;
				margin: 20;
				center: 50 @ 50)
]

{ #category : #'as yet unclassified' }
GtGraphCircleEnclosureExamples >> enclosureWithThreeCircles [
	<gtExample>
	<return: #GtGraphCircleEnclosure>
	^ self enclosureWithTwoCircles
		addCircle: (GtGraphCircle new
				radius: 20;
				margin: 10;
				center: 140 @ 0)
]

{ #category : #'as yet unclassified' }
GtGraphCircleEnclosureExamples >> enclosureWithTwoCircles [
	<gtExample>
	<return: #GtGraphCircleEnclosure>
	^ self enclosureWithOneCircle
		addCircle: (GtGraphCircle new
				radius: 30;
				margin: 10;
				center: 130 @ 130)
]
