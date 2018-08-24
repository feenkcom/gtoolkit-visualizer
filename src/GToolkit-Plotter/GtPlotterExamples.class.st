Class {
	#name : #GtPlotterExamples,
	#superclass : #Object,
	#category : 'GToolkit-Plotter'
}

{ #category : #examples }
GtPlotterExamples class >> examplePlotPoints [
	| space plot |
	
	plot := self new plot.
	plot size: 400@400.
	plot relocate: 50@50.	
	plot clipChildren: false.
	
	space := BlSpace new.
	space withHalos.
	space root addChild: plot.
	space show
]

{ #category : #'instance creation' }
GtPlotterExamples >> axis [
	<gtExample>

	^ GtPlotterContinuousAxis new
]

{ #category : #'instance creation' }
GtPlotterExamples >> axisElement [
	<gtExample>
	
	^ BlElement new
		background: (Color gray alpha: 0.5);
		geometry: BlEllipse new
]

{ #category : #'examples - basic' }
GtPlotterExamples >> data [
	<gtExample>

	^ (((1 to: 300) collect: [ :i | 200 atRandom @ 200 atRandom ])
		select: [ :aPoint | (aPoint y - (aPoint x / 2.0)) abs < 15 ])
		collect: [ :each | GtPlotterDomainObject new value: each ]
]

{ #category : #'instance creation' }
GtPlotterExamples >> dotElement [
	<gtExample>
	
	^ BlElement new
		geometry: BlEllipse new;
		size: 5@5;
		background: Color red
]

{ #category : #'examples - basic' }
GtPlotterExamples >> dots [
	<gtExample>
	
	^ self data
		collect: [ :anObject | self dotElement constraintsDo: [ :c | c plotter domainObject: anObject ] ]
]

{ #category : #'examples - basic' }
GtPlotterExamples >> horizontalAxis [
	<gtExample>
	
	^ self axisElement
		size: 400@20;
		constraintsDo: [ :c | c plotter horizontal axis: self axis ]
]

{ #category : #'examples - composite' }
GtPlotterExamples >> plot [
	<gtExample>
	| plot hAxis vAxis dots |
	
	plot := self plotterElementWithLayout.
	
	hAxis := self horizontalAxis.
	hAxis constraints plotter horizontal axis valueSelector: #x.
	
	vAxis := self verticalAxis.
	vAxis constraints plotter vertical axis valueSelector: #y.
	
	dots := self dots.
	
	^ plot addChildren: { hAxis . vAxis }, dots
]

{ #category : #'instance creation' }
GtPlotterExamples >> plotterElement [
	<gtExample>

	^ BlElement new
]

{ #category : #'instance creation' }
GtPlotterExamples >> plotterElementWithLayout [
	<gtExample>

	^ self plotterElement
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		layout: self plotterLayout
]

{ #category : #'instance creation' }
GtPlotterExamples >> plotterLayout [
	<gtExample>

	^ GtPlotterLayout new
]

{ #category : #'examples - basic' }
GtPlotterExamples >> verticalAxis [
	<gtExample>
	
	^ self axisElement
		size: 20@400;
		constraintsDo: [ :c | c plotter vertical axis: self axis ]
]
