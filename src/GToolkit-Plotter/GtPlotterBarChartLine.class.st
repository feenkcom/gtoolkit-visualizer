"
Chart decoration line for barcharts. It uses dataValue, min and max to compute the line size over the chart
"
Class {
	#name : #GtPlotterBarChartLine,
	#superclass : #BrStencil,
	#instVars : [
		'lineStencil',
		'parent',
		'dataValue',
		'min',
		'max',
		'barChart'
	],
	#category : #'GToolkit-Plotter-Builder - Bar lines'
}

{ #category : #accessing }
GtPlotterBarChartLine >> barChart [
	^ barChart
]

{ #category : #accessing }
GtPlotterBarChartLine >> barChart: anObject [
	barChart := anObject
]

{ #category : #'api - instantiation' }
GtPlotterBarChartLine >> create [
	<return: #BlLineElement>
	| line element |
	line := self lineStencil create.
	element := self parent.
	line when: BlClickEvent do: [ :anEvent |
		anEvent consumed: true.
		anEvent currentTarget phlow spawnObject: dataValue ].
	line 
		fromAnchor: self fromAnchor;
		toAnchor: self toAnchor.
	^ line
]

{ #category : #accessing }
GtPlotterBarChartLine >> dataValue [
	<return: #Number>
	^ dataValue
]

{ #category : #accessing }
GtPlotterBarChartLine >> dataValue: aNumber [
	dataValue := aNumber
]

{ #category : #defaults }
GtPlotterBarChartLine >> defaultLineStencil [
	^ [ BlLineElement new border: (BlBorder paint: Color black) ] asStencil
]

{ #category : #accessing }
GtPlotterBarChartLine >> fromAnchor [
	<return: #BlPercentSideAnchor>
	| anchor |
	anchor := self newAnchor.
	self setAxisPercent: self min in: anchor.
	^ anchor
		
]

{ #category : #initalization }
GtPlotterBarChartLine >> initialize [
	super initialize.
	self 
		lineStencil: self defaultLineStencil;
		dataValue: 0;
		min: 0;
		max: 1.
]

{ #category : #accessing }
GtPlotterBarChartLine >> lineStencil [
	<return: #BrStencil>
	^ lineStencil
]

{ #category : #accessing }
GtPlotterBarChartLine >> lineStencil: aBrStencil [
	lineStencil := aBrStencil asStencil
]

{ #category : #accessing }
GtPlotterBarChartLine >> max [
	<return: #Float>
	^ max
]

{ #category : #accessing }
GtPlotterBarChartLine >> max: aNumber [
	max := aNumber
]

{ #category : #accessing }
GtPlotterBarChartLine >> min [
	<return: #Float>
	^ min
]

{ #category : #accessing }
GtPlotterBarChartLine >> min: aNumber [
	min := aNumber
]

{ #category : #accessing }
GtPlotterBarChartLine >> newAnchor [
	<return: #BlPercentSideAnchor>
	| anchor |
	anchor :=  (BlPercentSideAnchor element: self parent)
		chartPadding: barChart chartPadding;
		transformer: [:bounds | self transform: bounds ];
		yourself.
	self setPercent: self valuePercent in: anchor.
	^ anchor
]

{ #category : #accessing }
GtPlotterBarChartLine >> parent [
	<return: #BlElement>
	^ parent
]

{ #category : #accessing }
GtPlotterBarChartLine >> parent: aBlElement [
	parent := aBlElement
]

{ #category : #accessing }
GtPlotterBarChartLine >> setAxisPercent: aNumber in: aBlPercentSideAnchor [
	self subclassResponsibility 
]

{ #category : #accessing }
GtPlotterBarChartLine >> setPercent: aNumber in: aBlPercentSideAnchor [
	self subclassResponsibility
	
]

{ #category : #accessing }
GtPlotterBarChartLine >> toAnchor [
	<return: #BlPercentSideAnchor>
	| anchor |
	anchor := self newAnchor.
	self setAxisPercent: self max in: anchor.
	^ anchor
]

{ #category : #accessing }
GtPlotterBarChartLine >> transform: aRectangle [
	"used to compute the correct position for each line"
	^ barChart hasScalableContents
		ifTrue: [ aRectangle ]
		ifFalse: [ self transformRectangle: aRectangle ]
	
]

{ #category : #accessing }
GtPlotterBarChartLine >> transformRectangle: aRectangle [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtPlotterBarChartLine >> valuePercent [
	"return dataValue as percentage"
	<return: #Number>
	^ self subclassResponsibility
]
