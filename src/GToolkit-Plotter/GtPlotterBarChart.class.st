"
I have common methods for GtPlotterHorizontalBarChart and GtPlotterVerticalBarChart
"
Class {
	#name : #GtPlotterBarChart,
	#superclass : #GtPlotterBuilder,
	#instVars : [
		'amountOfTicks',
		'barElementStencil',
		'barGap',
		'barHeightDataBlock',
		'barHeightScale',
		'barLabelLookStencil',
		'barWidthScale',
		'data',
		'tickLabelColor',
		'tickLabelFormat',
		'tickLabelLookStencil',
		'barWidthDataBlock',
		'lines',
		'barLabelSpacing',
		'hasScalableContents'
	],
	#category : #'GToolkit-Plotter-Builder - Bar Chart'
}

{ #category : #accessing }
GtPlotterBarChart >> amountOfTicks [
	<return: #Number>

	^ amountOfTicks
]

{ #category : #accessing }
GtPlotterBarChart >> amountOfTicks: aNumber [
	amountOfTicks := aNumber
]

{ #category : #accessing }
GtPlotterBarChart >> barElement: aStencil [
	"[ :aGtPlotterSingleScaleContext | BlElement new ]"
	barElementStencil := aStencil asStencilBuilder: GtPlotterScaleBasedStencilBuilder
]

{ #category : #accessing }
GtPlotterBarChart >> barGap [
	<return: #Number>

	^ barGap
]

{ #category : #accessing }
GtPlotterBarChart >> barGap: aNumber [
	barGap := aNumber
]

{ #category : #accessing }
GtPlotterBarChart >> barHeightData [
	<return: #BlockClosure>
	^ barHeightDataBlock
]

{ #category : #accessing }
GtPlotterBarChart >> barHeightData: aBlockClosure [
	barHeightDataBlock := aBlockClosure
]

{ #category : #accessing }
GtPlotterBarChart >> barHeightScale [
	<return: #GtPlotterScale>
	^ barHeightScale
]

{ #category : #accessing }
GtPlotterBarChart >> barHeightScale: aGtPlotterScale [
	barHeightScale := aGtPlotterScale
]

{ #category : #accessing }
GtPlotterBarChart >> barLabelLookStencil [
	^ barLabelLookStencil
]

{ #category : #accessing }
GtPlotterBarChart >> barLabelLookStencil: aStencil [
	barLabelLookStencil := aStencil asStencil
]

{ #category : #accessing }
GtPlotterBarChart >> barLabelSpacing [
	<return: #Number>
	^ barLabelSpacing
]

{ #category : #accessing }
GtPlotterBarChart >> barLabelSpacing: aNumber [
	barLabelSpacing := aNumber
]

{ #category : #accessing }
GtPlotterBarChart >> barWidthData [
	<return: #BlockClosure>
	^ barWidthDataBlock
]

{ #category : #accessing }
GtPlotterBarChart >> barWidthData: aBlockClosure [
	barWidthDataBlock := aBlockClosure
]

{ #category : #accessing }
GtPlotterBarChart >> barWidthScale [
	<return: #GtPlotterScale>

	^ barWidthScale
]

{ #category : #accessing }
GtPlotterBarChart >> barWidthScale: aGtPlotterScale [
	barWidthScale := aGtPlotterScale
]

{ #category : #accessing }
GtPlotterBarChart >> data [
	<return: #GtPlotterDataGroup>
	^ data
]

{ #category : #default }
GtPlotterBarChart >> defaultBarHeightScale [
	^ self subclassResponsibility
]

{ #category : #default }
GtPlotterBarChart >> defaultBarLabelSpacing [
	^ self subclassResponsibility
]

{ #category : #default }
GtPlotterBarChart >> defaultBarWidthScale [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtPlotterBarChart >> hasScalableContents [
	^ hasScalableContents
]

{ #category : #initalization }
GtPlotterBarChart >> initialize [
	super initialize.
	lines := OrderedCollection new.
	self
		amountOfTicks: 10;
		barGap: 6;
		scrollableContents;
		with: GtPlotterDataGroup new;
		barHeightScale: self defaultBarHeightScale;
		barHeightData: [ :eachDataItem | eachDataItem ];
		barElement: ([ :aGtPlotterSingleScaleContext | BlElement new ] asStencilBuilder: GtPlotterScaleBasedStencilBuilder);
		barLabelLookStencil: [ BrGlamorousLabelAptitude new glamorousRegularFontAndSize ] asStencil;
		barLabelSpacing: self defaultBarLabelSpacing;
		barWidthData: [ :eachDataItem | eachDataItem ];
		barWidthScale: self defaultBarWidthScale;
		tickLabelColor: Color gray;
		tickLabelFormat: [ :aTickObject | aTickObject printString ];
		tickLabelLook: [ BrGlamorousLabelAptitude new glamorousRegularFontAndSize ] asStencil.
		
		
]

{ #category : #accessing }
GtPlotterBarChart >> scalableContents [
	hasScalableContents := true
]

{ #category : #accessing }
GtPlotterBarChart >> scrollableContents [
	hasScalableContents := false
]

{ #category : #accessing }
GtPlotterBarChart >> tickLabelColor [
	<return: #Color>
	^ tickLabelColor
]

{ #category : #accessing }
GtPlotterBarChart >> tickLabelColor: aColor [
	tickLabelColor := aColor
]

{ #category : #accessing }
GtPlotterBarChart >> tickLabelFormat [
	<return: #BlockClosure>

	^ tickLabelFormat
]

{ #category : #accessing }
GtPlotterBarChart >> tickLabelFormat: aBlock [
	tickLabelFormat := aBlock
]

{ #category : #accessing }
GtPlotterBarChart >> tickLabelLook [
	<return: #BrStencil>

	^ tickLabelLookStencil
]

{ #category : #accessing }
GtPlotterBarChart >> tickLabelLook: aBrStencil [
	tickLabelLookStencil := aBrStencil
]

{ #category : #accessing }
GtPlotterBarChart >> with: aGtPlotterDataGroup [
	data := aGtPlotterDataGroup
]
