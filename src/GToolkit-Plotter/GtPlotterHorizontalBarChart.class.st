"
I draw a horizontal bar chart. You can create instances directly and by using {{gtMethod:GtPlotter>>#horizontalBarChart}}.
#Examples
###Brick Dependencies
The following chart displays lines of code for individual {{gtClass:BaselineOfBrick}} dependencies: {{gtExample:GtPlotterHorizontalBarChartExamples>>#brickDependenciesSizesBarChart|codeExpanded=false|previewExpanded=true|previewHeight=500}}
##Browser data
The following example shows web browser usage, displaying utilization duration (x axis) and danger (color): {{gtExample:GtPlotterHorizontalBarChartExamples>>#browserDataChart|codeExpanded=false|previewExpanded=true|previewHeight=500}}
##Other examples
See {{gtClass:GtPlotterHorizontalBarChartExamples}}. 

"
Class {
	#name : #GtPlotterHorizontalBarChart,
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
		'barElementStencil',
		'barGroupStencil',
		'groupSpacing'
	],
	#category : #'GToolkit-Plotter-Builder - Bar Chart'
}

{ #category : #'api - ticks' }
GtPlotterHorizontalBarChart >> amountOfTicks [
	<return: #Number>

	^ amountOfTicks
]

{ #category : #'api - ticks' }
GtPlotterHorizontalBarChart >> amountOfTicks: aNumber [
	amountOfTicks := aNumber
]

{ #category : #'api - bars' }
GtPlotterHorizontalBarChart >> barElement: aStencil [
	"[ :aGtPlotterSingleScaleContext | BlElement new ]"
	barElementStencil := aStencil asStencilBuilder: GtPlotterScaleBasedStencilBuilder
]

{ #category : #'api - layout' }
GtPlotterHorizontalBarChart >> barGap [
	<return: #Number>

	^ barGap
]

{ #category : #'api - layout' }
GtPlotterHorizontalBarChart >> barGap: aNumber [
	barGap := aNumber
]

{ #category : #'api - bars' }
GtPlotterHorizontalBarChart >> barGroupStencil: aGtPlotterHorizontalBarGroupStencilBuilder [
	"[ :aGtPlotterBar :aGtPlotterDataEntity | ]"
	barGroupStencil := aGtPlotterHorizontalBarGroupStencilBuilder asStencilBuilder: GtPlotterHorizontalBarGroupStencilBuilder
]

{ #category : #'api - bars' }
GtPlotterHorizontalBarChart >> barHeightData: aBlock [
	barHeightDataBlock := aBlock
]

{ #category : #'api - scale' }
GtPlotterHorizontalBarChart >> barHeightScale [
	<return: #GtPlotterScale>

	^ barHeightScale
]

{ #category : #'api - scale' }
GtPlotterHorizontalBarChart >> barHeightScale: aGtPlotterScale [
	barHeightScale := aGtPlotterScale
]

{ #category : #'api - bars' }
GtPlotterHorizontalBarChart >> barLabelAptitudeStencil: aStencil [
	barLabelLookStencil := aStencil asStencil
]

{ #category : #'api - bars' }
GtPlotterHorizontalBarChart >> barLabelColor [
	<return: #Color>
	
	^ barLabelColor
]

{ #category : #'api - bars' }
GtPlotterHorizontalBarChart >> barLabelColor: aColor [
	barLabelColor := aColor
]

{ #category : #accessing }
GtPlotterHorizontalBarChart >> barLabelFormat: aBlock [
	barLabelFormat := aBlock
]

{ #category : #'api - bars' }
GtPlotterHorizontalBarChart >> barLabelLookStencil [
	^ barLabelLookStencil
]

{ #category : #accessing }
GtPlotterHorizontalBarChart >> barLabelStencil: aBrColumnCellStencilBuilder [
	barLabelStencil := aBrColumnCellStencilBuilder asStencilBuilder: BrColumnCellStencilBuilder
]

{ #category : #'api - layout' }
GtPlotterHorizontalBarChart >> barLabelWidth [
	<return: #Number>

	^ barLabelWidth
]

{ #category : #'api - layout' }
GtPlotterHorizontalBarChart >> barLabelWidth: aNumber [
	barLabelWidth := aNumber
]

{ #category : #'api - bars' }
GtPlotterHorizontalBarChart >> barStencil: aGtPlotterHorizontalBarStencilBuilder [
	"[ :aGtPlotterBar :anObject :aGtPlotterDataEntity | ]"
	barStencil := aGtPlotterHorizontalBarStencilBuilder asStencilBuilder: GtPlotterHorizontalBarStencilBuilder
]

{ #category : #'api - bars' }
GtPlotterHorizontalBarChart >> barWidthData: aBlock [
	barWidthDataBlock := aBlock
]

{ #category : #'api - scale' }
GtPlotterHorizontalBarChart >> barWidthScale [
	<return: #GtPlotterScale>

	^ barWidthScale
]

{ #category : #'api - scale' }
GtPlotterHorizontalBarChart >> barWidthScale: aGtPlotterScale [
	barWidthScale := aGtPlotterScale
]

{ #category : #'api - instantiation' }
GtPlotterHorizontalBarChart >> create [
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
				aptitude: (self tickLabelLook create foreground: self tickLabelColor);
				text: (aGtPlotterScaleContext scale formattedTick: aGtPlotterScaleContext originalValue) ];
		labels: self amountOfTicks).

	theBars := GtPlotterSingleScaleScrollElement new.
	theBars stencil: [ :eachGroup | self createBarRowFor: eachGroup grouping: data isLogicalGroup ].
	theBars values: data.
	
	aContainer addChild: theBars.

	^ aContainer
]

{ #category : #'private - instance creation' }
GtPlotterHorizontalBarChart >> createBarRowFor: aGtPlotterDataEntity grouping: shouldGroup [
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
		aptitude: (self barLabelLookStencil create).
	
	aContainer addChild: aRowLabelElement.
	
	shouldGroup ifTrue: [
		aContainer
			margin: (BlInsets top: self groupSpacing / 2.0 bottom: self groupSpacing / 2.0);
			addChild: (self createVerticalSeparator margin: (BlInsets left: self gridlineOffset / 2.0 right: self gridlineOffset / 2.0)) ].
	
	aContainer addChild: (self createGroupBarsFor: aGtPlotterDataEntity).

	^ aContainer
]

{ #category : #'private - instance creation' }
GtPlotterHorizontalBarChart >> createGroupBarsFor: aGtPlotterDataEntity [
	|  isStacking theBars aContainer |
	
	aGtPlotterDataEntity isLogicalGroup
		ifFalse: [ ^ self createLeafBarsFor: aGtPlotterDataEntity ].
	
	isStacking := aGtPlotterDataEntity stacking.
	
	theBars := Array streamContents: [ :aStream | aGtPlotterDataEntity groups do: [ :eachEntity | aStream nextPut: (self createGroupBarsFor: eachEntity) ] ].
	
	aContainer := BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent ].

	isStacking
		ifTrue: [ aContainer layout: BlFrameLayout new ]
		ifFalse: [ aContainer layout: (BlLinearLayout vertical cellSpacing: aGtPlotterDataEntity isLogicalGroup asBit * self groupSpacing) ].

	aContainer addChildren: theBars.

	^ aContainer
]

{ #category : #'private - instance creation' }
GtPlotterHorizontalBarChart >> createLeafBarsFor: aGtPlotterDataEntity [
	"Create non composite bars"
	|  isStacking aContainer |

	isStacking := aGtPlotterDataEntity stacking.

	aContainer := BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ].

	isStacking
		ifTrue: [ aContainer layout: BlFrameLayout new ]
		ifFalse: [ aContainer layout: BlLinearLayout vertical alignCenterLeft ].

	aContainer addChildren: (aGtPlotterDataEntity groupsCollect: [ :eachGroup |
		(barGroupStencil
			group: eachGroup;
			barStencil: barStencil;
			bar: (GtPlotterBar new
				stencil: barElementStencil;
				widthScale: barWidthScale;
				widthData: barWidthDataBlock;
				heightScale: barHeightScale;
				heightData: barHeightDataBlock;
				gap: self barGap)) asElement ]).

	^ aContainer
]

{ #category : #'private - instance creation' }
GtPlotterHorizontalBarChart >> createVerticalSeparator [
	^ BlElement new
		constraintsDo: [ :c |
			c vertical matchParent.
			c horizontal exact: 2 ];
		background: Color gray
]

{ #category : #'api - layout' }
GtPlotterHorizontalBarChart >> gridlineOffset [
	^ 0
]

{ #category : #'api - layout' }
GtPlotterHorizontalBarChart >> groupSpacing [
	^ groupSpacing
]

{ #category : #'api - layout' }
GtPlotterHorizontalBarChart >> groupSpacing: aNumber [
	groupSpacing := aNumber
]

{ #category : #initialization }
GtPlotterHorizontalBarChart >> initialize [
	super initialize.
	
	axisWidth := 120.

	tickLabelFormat := [ :aTickObject | aTickObject printString ].
	tickLabelColor := Color gray.
	tickLabelLookStencil := [ BrGlamorousLabelAptitude new glamorousRegularFontAndSize ] asStencil.

	amountOfTicks := 10.
	groupSpacing := 20.
	
	barGap := 6.
	barLabelWidth := 120.
	barLabelColor := Color gray.

	barHeightScale := GtPlotterConstantScale new constant: 30.
	barHeightDataBlock := [ :eachDataItem | eachDataItem ].
	barWidthScale := GtPlotterLinearScale new.
	barWidthDataBlock := [ :eachDataItem | eachDataItem ].
	barLabelLookStencil := [ BrGlamorousLabelAptitude new glamorousRegularFontAndSize ] asStencil.

	barGroupStencil := GtPlotterHorizontalSeparateBarGroupStencilBuilder new.
	barStencil := GtPlotterHorizontalBarStencilBuilder new.
	barElementStencil := [ :aGtPlotterSingleScaleContext | BlElement new ] asStencilBuilder: GtPlotterScaleBasedStencilBuilder.

	data := GtPlotterDataGroup new.

	barLabelFormat := [ :eachDataItem :eachDataItemIndex | eachDataItem asString ].
	barLabelStencil := [ :eachBarLabel | BrColumnCellLabelStencil new text: eachBarLabel ] asStencilBuilder: BrColumnCellStencilBuilder.

	
]

{ #category : #'api - ticks' }
GtPlotterHorizontalBarChart >> tickLabelColor [
	<return: #Color>
	
	^ tickLabelColor
]

{ #category : #'api - ticks' }
GtPlotterHorizontalBarChart >> tickLabelColor: aColor [
	tickLabelColor := aColor
]

{ #category : #'api - ticks' }
GtPlotterHorizontalBarChart >> tickLabelFormat [
	<return: #BlockClosure>

	^ tickLabelFormat
]

{ #category : #'api - ticks' }
GtPlotterHorizontalBarChart >> tickLabelFormat: aBlock [
	tickLabelFormat := aBlock
]

{ #category : #'api - ticks' }
GtPlotterHorizontalBarChart >> tickLabelLook [
	<return: #BrStencil>

	^ tickLabelLookStencil
]

{ #category : #'api - ticks' }
GtPlotterHorizontalBarChart >> tickLabelLook: aStencil [
	tickLabelLookStencil := aStencil asStencil
]

{ #category : #accessing }
GtPlotterHorizontalBarChart >> ticks [
	<return: #Number>
	
	self
		deprecated: 'Please use amountOfTicks* methods instead.'
		transformWith: '`@receiver ticks' -> '`@receiver amountOfTicks'.
	
	^ self amountOfTicks
]

{ #category : #accessing }
GtPlotterHorizontalBarChart >> ticks: anAmountOfTicks [

	self
		deprecated: 'Please use amountOfTicks* methods instead.'
		transformWith:
			'`@receiver ticks: `@statements1'
				-> '`@receiver amountOfTicks: `@statements1'.

	self amountOfTicks: anAmountOfTicks
]

{ #category : #accessing }
GtPlotterHorizontalBarChart >> with: aGtPlotterDataGroup [
	data := aGtPlotterDataGroup
]

{ #category : #'api - bars' }
GtPlotterHorizontalBarChart >> withAdjacentBars [
	self barGroupStencil: GtPlotterHorizontalAdjacentBarGroupStencilBuilder new
]

{ #category : #'api - bars' }
GtPlotterHorizontalBarChart >> withSeparateBars [
	self barGroupStencil: GtPlotterHorizontalSeparateBarGroupStencilBuilder new
]
