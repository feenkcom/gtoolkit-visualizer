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

{ #category : #'as yet unclassified' }
GtPlotterCompositeChart >> axisXStencils [
	| aCollection aUniqueCollection |
	aCollection := plots collect: [ :eachPlot | eachPlot axisXStencil ].
	aUniqueCollection := OrderedCollection new.
	aCollection do: [ :newStencil | 
		(aUniqueCollection anySatisfy: [ :addedStencil | newStencil sameAs: addedStencil ])
			ifFalse: [ aUniqueCollection add: newStencil ] ].
	^ aUniqueCollection
]

{ #category : #'as yet unclassified' }
GtPlotterCompositeChart >> axisYStencils [
	| aCollection aUniqueCollection |
	aCollection := plots collect: [ :eachPlot | eachPlot axisYStencil ].
	aUniqueCollection := OrderedCollection new.
	aCollection do: [ :newStencil | 
		(aUniqueCollection anySatisfy: [ :addedStencil | newStencil sameAs: addedStencil ])
			ifFalse: [ aUniqueCollection add: newStencil ] ].
	^ aUniqueCollection
]

{ #category : #'as yet unclassified' }
GtPlotterCompositeChart >> contentStencils [
	^ plots collect: [ :eachPlot | eachPlot contentStencil ]
]

{ #category : #'api - instantiation' }
GtPlotterCompositeChart >> create [
	<return: #Object>
	| aContainer axisYStencils |

	aContainer := BrHorizontalGrid new
		cellSpacing: 0;
		columnCount: 2;
		matchParent;
		padding: (BlInsets all: 20).
	
	axisYStencils := self axisYStencils.
	
	aContainer addChild: axisYStencils first asElement.
	
	aContainer addChildren: { 
		BrFrame new
			matchParent;
			addChildren: (self contentStencils collect: #asElement).
	 }.

	axisYStencils size > 1 ifTrue: [ 
		aContainer columnCount: 3.
		aContainer addChildren: { 
			BrHorizontalPane new
				vMatchParent;
				hFitContent;
				clipChildren: false;
				addChildren: (self axisYStencils allButFirst collect: [ :e | e reversed asElement ]).
		 } ].
	
	aContainer addChild: self newEmptyElement.
	
	aContainer addChildren: { 
		BrVerticalPane new
			hMatchParent;
			vFitContent;
			clipChildren: false;
			addChildren: (self axisXStencils collect: #asElement).
	 }.
	
	^ aContainer
]

{ #category : #initialization }
GtPlotterCompositeChart >> gtLiveFor: aView [
	<gtView>
	^ aView explicit
		title: 'Live';
		stencil: [ self asElement ]
]

{ #category : #accessing }
GtPlotterCompositeChart >> gtPlotsFor: aView [
	<gtView>
	self plots ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Plots';
		items: [ self plots ];
		column: 'Index' item: [ :anItem :anIndex | anIndex ] width: 40;
		column: 'Plot' item: #yourself
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
GtPlotterCompositeChart >> lineChart [
	^ self addPlot: GtPlotterLineChart new
]

{ #category : #'instance creation' }
GtPlotterCompositeChart >> newAxisYLineElement [
	^ BlElement new
		width: 2;
		background: (Color veryVeryLightGray);
		constraintsDo: [ :c | 
			c vertical matchParent.
			c frame horizontal alignLeft ]
]

{ #category : #'instance creation' }
GtPlotterCompositeChart >> newEmptyElement [
	^ BlElement new
		size: 0@0;
		visibility: BlVisibility hidden
]

{ #category : #accessing }
GtPlotterCompositeChart >> plots [
	^ plots
]

{ #category : #'api - builders' }
GtPlotterCompositeChart >> verticalBarChart [
	^ self addPlot: nil
]

{ #category : #'api - builders' }
GtPlotterCompositeChart >> verticalTimeline [
	^ self addPlot: GtPlotterVerticalTimeline new
]
