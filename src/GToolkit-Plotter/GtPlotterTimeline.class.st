Class {
	#name : #GtPlotterTimeline,
	#superclass : #GtPlotterBuilder,
	#instVars : [
		'timelineStencil',
		'timelineLabelFormat',
		'timelineDataBlock',
		'projectionDataBlock',
		'projectionLabelFormat',
		'projectionLineStencil',
		'timeScale',
		'amountOfTicks',
		'axisType',
		'data'
	],
	#classVars : [
		'AxisProjection',
		'AxisTicks'
	],
	#category : #'GToolkit-Plotter-Builder - Timeline'
}

{ #category : #'class initialization' }
GtPlotterTimeline class >> initialize [	
	AxisProjection := #projection.
	AxisTicks := #ticks
]

{ #category : #initialization }
GtPlotterTimeline >> initialize [
	super initialize.
	
	timelineDataBlock := [ :eachDataItem | eachDataItem ].
	timelineLabelFormat := [ :eachDateAndTime | 
			(eachDateAndTime monthAbbreviation, ' ',  eachDateAndTime year asString) asRopedText 
				glamorousRegularFontAndSize 
				foreground: Color darkGray ].

	projectionDataBlock := [ :eachDataItem | eachDataItem ].
	projectionLabelFormat := [ :eachObject | eachObject asRopedText 
		glamorousRegularFontAndSize 
		foreground: Color black ].

	timeScale := GtPlotterTimeScale new.
	amountOfTicks := 10.
	axisType := AxisProjection
]

{ #category : #'api - builder' }
GtPlotterTimeline >> projectionData: aBlock [
	projectionDataBlock := aBlock
]

{ #category : #'api - builder' }
GtPlotterTimeline >> projectionLabelFormat: aBlock [
	projectionLabelFormat := aBlock
]

{ #category : #'api - builder' }
GtPlotterTimeline >> projectionLineStencil: aStencil [
	"Set a stencil used to create a horizontal line of the data point projections"

	projectionLineStencil := aStencil asStencil
]

{ #category : #initialization }
GtPlotterTimeline >> spacing [
	^ 15
]

{ #category : #'api - builder' }
GtPlotterTimeline >> timelineData: aBlock [
	timelineDataBlock := aBlock
]

{ #category : #'api - builder' }
GtPlotterTimeline >> timelineFrom: aFromDate to: aToDate [
	timeScale domainFrom: aFromDate to: aToDate
]

{ #category : #'api - builder' }
GtPlotterTimeline >> timelineLabelFormat: aBlock [
	timelineLabelFormat := aBlock
]

{ #category : #'api - builder' }
GtPlotterTimeline >> timelineStencil: aStencil [
	"Set a stencil used to create a vertical timeline line on which we display data points"

	timelineStencil := aStencil asStencil
]

{ #category : #'api - instance creation' }
GtPlotterTimeline >> with: aCollectionOfDomainObjects [
	data := aCollectionOfDomainObjects
]

{ #category : #'api - builder' }
GtPlotterTimeline >> withProjectionAxis [
	axisType := AxisProjection
]

{ #category : #'api - builder' }
GtPlotterTimeline >> withTickAxis: anAmountOfTicks [
	axisType := AxisTicks.
	amountOfTicks := anAmountOfTicks
]
