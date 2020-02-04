Class {
	#name : #GtPlotterVerticalBarChartBuilder,
	#superclass : #GtPlotterBuilder,
	#instVars : [
		'ticks',
		'dataList',
		'axisWidth',
		'barHeightScale',
		'barWidthScale',
		'barLabelFormat',
		'barLabelStencil',
		'barWidthDataBlock',
		'barHeightDataBlock',
		'barStencil',
		'axisY'
	],
	#category : #'GToolkit-Plotter-Builder - Bar Chart'
}

{ #category : #accessing }
GtPlotterVerticalBarChartBuilder >> axisY [
	<return: #GtPlotterAxisElement>

	^ axisY
]

{ #category : #accessing }
GtPlotterVerticalBarChartBuilder >> axisY: aGtPlotterAxisElement [
	axisY := aGtPlotterAxisElement
]

{ #category : #accessing }
GtPlotterVerticalBarChartBuilder >> barHeightData: aBlock [
	barHeightDataBlock := aBlock
]

{ #category : #accessing }
GtPlotterVerticalBarChartBuilder >> barHeightScale [
	<return: #GtPlotterScale>

	^ barHeightScale
]

{ #category : #accessing }
GtPlotterVerticalBarChartBuilder >> barHeightScale: aGtPlotterScale [
	barHeightScale := aGtPlotterScale
]

{ #category : #accessing }
GtPlotterVerticalBarChartBuilder >> barLabelFormat: aBlock [
	barLabelFormat := aBlock
]

{ #category : #accessing }
GtPlotterVerticalBarChartBuilder >> barLabelStencil: aBrColumnCellStencilBuilder [
	barLabelStencil := aBrColumnCellStencilBuilder asStencilBuilder: BrColumnCellStencilBuilder
]

{ #category : #accessing }
GtPlotterVerticalBarChartBuilder >> barStencil: aBrColumnCellStencilBuilder [
	barStencil := aBrColumnCellStencilBuilder asStencilBuilder: BrColumnCellStencilBuilder
]

{ #category : #accessing }
GtPlotterVerticalBarChartBuilder >> barWidthData: aBlock [
	barWidthDataBlock := aBlock
]

{ #category : #accessing }
GtPlotterVerticalBarChartBuilder >> barWidthScale [
	<return: #GtPlotterScale>

	^ barWidthScale
]

{ #category : #accessing }
GtPlotterVerticalBarChartBuilder >> barWidthScale: aGtPlotterScale [
	barWidthScale := aGtPlotterScale
]

{ #category : #initialization }
GtPlotterVerticalBarChartBuilder >> initialize [
	super initialize.
	
	axisWidth := 120.

	barHeightScale := GtPlotterLinearScale new.
	barHeightDataBlock := [ :eachDataItem :eachDataItemIndex | eachDataItem ].
	barWidthScale := GtPlotterLinearScale new.
	barWidthDataBlock := [ :eachDataItem :eachDataItemIndex | eachDataItem ].

	axisY := GtPlotterVerticalAxisElement new
		padding: (BlInsets left: axisWidth + 20);
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
					c vertical matchParent.
					c horizontal fitContent ].
				
			aBarWidthValue := barWidthDataBlock cull: eachDataItem cull: eachDataItemIndex.
			aBarHeightValue := barHeightDataBlock cull: eachDataItem cull: eachDataItemIndex.
			
			aBarElement := ((barStencil
					rowValue: eachDataItem;
					rowIndex: eachDataItemIndex;
					columnIndex: eachColumnIndex) asElement)
				constraintsDo: [ :c |
					c frame vertical weight: (barWidthScale map: aBarWidthValue).
					c vertical matchParent.
					c horizontal exact: (barHeightScale map: aBarHeightValue)
				].
			
			aContainer addChild: aBarElement.
			aContainer
		].

	
]

{ #category : #accessing }
GtPlotterVerticalBarChartBuilder >> ticks [
	<return: #Number>
	
	^ ticks
]

{ #category : #accessing }
GtPlotterVerticalBarChartBuilder >> ticks: anAmountOfTicks [
	ticks := anAmountOfTicks
]

{ #category : #'instance creation' }
GtPlotterVerticalBarChartBuilder >> with: aCollectionOfAssociations [
	self topStep removeChildren.

	dataList display: aCollectionOfAssociations.
	axisY scale: barWidthScale ticks: ticks.

	self topStep root
		layout: BlLinearLayout vertical;
		addChildren: { axisY .
			BrFrame new
				matchParent;
				addChildren: {
					dataList.
					GtPlotterVerticalTicksElement new
						preventMeAndChildrenMouseEvents;
						padding: (BlInsets left: axisWidth + 20);
						scale: barWidthScale;
						tickStyle: [ :anElement | anElement background: (Color gray alpha: 0.5) ];
						ticks: ticks } }.
]
