Class {
	#name : #GtPlotterCoreExamples,
	#superclass : #Object,
	#category : #'GToolkit-Plotter-Examples'
}

{ #category : #'instance creation' }
GtPlotterCoreExamples >> axisX [
	<gtExample>
	| anAxisX |
	
	anAxisX := BlElement new.
	anAxisX background: (Color black alpha: 0.2).
	anAxisX constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical exact: 50 ].
	anAxisX constraintsDo: [ :c | c plotter horizontal axis: (GtPlotterContinuousAxis new valueSelector: #yourself) ].
	
	^ anAxisX
]

{ #category : #'instance creation' }
GtPlotterCoreExamples >> axisY [
	<gtExample>
	| anAxisY |

	anAxisY := BlElement new.
	anAxisY background: (Color black alpha: 0.2).
	anAxisY constraintsDo: [ :c |
		c horizontal exact: 50.
		c vertical matchParent ].
	anAxisY constraintsDo: [ :c | c plotter vertical axis: (GtPlotterContinuousAxis new valueSelector: #yourself) ].

	^ anAxisY
]

{ #category : #'instance creation' }
GtPlotterCoreExamples >> plotWithAxisXY [
	<gtExample>
	| anElement |
	
	anElement := BlElement new.
	anElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	anElement layout: GtPlotterLayout new.
	anElement addChildren: { self axisX . self axisY }.

	^ anElement
]
