Class {
	#name : #GtPlotter,
	#superclass : #BrStencil,
	#instVars : [
		'plots'
	],
	#category : #'GToolkit-Plotter-! Plotter'
}

{ #category : #'private - plots' }
GtPlotter >> addPlot: aPlotterBuilder [
	<return: #GtPlotterBuilder>
	
	plots add: aPlotterBuilder.
	^ aPlotterBuilder
]

{ #category : #'api - instantiation' }
GtPlotter >> create [
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
GtPlotter >> gtLiveFor: aView [
	<gtView>
	^ aView explicit
		title: 'Live';
		stencil: [ self asElement ]
]

{ #category : #'api - builders' }
GtPlotter >> horizontalBarChart [
	^ self addPlot: GtPlotterHorizontalBarChart new
]

{ #category : #'api - builders' }
GtPlotter >> horizontalTimeline [
	^ self addPlot: GtPlotterHorizontalTimeline new
]

{ #category : #initialization }
GtPlotter >> initialize [
	super initialize.
	
	plots := OrderedCollection new
]

{ #category : #accessing }
GtPlotter >> root [
	self
		deprecated: 'Use #asElement instead.'
		transformWith: '`@receiver root' -> '`@receiver asElement'.

	^ self asElement
]

{ #category : #'api - builders' }
GtPlotter >> verticalBarChart [
	^ self addPlot: nil
]

{ #category : #'api - builders' }
GtPlotter >> verticalTimeline [
	^ self addPlot: GtPlotterVerticalTimeline new
]
