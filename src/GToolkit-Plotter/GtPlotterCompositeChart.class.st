Class {
	#name : #GtPlotterCompositeChart,
	#superclass : #GtPlotterBuilder,
	#instVars : [
		'plots'
	],
	#category : #'GToolkit-Plotter-Builder - Composite Chart'
}

{ #category : #'private - plots' }
GtPlotterCompositeChart >> addPlot: aPlotterBuilder [
	<return: #GtPlotterBuilder>
	
	plots add: aPlotterBuilder.
	^ aPlotterBuilder
]

{ #category : #'api - instantiation' }
GtPlotterCompositeChart >> create [
	<return: #Object>
	| aContainer |

	aContainer := BlElement new.
	aContainer constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	aContainer addChildren: (plots collect: [ :eachPlot | eachPlot asElement ]).
	^ aContainer
]

{ #category : #initialization }
GtPlotterCompositeChart >> gtLiveFor: aView [
	<gtView>
	^ aView explicit
		title: 'Live';
		stencil: [ self asElement ]
]

{ #category : #'api - builders' }
GtPlotterCompositeChart >> horizontalBarChart [
	^ self addPlot: GtPlotterHorizontalBarChart new
]

{ #category : #'api - builders' }
GtPlotterCompositeChart >> horizontalTimeline [
	^ self addPlot: GtPlotterHorizontalTimeline new
]

{ #category : #initialization }
GtPlotterCompositeChart >> initialize [
	super initialize.
	
	plots := OrderedCollection new
]

{ #category : #'api - builders' }
GtPlotterCompositeChart >> verticalBarChart [
	^ self addPlot: nil
]

{ #category : #'api - builders' }
GtPlotterCompositeChart >> verticalTimeline [
	^ self addPlot: GtPlotterVerticalTimeline new
]
