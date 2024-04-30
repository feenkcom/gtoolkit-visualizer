"
Based on `GtPlotterHorizontalBarChart`
"
Class {
	#name : #GtPlotterVerticalBarChart,
	#superclass : #GtPlotterBuilder,
	#instVars : [
		'barElementStencil',
		'barLabelHeight',
		'barHeightScale',
		'barHeightDataBlock',
		'amountOfTicks',
		'data',
		'tickLabelFormat',
		'tickLabelLookStencil',
		'tickLabelColor',
		'barLabelLookStencil',
		'barGroupStencil',
		'barStencil',
		'barWidthScale',
		'barWidthDataBlock',
		'barGap',
		'ticksAngle',
		'hasScalableContents',
		'lines'
	],
	#category : #'GToolkit-Plotter-Builder - Bar Chart'
}

{ #category : #'instance creation' }
GtPlotterVerticalBarChart class >> newFromValues: aCollectionOfObjects [
	^ self new
		with: (GtPlotterDataGroup new values: aCollectionOfObjects);
		barHeightScale: (GtPlotterLinearScale new 
			domainFrom: 0 to: aCollectionOfObjects max;
			yourself);
		yourself
]

{ #category : #accessing }
GtPlotterVerticalBarChart >> amountOfTicks [
	<return: #Number>
	^ amountOfTicks
]

{ #category : #accessing }
GtPlotterVerticalBarChart >> amountOfTicks: aNumber [
	amountOfTicks := aNumber
]

{ #category : #accessing }
GtPlotterVerticalBarChart >> barElement: aStencil [
	"[ :aGtPlotterSingleScaleContext | BlElement new ]"
	barElementStencil := aStencil asStencilBuilder: GtPlotterScaleBasedStencilBuilder
]

{ #category : #accessing }
GtPlotterVerticalBarChart >> barGap [
	<return: #Number>

	^ barGap
]

{ #category : #accessing }
GtPlotterVerticalBarChart >> barGap: aNumber [
	barGap := aNumber
]

{ #category : #accessing }
GtPlotterVerticalBarChart >> barGroupStencil: aGtPlotterVerticalBarGroupStencilBuilder [
	"[ :aGtPlotterBar :aGtPlotterDataEntity | ]"
	barGroupStencil := aGtPlotterVerticalBarGroupStencilBuilder asStencilBuilder: GtPlotterVerticalBarGroupStencilBuilder
]

{ #category : #accessing }
GtPlotterVerticalBarChart >> barHeightData [
	<return: #BlockClosure>
	^ barHeightDataBlock
]

{ #category : #accessing }
GtPlotterVerticalBarChart >> barHeightData: aBlockClosure [
	barHeightDataBlock := aBlockClosure
]

{ #category : #accessing }
GtPlotterVerticalBarChart >> barHeightDataBlock [
	<return: #BlockClosure>
	^ barHeightDataBlock
]

{ #category : #accessing }
GtPlotterVerticalBarChart >> barHeightScale [
	<return: #GtPlotterScale>
	^ barHeightScale
]

{ #category : #accessing }
GtPlotterVerticalBarChart >> barHeightScale: aGtPlotterScale [
	barHeightScale := aGtPlotterScale
]

{ #category : #accessing }
GtPlotterVerticalBarChart >> barLabelHeight [
	<return: #Number>
	^ barLabelHeight
]

{ #category : #accessing }
GtPlotterVerticalBarChart >> barLabelHeight: aNumber [
	barLabelHeight := aNumber
]

{ #category : #accessing }
GtPlotterVerticalBarChart >> barLabelLookStencil [
	^ barLabelLookStencil
]

{ #category : #accessing }
GtPlotterVerticalBarChart >> barStencil: aGtPlotterVerticalBarStencilBuilder [
	"[ :aGtPlotterBar :anObject :aGtPlotterDataEntity | ]"
	barStencil := aGtPlotterVerticalBarStencilBuilder asStencilBuilder: GtPlotterVerticalBarStencilBuilder
]

{ #category : #accessing }
GtPlotterVerticalBarChart >> barWidthScale [
	<return: #GtPlotterScale>

	^ barWidthScale
]

{ #category : #accessing }
GtPlotterVerticalBarChart >> barWidthScale: aGtPlotterScale [
	barWidthScale := aGtPlotterScale
]

{ #category : #accessing }
GtPlotterVerticalBarChart >> bottomGap [
	^ self barLabelHeight + self gridlineOffset
]

{ #category : #accessing }
GtPlotterVerticalBarChart >> chartPadding [
	^ BlInsets bottom: self bottomGap
]

{ #category : #accessing }
GtPlotterVerticalBarChart >> create [
	<return: #Object>
	| aContainer theBars |
	aContainer := BlElement new
			layout: BlLinearLayout horizontal;
			clipChildren: false;
			padding: (BlInsets right: 20);
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent ].

	aContainer
		addChild: (GtPlotterVerticalTickLabelsElement new
				clipChildren: false;
				inverse;
				scale: barHeightScale;
				padding: self chartPadding;
				constraintsDo: [ :c | c horizontal fitContent ];
				labelFormat: self tickLabelFormat;
				labelElement: [ :aGtPlotterScaleContext | 
					BrLabel new
						aptitude: (self tickLabelLook create foreground: self tickLabelColor);
						text: (aGtPlotterScaleContext scale
								formattedTick: aGtPlotterScaleContext originalValue) ];
				labels: self amountOfTicks).

	theBars := self createBars.
	aContainer addChild: theBars.

	aContainer addChildren: (lines collect: [ :line | 
		line
			barChart: self;
			parent: theBars.
		line create ]).
	^ aContainer
]

{ #category : #accessing }
GtPlotterVerticalBarChart >> createBarColumnFor: aGtPlotterDataEntity grouping: shouldGroup [
	|  aContainer tangle |
	aContainer := BrVerticalPane new vMatchParent.
		
	self hasScalableContents 
		ifTrue: [ aContainer hFitContent ]
		ifFalse: [ aContainer hExact: (self barWidthScale constant + self barGap)* aGtPlotterDataEntity size ].
	tangle := self ticksAngle.
	tangle isZero ifFalse: [
		aContainer 
			clipChildren: false;
			hExact: self barWidthScale constant.
		
		tangle = -90 
			ifTrue: [ aContainer alignBottomCenter ]
			ifFalse: [ aContainer alignBottomRight ]
	].
	aContainer 
		addChild: (self createGroupBarsFor: aGtPlotterDataEntity);
		addChild: (self createColumnLabelElement: aGtPlotterDataEntity label).
	
	shouldGroup ifTrue: [
		aContainer
			margin: (BlInsets 
				top: self groupSpacing / 2.0 
				bottom: self groupSpacing / 2.0);
			addChild: (self createVerticalSeparator 
				margin: (BlInsets 
					left: self gridlineOffset / 2.0 
					right: self gridlineOffset / 2.0)) ].
	
	^ aContainer
]

{ #category : #accessing }
GtPlotterVerticalBarChart >> createBars [
	| theBars |
	self hasScalableContents ifTrue: [
		| totalSize |
		theBars := BrHorizontalPane new.
		theBars matchParent.
		totalSize := 0.
		data do: [:eachGroup | totalSize := eachGroup size ].
		theBars cellSpacing: (totalSize = data size 
			ifTrue: [ self barGap]
			ifFalse: [ 0 ]).
		
		data do: [:eachGroup |
			| barElement |
			barElement := self 
				createBarColumnFor: eachGroup 
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
		self
			createBarColumnFor: eachGroup
			grouping: data isLogicalGroup ].
	theBars values: data.
	theBars list beHorizontal.
	^ theBars
]

{ #category : #accessing }
GtPlotterVerticalBarChart >> createBottomBarsFor: aGtPlotterDataEntity [
	"Create non composite bars"
	|  isStacking aContainer layout |
	isStacking := aGtPlotterDataEntity stacking.

	aContainer := BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ].
	layout := isStacking
		ifTrue: [ BlFrameLayout new ]
		ifFalse: [ BlLinearLayout horizontal alignBottomCenter ].
	aContainer layout: layout.

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

{ #category : #accessing }
GtPlotterVerticalBarChart >> createColumnLabelElement: aColumnLabel [
	| aColumnLabelElement label |
	
	aColumnLabelElement := BrFrame new
		padding: (BlInsets top: self tickLabelGap);
		hFitContent;
		vExact: self bottomGap.
	label := BrLabel new
		text: aColumnLabel;
		alignTopCenter;
		yourself.
	
	self ticksAngle isZero ifTrue: [
		aColumnLabelElement
			hMatchParent;
			layout: BlLinearLayout new alignTopCenter.
		self hasScalableContents
			ifFalse: [ aColumnLabelElement hExact: self barWidthScale constant + self barGap].
		label
			
			aptitude: BrGlamorousShrinkingLabelAptitude;
			constraintsDo: [:c | 
				c vertical fitContent.
				c horizontal fitContentLimited.
			].
	] ifFalse: [
		label
			aptitude: (self barLabelLookStencil create);
			transformDo: [:t | t rotateBy: self ticksAngle];
			constraintsDo:[:c | c accountTransformation ].
	].
	
	aColumnLabelElement addChild: label.
	^ aColumnLabelElement
]

{ #category : #accessing }
GtPlotterVerticalBarChart >> createGroupBarsFor: aGtPlotterDataEntity [
	| isStacking theBars aContainer |
	
	aGtPlotterDataEntity isLogicalGroup
		ifFalse: [ ^ self createBottomBarsFor: aGtPlotterDataEntity ].
	
	isStacking := aGtPlotterDataEntity stacking.

	theBars := Array streamContents: [ :aStream |
		aGtPlotterDataEntity groups
			do: [ :eachEntity | aStream nextPut: (self createGroupBarsFor: eachEntity) ] ].

	aContainer := BlElement new
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical fitContent ].

	isStacking
		ifTrue: [ aContainer layout: BlFrameLayout new ]
		ifFalse: [ aContainer
				layout: (BlLinearLayout vertical
						cellSpacing: aGtPlotterDataEntity isLogicalGroup asBit * self groupSpacing) ].

	aContainer addChildren: theBars.

	^ aContainer
]

{ #category : #accessing }
GtPlotterVerticalBarChart >> data [
	^ data
]

{ #category : #default }
GtPlotterVerticalBarChart >> defaultDiagonalNumber [
	^ -45
]

{ #category : #ticks }
GtPlotterVerticalBarChart >> diagonalTicks [
	self ticksAngle: self defaultDiagonalNumber.
]

{ #category : #accessing }
GtPlotterVerticalBarChart >> gridlineOffset [
	^ 0
]

{ #category : #accessing }
GtPlotterVerticalBarChart >> hasScalableContents [
	^ hasScalableContents
]

{ #category : #ticks }
GtPlotterVerticalBarChart >> horizontalTicks [
	self ticksAngle: 0
]

{ #category : #initalization }
GtPlotterVerticalBarChart >> initialize [
	super initialize.
	lines := OrderedCollection new.
	self
		horizontalTicks;
		scrollableContents;
		tickLabelFormat: [ :aTickObject | aTickObject printString ];
		tickLabelLook: [ 
			BrGlamorousLabelAptitude new glamorousRegularFontAndSize 
		] asStencil;
		tickLabelColor: Color gray;
		barLabelHeight: 100.
	barLabelLookStencil := [ BrGlamorousLabelAptitude new glamorousRegularFontAndSize ] asStencil.
	amountOfTicks := 10.
	
	barElementStencil := [ :aGtPlotterSingleScaleContext | BlElement new ] asStencilBuilder: GtPlotterScaleBasedStencilBuilder.
	barGroupStencil := GtPlotterVerticalSeparateBarGroupStencilBuilder new.
	barStencil := GtPlotterVerticalBarStencilBuilder new.
	barWidthScale := GtPlotterConstantScale new constant: 30.
	barWidthDataBlock := [ :eachDataItem | eachDataItem ].
	
	barHeightScale := GtPlotterLinearScale new.
	barHeightDataBlock := [ :eachDataItem | eachDataItem ].
	barGap := 6.
	data := GtPlotterDataGroup new.
	
]

{ #category : #accessing }
GtPlotterVerticalBarChart >> newHorizontalLine [
	| horizontalLine |
	horizontalLine := GtPlotterHorizontalLine new.
	GtPlotterBarChartLine.
	lines add: horizontalLine.
	^ horizontalLine
]

{ #category : #accessing }
GtPlotterVerticalBarChart >> scalableContents [
	hasScalableContents := true
]

{ #category : #accessing }
GtPlotterVerticalBarChart >> scrollableContents [
	hasScalableContents := false
]

{ #category : #accessing }
GtPlotterVerticalBarChart >> tickLabelColor [
	<return: #Color>
	^ tickLabelColor
]

{ #category : #accessing }
GtPlotterVerticalBarChart >> tickLabelColor: aColor [
	tickLabelColor := aColor
]

{ #category : #accessing }
GtPlotterVerticalBarChart >> tickLabelFormat [
	<return: #BlockClosure>

	^ tickLabelFormat
]

{ #category : #accessing }
GtPlotterVerticalBarChart >> tickLabelFormat: aBlock [
	tickLabelFormat := aBlock
]

{ #category : #accessing }
GtPlotterVerticalBarChart >> tickLabelGap [
	^ 5
]

{ #category : #accessing }
GtPlotterVerticalBarChart >> tickLabelLook [
	<return: #BrStencil>

	^ tickLabelLookStencil
]

{ #category : #accessing }
GtPlotterVerticalBarChart >> tickLabelLook: aStencil [
	tickLabelLookStencil := aStencil asStencil
]

{ #category : #accessing }
GtPlotterVerticalBarChart >> ticksAngle [
	<return: #Number>
	^ ticksAngle
]

{ #category : #accessing }
GtPlotterVerticalBarChart >> ticksAngle: aNumber [
	ticksAngle := aNumber
]

{ #category : #ticks }
GtPlotterVerticalBarChart >> verticalTicks [
	self ticksAngle: -90
]

{ #category : #accessing }
GtPlotterVerticalBarChart >> with: aGtPlotterDataGroup [
	data := aGtPlotterDataGroup
]
