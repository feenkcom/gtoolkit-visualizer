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
		'barLabelColor',
		'barLabelLookStencil',
		'data'
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

{ #category : #'api - bars' }
GtPlotterHorizontalBarChartBuilder >> barLabelLookStencil [
	^ barLabelLookStencil
]

{ #category : #'api - bars' }
GtPlotterHorizontalBarChartBuilder >> barLabelLookStencil: aStencil [
	barLabelLookStencil := aStencil asStencil
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

{ #category : #'api - layout' }
GtPlotterHorizontalBarChartBuilder >> barMargin [
	^ 5
]

{ #category : #accessing }
GtPlotterHorizontalBarChartBuilder >> barStencil: aBrColumnCellStencilBuilder [
	barStencil := aBrColumnCellStencilBuilder asStencilBuilder: BrColumnCellStencilBuilder
]

{ #category : #accessing }
GtPlotterHorizontalBarChartBuilder >> barWidthData: aBlock [
	barWidthDataBlock := aBlock
]

{ #category : #'api - scale' }
GtPlotterHorizontalBarChartBuilder >> barWidthScale [
	<return: #GtPlotterScale>

	^ barWidthScale
]

{ #category : #'api - scale' }
GtPlotterHorizontalBarChartBuilder >> barWidthScale: aGtPlotterScale [
	barWidthScale := aGtPlotterScale
]

{ #category : #'api - instantiation' }
GtPlotterHorizontalBarChartBuilder >> create [
	<return: #Object>
	| aContainer theBars |

	aContainer := BlElement new
		layout: BlLinearLayout vertical;
		clipChildren: false;
		padding: (BlInsets right: 20);
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
	theBars stencil: [ :eachGroup | self createBarRowFor: eachGroup ].
	theBars values: data.
	
	aContainer addChild: theBars.

	^ aContainer
]

{ #category : #'private - instance creation' }
GtPlotterHorizontalBarChartBuilder >> createBarRowFor: aGtPlotterDataEntity [
	| aRowLabel isGrouping aContainer aRowLabelElement |

	aRowLabel := aGtPlotterDataEntity label.
	isGrouping := aGtPlotterDataEntity grouping.

	aContainer := BrHorizontalPane new
		hMatchParent;
		vFitContent.

	aRowLabelElement := BrLabel new
		padding: (BlInsets right: 5);
		hExact: self barLabelWidth - (isGrouping asBit * self gridlineOffset);
		vMatchParent;
		text: aRowLabel;
		alignCenterRight;
		look: (self barLabelLookStencil create).
	
	aContainer addChild: aRowLabelElement.
	
	isGrouping ifTrue: [
		aContainer
			margin: (BlInsets top: self groupMargin / 2.0 bottom: self groupMargin / 2.0);
			addChild: (self createVerticalSeparator margin: (BlInsets left: self gridlineOffset / 2.0 right: self gridlineOffset / 2.0)) ].
	
	aContainer addChild: (self createGroupBarsFor: aGtPlotterDataEntity).

	^ aContainer
]

{ #category : #'private - instance creation' }
GtPlotterHorizontalBarChartBuilder >> createGroupBarsFor: aGtPlotterDataEntity [
	|  isStacking theBars aContainer |
	
	aGtPlotterDataEntity isComposite
		ifFalse: [ ^ self createLeafBarsFor: aGtPlotterDataEntity ].
	
	isStacking := aGtPlotterDataEntity stacking.
	
	theBars := Array streamContents: [ :aStream | aGtPlotterDataEntity groups do: [ :eachEntity | aStream nextPut: (self createGroupBarsFor: eachEntity) ] ].
	
	aContainer := BlElement new
		layout: BlFrameLayout new;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent ].

	isStacking
		ifTrue: [ aContainer layout: BlFrameLayout new ]
		ifFalse: [ aContainer layout: (BlLinearLayout vertical cellSpacing: aGtPlotterDataEntity grouping asBit * self groupMargin) ].

	aContainer addChildren: theBars.

	^ aContainer
]

{ #category : #'private - instance creation' }
GtPlotterHorizontalBarChartBuilder >> createLeafBarsFor: aGtPlotterDataEntity [
	"Create non composite bars"
	|  isStacking |
	
	isStacking := aGtPlotterDataEntity stacking.
	
	^ isStacking
		ifTrue: [
			GtPlotterHorizontalValueBarsElement new
				constraintsDo: [ :c | c vertical fitContent ];
				scale: barWidthScale;
				scaleData: barWidthDataBlock;
				margin: (BlInsets top: self barMargin / 2.0 bottom: self barMargin / 2.0);
				valueStyle: [ :anElement :aContext | anElement background: aGtPlotterDataEntity color ];
				valueLayout: [ :anElement :aGtPlotterScaleContext |
					anElement constraintsDo: [ :c |
						c horizontal matchParent.
						c vertical exact: (barHeightScale map: (barHeightDataBlock gtValue: aGtPlotterScaleContext originalValue)).
						c frame vertical alignCenter.
						c frame horizontal weight: aGtPlotterScaleContext mappedValue ];
						yourself ];
				values: aGtPlotterDataEntity values ]
			ifFalse: [
				| aContainer |

				aContainer := BlElement new
					layout: (BlLinearLayout vertical cellSpacing: self barMargin);
					constraintsDo: [ :c |
						c horizontal matchParent.
						c vertical fitContent ].
				
				aContainer addChildren: (aGtPlotterDataEntity values collect: [ :eachValue |
					GtPlotterHorizontalValueBarsElement new
						constraintsDo: [ :c | c vertical fitContent ];
						scale: barWidthScale;
						scaleData: barWidthDataBlock;
						valueLayout: [ :anElement :aGtPlotterScaleContext |
							anElement constraintsDo: [ :c |
								c horizontal matchParent.
								c vertical exact: (barHeightScale map: (barHeightDataBlock gtValue: aGtPlotterScaleContext originalValue)).
								c frame vertical alignCenter.
								c frame horizontal weight: aGtPlotterScaleContext mappedValue ];
								yourself ];
						valueStyle: [ :anElement | anElement background: aGtPlotterDataEntity color ];
						values: { eachValue }
				]) ]
]

{ #category : #'private - instance creation' }
GtPlotterHorizontalBarChartBuilder >> createVerticalSeparator [
	^ BlElement new
		constraintsDo: [ :c |
			c vertical matchParent.
			c horizontal exact: 2 ];
		background: Color gray
]

{ #category : #'api - layout' }
GtPlotterHorizontalBarChartBuilder >> gridlineOffset [
	^ 20
]

{ #category : #'api - layout' }
GtPlotterHorizontalBarChartBuilder >> groupMargin [
	^ 20
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

	barHeightScale := GtPlotterConstantScale new constant: 30.
	barHeightDataBlock := [ :eachDataItem :eachDataItemIndex | eachDataItem ].
	barWidthScale := GtPlotterLinearScale new.
	barWidthDataBlock := [ :eachDataItem :eachDataItemIndex | eachDataItem ].
	barLabelLookStencil := [ BrGlamorousLabelLook new glamorousRegularFontAndSize ] asStencil.

	data := GtPlotterDataGroup new.

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

{ #category : #accessing }
GtPlotterHorizontalBarChartBuilder >> with: aGtPlotterDataGroup [
	
	data := aGtPlotterDataGroup
	
	"self topStep removeChildren.

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
						ticks: ticks } }."
]
