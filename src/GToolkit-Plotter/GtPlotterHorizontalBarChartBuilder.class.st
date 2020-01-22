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
		'barLabelStencil',
		'barWidthDataBlock',
		'barHeightDataBlock',
		'barStencil'
	],
	#category : #'GToolkit-Plotter-Builder - Bar Chart'
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
GtPlotterHorizontalBarChartBuilder >> barHeightData: aBlock [
	barHeightDataBlock := aBlock
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
	barLabelStencil := aBrColumnCellStencilBuilder asStencilBuilder: BrColumnCellStencilBuilder
]

{ #category : #accessing }
GtPlotterHorizontalBarChartBuilder >> barStencil: aBrColumnCellStencilBuilder [
	barStencil := aBrColumnCellStencilBuilder asStencilBuilder: BrColumnCellStencilBuilder
]

{ #category : #accessing }
GtPlotterHorizontalBarChartBuilder >> barWidthData: aBlock [
	barWidthDataBlock := aBlock
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
	barHeightDataBlock := [ :eachDataItem :eachDataItemIndex | eachDataItem ].
	barWidthScale := GtPlotterLinearScale new.
	barWidthDataBlock := [ :eachDataItem :eachDataItemIndex | eachDataItem ].

	axisX := GtPlotterHorizontalAxisElement new
		padding: (BlInsets left: axisWidth);
		labelStencil: [ :aLabel | BrLabel new look: BrGlamorousLabelLook; text: aLabel ].

	ticks := 10.
	
	barStencil := [ :eachDataItem :eachDataItemIndex :eachColumnIndex | BlElement new background: Color gray ] asStencilBuilder: BrColumnCellStencilBuilder.
	barLabelFormat := [ :eachDataItem :eachDataItemIndex | eachDataItem asString ].
	barLabelStencil := [ :eachBarLabel | BrColumnCellLabelStencil new text: eachBarLabel ] asStencilBuilder: BrColumnCellStencilBuilder.
	
	dataList := BrColumnedList new.
	dataList matchParent.

	dataList column
		title: 'Axis';
		stencil: [ :eachDataItem :eachDataItemIndex :eachColumnIndex |
			(barLabelStencil
				rowValue: (barLabelFormat cull: eachDataItem cull: eachDataItemIndex);
				rowIndex: eachDataItemIndex;
				columnIndex: eachColumnIndex) build ];
		width: axisWidth.

	dataList column
		title: 'Bars';
		stencil: [ :eachDataItem :eachDataItemIndex :eachColumnIndex |
			| aContainer aBarWidthValue aBarHeightValue aBarElement |

			aContainer := BlElement new
				layout: BlFrameLayout new;
				constraintsDo: [ :c |
					c horizontal matchParent.
					c vertical fitContent ].
				
			aBarWidthValue := barWidthDataBlock cull: eachDataItem cull: eachDataItemIndex.
			aBarHeightValue := barHeightDataBlock cull: eachDataItem cull: eachDataItemIndex.
			
			aBarElement := ((barStencil
					rowValue: eachDataItem;
					rowIndex: eachDataItemIndex;
					columnIndex: eachColumnIndex) asElement)
				constraintsDo: [ :c |
					c frame horizontal weight: (barWidthScale map: aBarWidthValue).
					c horizontal matchParent.
					c vertical exact: (barHeightScale map: aBarHeightValue)
				].
			
			aContainer addChild: aBarElement.
			
			aContainer
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
