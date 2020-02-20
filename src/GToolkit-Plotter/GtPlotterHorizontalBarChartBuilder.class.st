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
		'barStencil',
		'tickLabelFormat',
		'tickLabelColor',
		'barLabelWidth',
		'amountOfTicks',
		'tickLabelLookStencil',
		'barLabelColor'
	],
	#category : #'GToolkit-Plotter-Builder - Bar Chart'
}

{ #category : #'api - ticks' }
GtPlotterHorizontalBarChartBuilder >> amountOfTicks [
	<return: #Number>

	^ amountOfTicks
]

{ #category : #'api - ticks' }
GtPlotterHorizontalBarChartBuilder >> amountOfTicks: aNumber [
	amountOfTicks := aNumber
]

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

{ #category : #'api - bars' }
GtPlotterHorizontalBarChartBuilder >> barLabelColor [
	<return: #Color>
	
	^ barLabelColor
]

{ #category : #'api - bars' }
GtPlotterHorizontalBarChartBuilder >> barLabelColor: aColor [	
	barLabelColor := aColor
]

{ #category : #accessing }
GtPlotterHorizontalBarChartBuilder >> barLabelFormat: aBlock [
	barLabelFormat := aBlock
]

{ #category : #accessing }
GtPlotterHorizontalBarChartBuilder >> barLabelStencil: aBrColumnCellStencilBuilder [
	barLabelStencil := aBrColumnCellStencilBuilder asStencilBuilder: BrColumnCellStencilBuilder
]

{ #category : #'api - layout' }
GtPlotterHorizontalBarChartBuilder >> barLabelWidth [
	<return: #Number>

	^ barLabelWidth
]

{ #category : #'api - layout' }
GtPlotterHorizontalBarChartBuilder >> barLabelWidth: aNumber [
	barLabelWidth := aNumber
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

{ #category : #'api - instantiation' }
GtPlotterHorizontalBarChartBuilder >> create [
	<return: #Object>
	| aContainer theBars |

	aContainer := BlElement new
		layout: BlLinearLayout new;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ].

	aContainer addChild: (GtPlotterHorizontalTickLabelsElement new
		clipChildren: false;
		scale: barWidthScale;
		padding: (BlInsets left: self barLabelWidth + self gridlineOffset);
		constraintsDo: [ :c | c vertical fitContent ];
		labelFormat: self tickLabelFormat;
		labelElement: [ :aGtPlotterScaleContext |
			BrLabel new
				look: (self tickLabelLook create foreground: self tickLabelColor);
				text: (aGtPlotterScaleContext scale formattedTick: aGtPlotterScaleContext originalValue) ];
		labels: self amountOfTicks).
		
	
	theBars := GtPlotterSingleScaleScrollElement new.
	theBars stencil: [ :eachDurationGroup |
		| aGroupLabel |
						
		aGroupLabel := ''.
		eachDurationGroup labelDo: [ :aLabel | aGroupLabel := aLabel ].
		
		BrHorizontalPane new
			hMatchParent;
			vFitContent;
			margin: (BlInsets top: self gridlineOffset / 2.0 bottom: self gridlineOffset / 2.0);
			addChildren: {
				BrVerticalPane new
					vMatchParent;
					hExact: self tickLabelFormat;
					alignCenterRight;
					addChild: (BrLabel new
						look: (SoPolypolyLabelLook new foreground: self labelColor; sociatorRegularFont);
						padding: (BlInsets right: 5);
						text: aGroupLabel).

				BlElement new
					constraintsDo: [ :c |
						c vertical matchParent.
						c horizontal exact: 2 ];
					margin: (BlInsets left: self gridlineOffset right: self gridlineOffset);
					background: SoPolypolyColors mediumGray.
			
				BrVerticalPane new
					hMatchParent;
					vMatchParent;
					addChildren: (eachDurationGroup collect: [ :eachVisitedGroup |
						| aBarColor |
						
						aBarColor := Color gray.
						eachVisitedGroup colorDo: [ :aColor | aBarColor := aColor ].
						
						BlElement new
							"constraintsDo: [ :c |
								c horizontal matchParent.
								c vertical exact: (aGroupHeightScale map: eachVisitedGroup size) ];
							geometry: (BlHistogram new
								beLeftToRight;
								values: ((eachVisitedGroup
									sorted: [ :a :b | a validityDuration > b validityDuration ])
									collect: [ :eachCookie | (aBarWidthScale map: eachCookie validityDuration) min: 1 ]));
							background: (BlLinearGradientPaint horizontal stops: {
								0.6 -> aBarColor.
								1 -> (aBarColor alpha: 0.0) })" ])
			} ].
	"theBars values: cookieGroups."
]

{ #category : #initialization }
GtPlotterHorizontalBarChartBuilder >> initialize [
	super initialize.
	
	axisWidth := 120.

	tickLabelFormat := [ :aTickObject | aTickObject printString ].
	tickLabelColor := Color gray.
	tickLabelLookStencil := [ BrGlamorousLabelLook new glamorousRegularFontAndSize ] asStencil.

	amountOfTicks := 10.
	
	barLabelWidth := 120.
	barLabelColor := Color gray.

	barHeightScale := GtPlotterLinearScale new.
	barHeightDataBlock := [ :eachDataItem :eachDataItemIndex | eachDataItem ].
	barWidthScale := GtPlotterLinearScale new.
	barWidthDataBlock := [ :eachDataItem :eachDataItemIndex | eachDataItem ].

	axisX := GtPlotterHorizontalAxisElement new
		padding: (BlInsets left: axisWidth + 20);
		labelStencil: [ :aLabel | BrLabel new look: BrGlamorousLabelLook; text: aLabel ].

	ticks := 10.
	
	barStencil := [ :eachDataItem :eachDataItemIndex :eachColumnIndex | BlElement new background: Color gray ] asStencilBuilder: BrColumnCellStencilBuilder.
	barLabelFormat := [ :eachDataItem :eachDataItemIndex | eachDataItem asString ].
	barLabelStencil := [ :eachBarLabel | BrColumnCellLabelStencil new text: eachBarLabel ] asStencilBuilder: BrColumnCellStencilBuilder.
	
	"dataList := BrColumnedList new.
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
		]."

	
]

{ #category : #'api - ticks' }
GtPlotterHorizontalBarChartBuilder >> tickLabelColor [
	<return: #Color>
	
	^ tickLabelColor
]

{ #category : #'api - ticks' }
GtPlotterHorizontalBarChartBuilder >> tickLabelColor: aColor [
	tickLabelColor := aColor
]

{ #category : #'api - ticks' }
GtPlotterHorizontalBarChartBuilder >> tickLabelFormat [
	<return: #BlockClosure>

	^ tickLabelFormat
]

{ #category : #'api - ticks' }
GtPlotterHorizontalBarChartBuilder >> tickLabelFormat: aBlock [
	tickLabelFormat := aBlock
]

{ #category : #'api - ticks' }
GtPlotterHorizontalBarChartBuilder >> tickLabelLook [
	<return: #BrStencil>

	^ tickLabelLookStencil
]

{ #category : #'api - ticks' }
GtPlotterHorizontalBarChartBuilder >> tickLabelLook: aStencil [
	tickLabelLookStencil := aStencil asStencil
]

{ #category : #accessing }
GtPlotterHorizontalBarChartBuilder >> ticks [
	<return: #Number>
	
	^ ticks
]

{ #category : #accessing }
GtPlotterHorizontalBarChartBuilder >> ticks: anAmountOfTicks [

	self
		deprecated: 'Please use amountOfTicks* methods instead.'
		transformWith:
			'`@receiver ticks: `@statements1'
				-> '`@receiver amountOfTicks: `@statements1'.

	self amountOfTicks: anAmountOfTicks
]

{ #category : #'instance creation' }
GtPlotterHorizontalBarChartBuilder >> with: aCollectionOfAssociations [
	self topStep removeChildren.

	dataList display: aCollectionOfAssociations.
	axisX scale: barWidthScale ticks: ticks.

	self topStep root
		layout: BlLinearLayout vertical;
		addChildren: { axisX .
			BrFrame new
				matchParent;
				addChildren: {
					dataList.
					GtPlotterHorizontalTicksElement new
						preventMeAndChildrenMouseEvents;
						padding: (BlInsets left: axisWidth + 20);
						scale: barWidthScale;
						tickStyle: [ :anElement | anElement background: (Color gray alpha: 0.5) ];
						ticks: ticks } }.
]
