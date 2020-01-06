Class {
	#name : #GtPlotterHorizontalBarChartBuilder,
	#superclass : #GtPlotterBuilder,
	#instVars : [
		'axisX',
		'ticks',
		'dataList',
		'axisWidth',
		'barHeightScale',
		'barWidthScale',
		'barLabelFormat',
		'barLabelStencil'
	],
	#category : #'GToolkit-Plotter'
}

{ #category : #accessing }
GtPlotterHorizontalBarChartBuilder >> axisX [
	<return: #GtPlotterAxisElement>

	^ axisX
]

{ #category : #accessing }
GtPlotterHorizontalBarChartBuilder >> axisX: aGtPlotterAxisElement [
	axisX := aGtPlotterAxisElement
]

{ #category : #accessing }
GtPlotterHorizontalBarChartBuilder >> barHeightScale [
	<return: #GtPlotterScale>

	^ barHeightScale
]

{ #category : #accessing }
GtPlotterHorizontalBarChartBuilder >> barHeightScale: aGtPlotterScale [
	barHeightScale := aGtPlotterScale
]

{ #category : #accessing }
GtPlotterHorizontalBarChartBuilder >> barLabelFormat: aBlock [
	barLabelFormat := aBlock
]

{ #category : #accessing }
GtPlotterHorizontalBarChartBuilder >> barLabelStencil: aBrColumnCellStencilBuilder [
	barLabelStencil := aBrColumnCellStencilBuilder
]

{ #category : #accessing }
GtPlotterHorizontalBarChartBuilder >> barWidthScale [
	<return: #GtPlotterScale>

	^ barWidthScale
]

{ #category : #accessing }
GtPlotterHorizontalBarChartBuilder >> barWidthScale: aGtPlotterScale [
	barWidthScale := aGtPlotterScale
]

{ #category : #initialization }
GtPlotterHorizontalBarChartBuilder >> initialize [
	super initialize.
	
	axisWidth := 150.

	barHeightScale := GtPlotterLinearScale new.
	barWidthScale := GtPlotterLinearScale new.

	axisX := GtPlotterHorizontalAxisElement new
		padding: (BlInsets left: axisWidth);
		labelStencil: [ :aLabel | BrLabel new look: BrGlamorousLabelLook; text: aLabel ].

	ticks := 10.
	barLabelFormat := [ :eachDataItem :eachDataItemIndex | eachDataItem asString ].
	barLabelStencil := [ :eachBarLabel | BrColumnCellLabelStencil new text: eachBarLabel ] asStencilBuilder: BrColumnCellStencilBuilder.
	
	dataList := BrColumnedList new.
	dataList matchParent.

	dataList column
		title: 'Axis';
		stencil: [ :eachDataItem :eachDataItemIndex |  ];
		width: axisWidth.

	dataList column
		title: 'Bars';
		stencil: [ :aCollectionOfDomainValues |
			BlElement new
		].

	
]

{ #category : #accessing }
GtPlotterHorizontalBarChartBuilder >> ticks [
	<return: #Number>
	
	^ ticks
]

{ #category : #accessing }
GtPlotterHorizontalBarChartBuilder >> ticks: anAmountOfTicks [
	ticks := anAmountOfTicks
]

{ #category : #'instance creation' }
GtPlotterHorizontalBarChartBuilder >> with: aCollectionOfAssociations [
	self topStep removeChildren.

	dataList display: aCollectionOfAssociations.
	axisX scale: barWidthScale ticks: ticks.

	self topStep root
		layout: BlLinearLayout vertical;
		addChildren: { axisX . dataList }.
]
