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
	#superclass : #GtPlotterBarChart,
	#instVars : [
		'axisWidth',
		'barLabelFormat',
		'barLabelStencil',
		'barStencil',
		'barLabelColor',
		'barGroupStencil',
		'groupSpacing'
	],
	#category : #'GToolkit-Plotter-Builder - Bar Chart'
}

{ #category : #'instance - creation' }
GtPlotterHorizontalBarChart class >> newFromValues: aCollectionOfObjects [
	^ self new
		with: (GtPlotterDataGroup new values: aCollectionOfObjects);
		barWidthScale: (GtPlotterLinearScale new 
			domainFrom: 0 to: aCollectionOfObjects max;
			yourself);
		yourself
]

{ #category : #'api - bars' }
GtPlotterHorizontalBarChart >> barGroupStencil: aGtPlotterHorizontalBarGroupStencilBuilder [
	"[ :aGtPlotterBar :aGtPlotterDataEntity | ]"
	barGroupStencil := aGtPlotterHorizontalBarGroupStencilBuilder asStencilBuilder: GtPlotterHorizontalBarGroupStencilBuilder
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

{ #category : #accessing }
GtPlotterHorizontalBarChart >> barLabelStencil: aBrColumnCellStencilBuilder [
	barLabelStencil := aBrColumnCellStencilBuilder asStencilBuilder: BrColumnCellStencilBuilder
]

{ #category : #'api - layout' }
GtPlotterHorizontalBarChart >> barLabelWidth [
	<return: #Number>
	self
		deprecated: 'Please use barLabelSpacing* methods instead.'
		transformWith: '`@receiver barLabelWidth' -> '`@receiver barLabelSpacing'.
	^ self barLabelSpacing
]

{ #category : #'api - layout' }
GtPlotterHorizontalBarChart >> barLabelWidth: aNumber [
	self
		deprecated: 'Please use barLabelSpacing:* methods instead.'
		transformWith: '`@receiver barLabelWidth:  `@statements1'
			-> '`@receiver barLabelSpacing: `@statements1'.
	self barLabelSpacing: aNumber
]

{ #category : #'api - bars' }
GtPlotterHorizontalBarChart >> barStencil: aGtPlotterHorizontalBarStencilBuilder [
	"[ :aGtPlotterBar :anObject :aGtPlotterDataEntity | ]"
	barStencil := aGtPlotterHorizontalBarStencilBuilder asStencilBuilder: GtPlotterHorizontalBarStencilBuilder
]

{ #category : #accessing }
GtPlotterHorizontalBarChart >> chartPadding [
	^ BlInsets left: self barLabelSpacing + self gridlineOffset
]

{ #category : #'api - instantiation' }
GtPlotterHorizontalBarChart >> create [
	<return: #Object>
	| aContainer theBars |

	aContainer := GtPlotterBarChartElement new
		layout: BlLinearLayout vertical;
		yourself.

	aContainer tickLabelsElement: (GtPlotterHorizontalTickLabelsElement new
		clipChildren: false;
		scale: barWidthScale;
		padding: self chartPadding;
		constraintsDo: [ :c | c vertical fitContent ];
		labelFormat: self tickLabelFormat;
		labelElement: [ :aGtPlotterScaleContext |
			BrLabel new
				aptitude: (self tickLabelLook create foreground: self tickLabelColor);
				text: (aGtPlotterScaleContext scale formattedTick: aGtPlotterScaleContext originalValue) ];
		labels: self amountOfTicks).
	
	theBars := self createBars.
	
	aContainer barsElement: theBars.
	aContainer lines: (lines collect: [ :line | 
		line
			barChart: self;
			parent: theBars.
		line create ]).
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
		hExact: self barLabelSpacing - (shouldGroup asBit * self gridlineOffset);
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

{ #category : #'api - instantiation' }
GtPlotterHorizontalBarChart >> createBars [
	| theBars |
	self hasScalableContents ifTrue: [
		| totalSize |
		theBars := BrVerticalPane new.
		theBars matchParent.
		totalSize := 0.
		data do: [:eachGroup | totalSize := eachGroup size ].
		theBars cellSpacing: (totalSize = data size 
			ifTrue: [ self barGap]
			ifFalse: [ 0 ]).
		
		data do: [:eachGroup |
			| barElement |
			barElement := self 
				createBarRowFor: eachGroup 
				grouping: data isLogicalGroup.
			barElement constraintsDo: [:c |
				c horizontal matchParent.
				c linear weight: eachGroup size / totalSize.
			].
			theBars addChild: barElement
		].
		^ theBars.
	].
	theBars := GtPlotterSingleScaleScrollElement new.
	theBars stencil: [ :eachGroup |
		self createBarRowFor: eachGroup grouping: data isLogicalGroup ].
	theBars values: data.
	^ theBars
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

{ #category : #default }
GtPlotterHorizontalBarChart >> defaultBarHeightScale [
	^ GtPlotterConstantScale new constant: 30
]

{ #category : #default }
GtPlotterHorizontalBarChart >> defaultBarLabelSpacing [
	^ 120
]

{ #category : #default }
GtPlotterHorizontalBarChart >> defaultBarWidthScale [
	^  GtPlotterLinearScale new
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
	groupSpacing := 20.
	barGroupStencil := GtPlotterHorizontalSeparateBarGroupStencilBuilder new.
	barStencil := GtPlotterHorizontalBarStencilBuilder new.
	barLabelFormat := [ :eachDataItem :eachDataItemIndex | eachDataItem asString ].
	barLabelStencil := [ :eachBarLabel | BrColumnCellLabelStencil new text: eachBarLabel ] asStencilBuilder: BrColumnCellStencilBuilder.

	
]

{ #category : #accessing }
GtPlotterHorizontalBarChart >> newVerticalLine [
	| verticalLine |
	verticalLine := GtPlotterVerticalLine new.
	lines add: verticalLine.
	^ verticalLine
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

{ #category : #'api - bars' }
GtPlotterHorizontalBarChart >> withAdjacentBars [
	self barGroupStencil: GtPlotterHorizontalAdjacentBarGroupStencilBuilder new
]

{ #category : #'api - bars' }
GtPlotterHorizontalBarChart >> withSeparateBars [
	self barGroupStencil: GtPlotterHorizontalSeparateBarGroupStencilBuilder new
]
