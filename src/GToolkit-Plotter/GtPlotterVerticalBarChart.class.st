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
		'barGap'
	],
	#category : #'GToolkit-Plotter-Builder - Bar Chart'
}

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

	aContainer addChild: (GtPlotterVerticalTickLabelsElement new
		clipChildren: false;
		inverse;
		scale: barHeightScale;
		padding: (BlInsets bottom: self barLabelHeight + self gridlineOffset);
		constraintsDo: [ :c | c horizontal fitContent ];
		labelFormat: self tickLabelFormat;
		labelElement: [ :aGtPlotterScaleContext |
			BrLabel new
				aptitude: (self tickLabelLook create 
					foreground: self tickLabelColor);
				text: (aGtPlotterScaleContext scale 
					formattedTick: aGtPlotterScaleContext originalValue) ];
		labels: self amountOfTicks).

	theBars := GtPlotterSingleScaleScrollElement new.
	theBars stencil: [ :eachGroup | 
		self 
			createBarColumnFor: eachGroup
			grouping: data isLogicalGroup ].
	theBars values: data.
	theBars list beHorizontal.
	
	aContainer addChild: theBars.

	^ aContainer
]

{ #category : #accessing }
GtPlotterVerticalBarChart >> createBarColumnFor: aGtPlotterDataEntity grouping: shouldGroup [
	| aColumnLabel aContainer aColumnLabelElement |

	aColumnLabel := aGtPlotterDataEntity label.
	
	aContainer := BrVerticalPane new
		vMatchParent;
		hFitContent.
	
	aContainer addChild: (self createGroupBarsFor: aGtPlotterDataEntity).

	aColumnLabelElement := BrLabel new
		padding: (BlInsets top: 5);
		vExact: self barLabelHeight;
		hMatchParent;
		text: aColumnLabel;
		alignTopCenter;
		aptitude: (self barLabelLookStencil create).
	
	aContainer addChild: aColumnLabelElement.

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
GtPlotterVerticalBarChart >> createBottomBarsFor: aGtPlotterDataEntity [
	"Create non composite bars"
	|  isStacking aContainer |

	isStacking := aGtPlotterDataEntity stacking.

	aContainer := BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ].

	isStacking
		ifTrue: [ aContainer layout: BlFrameLayout new ]
		ifFalse: [ aContainer layout: BlLinearLayout horizontal alignBottomCenter ].

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
GtPlotterVerticalBarChart >> createGroupBarsFor: aGtPlotterDataEntity [
	|  isStacking theBars aContainer |
	
	aGtPlotterDataEntity isLogicalGroup
		ifFalse: [ ^ self createBottomBarsFor: aGtPlotterDataEntity ].
	
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

{ #category : #accessing }
GtPlotterVerticalBarChart >> gridlineOffset [
	^ 0
]

{ #category : #accessing }
GtPlotterVerticalBarChart >> initialize [
	super initialize.
	self 
		tickLabelFormat: [ :aTickObject | aTickObject printString ];
		tickLabelLook: [ 
			BrGlamorousLabelAptitude new glamorousRegularFontAndSize 
		] asStencil;
		tickLabelColor: Color gray;
		barLabelHeight: 100.
	barLabelLookStencil := [ BrGlamorousLabelAptitude new glamorousRegularFontAndSize ] asStencil.
	barGroupStencil := GtPlotterVerticalSeparateBarGroupStencilBuilder new.
	barStencil := GtPlotterVerticalBarStencilBuilder new.
	barWidthScale := GtPlotterConstantScale new constant: 30.
	barHeightScale := GtPlotterLinearScale new.
	barGap := 6.
	barWidthDataBlock := [ :eachDataItem | eachDataItem ].
	
	
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
GtPlotterVerticalBarChart >> tickLabelLook [
	<return: #BrStencil>

	^ tickLabelLookStencil
]

{ #category : #accessing }
GtPlotterVerticalBarChart >> tickLabelLook: aStencil [
	tickLabelLookStencil := aStencil asStencil
]

{ #category : #accessing }
GtPlotterVerticalBarChart >> with: aGtPlotterDataGroup [
	data := aGtPlotterDataGroup
]
