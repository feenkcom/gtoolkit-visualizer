Class {
	#name : #GtPlotterHorizontalBarChartBuilder,
	#superclass : #GtPlotterBuilder,
	#instVars : [
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
		'data',
		'barGap',
		'barElementStencil'
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

{ #category : #'api - bars' }
GtPlotterHorizontalBarChartBuilder >> barElement: aStencil [
	"[ :aGtPlotterSingleScaleContext | BlElement new ]"
	barElementStencil := aStencil
]

{ #category : #'api - layout' }
GtPlotterHorizontalBarChartBuilder >> barGap [
	<return: #Number>

	^ barGap
]

{ #category : #'api - layout' }
GtPlotterHorizontalBarChartBuilder >> barGap: aNumber [
	barGap := aNumber
]

{ #category : #'api - bars' }
GtPlotterHorizontalBarChartBuilder >> barHeightData: aBlock [
	barHeightDataBlock := aBlock
]

{ #category : #'api - scale' }
GtPlotterHorizontalBarChartBuilder >> barHeightScale [
	<return: #GtPlotterScale>

	^ barHeightScale
]

{ #category : #'api - scale' }
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

{ #category : #'api - bars' }
GtPlotterHorizontalBarChartBuilder >> barStencil: aGtPlotterHorizontalBarStencilBuilder [
	"[ :aGtPlotterBar :anObject :aGtPlotterDataEntity | ]"
	barStencil := aGtPlotterHorizontalBarStencilBuilder asStencilBuilder: GtPlotterHorizontalBarStencilBuilder
]

{ #category : #'api - bars' }
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
	theBars stencil: [ :eachGroup | self createBarRowFor: eachGroup grouping: data isLogicalGroup ].
	theBars values: data.
	
	aContainer addChild: theBars.

	^ aContainer
]

{ #category : #'private - instance creation' }
GtPlotterHorizontalBarChartBuilder >> createBarRowFor: aGtPlotterDataEntity grouping: shouldGroup [
	| aRowLabel aContainer aRowLabelElement |

	aRowLabel := aGtPlotterDataEntity label.

	aContainer := BrHorizontalPane new
		hMatchParent;
		vFitContent.

	aRowLabelElement := BrLabel new
		padding: (BlInsets right: 5);
		hExact: self barLabelWidth - (shouldGroup asBit * self gridlineOffset);
		vMatchParent;
		text: aRowLabel;
		alignCenterRight;
		look: (self barLabelLookStencil create).
	
	aContainer addChild: aRowLabelElement.
	
	shouldGroup ifTrue: [
		aContainer
			margin: (BlInsets top: self groupMargin / 2.0 bottom: self groupMargin / 2.0);
			addChild: (self createVerticalSeparator margin: (BlInsets left: self gridlineOffset / 2.0 right: self gridlineOffset / 2.0)) ].
	
	aContainer addChild: (self createGroupBarsFor: aGtPlotterDataEntity).

	^ aContainer
]

{ #category : #'private - instance creation' }
GtPlotterHorizontalBarChartBuilder >> createGroupBarsFor: aGtPlotterDataEntity [
	|  isStacking theBars aContainer |
	
	aGtPlotterDataEntity isLogicalGroup
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
		ifFalse: [ aContainer layout: (BlLinearLayout vertical cellSpacing: aGtPlotterDataEntity isLogicalGroup asBit * self groupMargin) ].

	aContainer addChildren: theBars.

	^ aContainer
]

{ #category : #'private - instance creation' }
GtPlotterHorizontalBarChartBuilder >> createLeafBarsFor: aGtPlotterDataEntity [
	"Create non composite bars"
	|  isStacking aContainer |

	isStacking := aGtPlotterDataEntity stacking.

	aContainer := BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent ].

	isStacking
		ifTrue: [ aContainer layout: BlFrameLayout new ]
		ifFalse: [ aContainer layout: BlLinearLayout vertical ].

	aContainer addChildren: (aGtPlotterDataEntity groupsCollect: [ :eachGroup |
		eachGroup values collect: [ :eachValue |
			(barStencil
				group: eachGroup;
				value: eachValue;
				bar: (GtPlotterBar new
					stencil: barElementStencil;
					widthScale: barWidthScale;
					widthData: barWidthDataBlock;
					heightScale: barHeightScale;
					heightData: barHeightDataBlock;
					paint: eachGroup color;
					gap: self barGap)) asElement ] ]) flattened.
			
	^ aContainer
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
	
	barGap := 6.
	barLabelWidth := 120.
	barLabelColor := Color gray.

	barHeightScale := GtPlotterConstantScale new constant: 30.
	barHeightDataBlock := [ :eachDataItem :eachDataItemIndex | eachDataItem ].
	barWidthScale := GtPlotterLinearScale new.
	barWidthDataBlock := [ :eachDataItem :eachDataItemIndex | eachDataItem ].
	barLabelLookStencil := [ BrGlamorousLabelLook new glamorousRegularFontAndSize ] asStencil.

	barStencil := GtPlotterHorizontalBarStencilBuilder new.
	barElementStencil := [ :aGtPlotterSingleScaleContext | BlElement new ].

	data := GtPlotterDataGroup new.

	barLabelFormat := [ :eachDataItem :eachDataItemIndex | eachDataItem asString ].
	barLabelStencil := [ :eachBarLabel | BrColumnCellLabelStencil new text: eachBarLabel ] asStencilBuilder: BrColumnCellStencilBuilder.

	
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
	
	self
		deprecated: 'Please use amountOfTicks* methods instead.'
		transformWith: '`@receiver ticks' -> '`@receiver amountOfTicks'.
	
	^ self amountOfTicks
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
]
