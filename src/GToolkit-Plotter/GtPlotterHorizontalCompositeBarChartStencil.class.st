Class {
	#name : #GtPlotterHorizontalCompositeBarChartStencil,
	#superclass : #BrStencil,
	#instVars : [
		'executions',
		'startTimeComputation',
		'endTimeComputation',
		'rowLabelComputation',
		'colorComputation',
		'rowValuesComputation',
		'barHeight',
		'rowHeight',
		'hideRowLabels',
		'hideAxisLabels',
		'labelWidth',
		'leftPadding',
		'selectionTransformation',
		'shouldShowGridlines',
		'executionGeometryComputation',
		'barStyleComputation',
		'labelFontSize'
	],
	#category : #'GToolkit-Plotter-Builder - Bar lines'
}

{ #category : #accessing }
GtPlotterHorizontalCompositeBarChartStencil >> amountOfTicks [
	^ 6
]

{ #category : #accessing }
GtPlotterHorizontalCompositeBarChartStencil >> barHeight [
	^ barHeight
]

{ #category : #accessing }
GtPlotterHorizontalCompositeBarChartStencil >> barHeight: aNumber [
	barHeight := aNumber
]

{ #category : #accessing }
GtPlotterHorizontalCompositeBarChartStencil >> barStyleComputation [
	^ barStyleComputation
]

{ #category : #accessing }
GtPlotterHorizontalCompositeBarChartStencil >> barStyleComputation: anObject [
	barStyleComputation := anObject
]

{ #category : #'api - configuration' }
GtPlotterHorizontalCompositeBarChartStencil >> colorComputation: anObject [

	colorComputation := anObject
]

{ #category : #'api - configuration' }
GtPlotterHorizontalCompositeBarChartStencil >> configureWithMinimalDetails [
	barHeight := 1.
	rowHeight := 1.
	leftPadding := 20.
	
	hideRowLabels := true.
	hideAxisLabels := false.
]

{ #category : #accessing }
GtPlotterHorizontalCompositeBarChartStencil >> create [
	<return: #Object>
	| minCreationDate maxExpireDate plot timeScale barWidthScale |
	
	minCreationDate := self firstStartDate.	
	maxExpireDate := self lastEndDate.
	
	timeScale := GtPlotterTimeScale new 
		domainFrom: minCreationDate to: maxExpireDate.
	timeScale tickFormat: [ :eachDateAndTime | 
		(eachDateAndTime - minCreationDate) gtShortPrintString ].
	
	barWidthScale := GtPlotterDurationScale new 
		domainFrom: 0 seconds 
		to: maxExpireDate - minCreationDate.
	
	plot := BrVerticalPane new 
		matchParent.
	
	hideAxisLabels ifFalse: [
		plot addChild: (self 
			createHorizontalThicksLabelsElementForTimeScale: timeScale) ].
	plot addChild: (self
		createPlotterScrollableElementForTimeScale: timeScale 
		andWidthScale: barWidthScale).

	^ plot
]

{ #category : #'private - instance creation' }
GtPlotterHorizontalCompositeBarChartStencil >> createGridlines: aGtPlotterScale [
	^ GtPlotterHorizontalTicksElement new
		padding: self gridlinePadding;
		preventMeAndChildrenMouseEvents;
		scale: aGtPlotterScale;
		tickStyle: [ :anElement | anElement
			width: self gridlineWidth;
			background: self gridlineColor ];
		ticks: self amountOfTicks
]

{ #category : #'private - instance creation' }
GtPlotterHorizontalCompositeBarChartStencil >> createHorizontalThicksLabelsElementForTimeScale: aTimeScale [
	^ (GtPlotterHorizontalTickLabelsElement new
		padding: (BlInsets 
			left: self labelWidth + self gridlineOffset + self leftPadding);
		scale: aTimeScale;
		height: 30;
		labels: self amountOfTicks)
]

{ #category : #'private - instance creation' }
GtPlotterHorizontalCompositeBarChartStencil >> createLabel: aString [
	| anAptitude |
	
	anAptitude := BrGlamorousLabelAptitude new.
	anAptitude foreground: self labelColor.
	labelFontSize
		ifNotNil: [ :aFontSize | anAptitude fontSize: aFontSize ].

	^ BrLabel new
		aptitude: anAptitude;
		padding: (BlInsets right: 5);
		text: aString
]

{ #category : #'private - instance creation' }
GtPlotterHorizontalCompositeBarChartStencil >> createLabelCell: aString [
	^ BrVerticalPane new
		matchParent;
		alignCenterRight;
		addChild: (self createLabel: aString);
		hExact: self labelWidth
]

{ #category : #'private - instance creation' }
GtPlotterHorizontalCompositeBarChartStencil >> createPlotterScrollableElementForTimeScale: timeScale andWidthScale: barWidthScale [
	| scrollableContainer scrollableContent |
	scrollableContainer := BrFrame new 
		matchParent.
	scrollableContent := BrSimpleList new.
	scrollableContent matchParent.
	scrollableContent addEventHandler: (GtPhlowListToSelectHandler new
		transformation: selectionTransformation).
	
	scrollableContent 
		itemStencil: [
			| rowElement |
			rowElement := self createRow.
			hideRowLabels ifFalse: [
				rowElement
					addAptitude: BrGlamorousListItemAptitude new  ].
			rowElement ];
		itemDataBinder: [ :rowContainer  :anExecutionDetails |
			| rowLabel horizontalBars |
			rowContainer removeChildren.
			
			hideRowLabels ifFalse: [
				rowLabel := self createLabelCell: (rowLabelComputation 
					value: anExecutionDetails).
				rowContainer addChild: rowLabel ].
	
			horizontalBars := GtPlotterHorizontalValueBarsElement new
				height: self barHeight;
				valueStyle: [ :anElement :aGtScaleContext |
					self styleBar: anElement execution: aGtScaleContext originalValue.
					anElement constraintsDo: [ :c | 
						c frame horizontal 
							alignLeftAt: (timeScale 
								map: (startTimeComputation 
									value: aGtScaleContext originalValue)) ].
					barStyleComputation ifNotNil: [
						barStyleComputation value: anElement value: aGtScaleContext originalValue ].
					anElement ];
				scale: barWidthScale;
				scaleData: [ :each | each duration ];
				values: (rowValuesComputation cull: anExecutionDetails).
		
			rowContainer addChild: horizontalBars. ].
			
	scrollableContent items: self executions.
	
	scrollableContainer addChild: scrollableContent.
	
	shouldShowGridlines
		ifTrue: [ scrollableContainer addChild: (self createGridlines: timeScale) ].
	
	scrollableContainer padding: (BlInsets left: self leftPadding).
	
	^ scrollableContainer
]

{ #category : #'private - instance creation' }
GtPlotterHorizontalCompositeBarChartStencil >> createRow [
	^ BrHorizontalPane new
		vExact: self rowHeight;
		alignCenter;
		hMatchParent
]

{ #category : #initialization }
GtPlotterHorizontalCompositeBarChartStencil >> defaultBarColor [
	^ ((Color r: 92 g: 204 b: 231 range: 255) alpha: 0.2)
]

{ #category : #'api - configuration' }
GtPlotterHorizontalCompositeBarChartStencil >> enabledGroupsInRow [
	rowValuesComputation := [ :anExecution | anExecution items ].
]

{ #category : #'api - configuration' }
GtPlotterHorizontalCompositeBarChartStencil >> endTimeComputation: anObject [

	endTimeComputation := anObject
]

{ #category : #'api - configuration' }
GtPlotterHorizontalCompositeBarChartStencil >> executionGeometryComputation: anObject [

	executionGeometryComputation := anObject
]

{ #category : #accessing }
GtPlotterHorizontalCompositeBarChartStencil >> executions [

	^ executions
]

{ #category : #initialization }
GtPlotterHorizontalCompositeBarChartStencil >> executions: anObject [

	executions := anObject
]

{ #category : #'private - computation' }
GtPlotterHorizontalCompositeBarChartStencil >> firstStartDate [
	^ self executions
		inject: (startTimeComputation value: self executions first)
		into: [ :minDate :each | 
			minDate min: (startTimeComputation value: each) ]
]

{ #category : #accessing }
GtPlotterHorizontalCompositeBarChartStencil >> gridlineColor [
	^ Color gray alpha: 0.2
]

{ #category : #accessing }
GtPlotterHorizontalCompositeBarChartStencil >> gridlineOffset [
	^ 10
]

{ #category : #accessing }
GtPlotterHorizontalCompositeBarChartStencil >> gridlinePadding [
	^ BlInsets left: self labelWidth + self gridlineOffset
]

{ #category : #accessing }
GtPlotterHorizontalCompositeBarChartStencil >> gridlineWidth [
	^ 1
]

{ #category : #initialization }
GtPlotterHorizontalCompositeBarChartStencil >> initialize [
	super initialize.
	
	barHeight := 15.
	rowHeight := 20.
	labelWidth := 250.
	hideRowLabels := false.
	hideAxisLabels := false.
	leftPadding := 0.
	shouldShowGridlines := true.
	
	startTimeComputation := [ :anExecution | anExecution startTime ].
	endTimeComputation :=  [ :anExecution | anExecution endTime ].
	rowLabelComputation := [ :anExecution | anExecution label ].
	executionGeometryComputation := [ :anExecution | BlStadiumGeometry new ].
	colorComputation := [ self defaultBarColor ].
	rowValuesComputation := [ :anExecution | {anExecution} ].
	selectionTransformation := [ :each | each ]
]

{ #category : #accessing }
GtPlotterHorizontalCompositeBarChartStencil >> labelColor [
	^ Color gray
]

{ #category : #'private - instance creation' }
GtPlotterHorizontalCompositeBarChartStencil >> labelFontSize [
	^ labelFontSize
]

{ #category : #'as yet unclassified' }
GtPlotterHorizontalCompositeBarChartStencil >> labelFontSize: anInteger [ 
	labelFontSize := anInteger
]

{ #category : #accessing }
GtPlotterHorizontalCompositeBarChartStencil >> labelWidth [
	^ hideRowLabels 
		ifTrue: [ 0 ] 
		ifFalse: [ labelWidth ]
]

{ #category : #'api - configuration' }
GtPlotterHorizontalCompositeBarChartStencil >> labelWidth: aNumber [
	labelWidth := aNumber
]

{ #category : #'private - computation' }
GtPlotterHorizontalCompositeBarChartStencil >> lastEndDate [
	^ self executions 
		inject: (endTimeComputation value: self executions  first) 
		into: [ :maxDate :each | 
			maxDate max: (endTimeComputation value: each) ]
]

{ #category : #accessing }
GtPlotterHorizontalCompositeBarChartStencil >> leftPadding [

	^ leftPadding
]

{ #category : #accessing }
GtPlotterHorizontalCompositeBarChartStencil >> leftPadding: anObject [

	leftPadding := anObject
]

{ #category : #accessing }
GtPlotterHorizontalCompositeBarChartStencil >> rowHeight [
	^ rowHeight
]

{ #category : #'api - configuration' }
GtPlotterHorizontalCompositeBarChartStencil >> rowHeight: aNumber [
	rowHeight := aNumber
]

{ #category : #'api - configuration' }
GtPlotterHorizontalCompositeBarChartStencil >> rowLabelComputation: anObject [

	rowLabelComputation := anObject
]

{ #category : #'api - configuration' }
GtPlotterHorizontalCompositeBarChartStencil >> rowValuesComputation: anObject [

	rowValuesComputation := anObject
]

{ #category : #'api - configuration' }
GtPlotterHorizontalCompositeBarChartStencil >> selectionTransformation: anObject [

	selectionTransformation := anObject
]

{ #category : #'api - configuration' }
GtPlotterHorizontalCompositeBarChartStencil >> startTimeComputation: anObject [

	startTimeComputation := anObject
]

{ #category : #accessing }
GtPlotterHorizontalCompositeBarChartStencil >> styleBar: anElement execution: anObject [ 
	^ anElement
		geometry: (executionGeometryComputation cull: anObject);
		background: ((colorComputation cull: anObject) ifNil: [
			self defaultBarColor ])
]

{ #category : #'api - configuration' }
GtPlotterHorizontalCompositeBarChartStencil >> withColorBasedOnScheduling [
	self colorComputation: [ :anItem |
					(anItem propertyAt: #correctScheduling ifAbsent: [ false ])
						ifFalse: [ Color red ] 
						ifTrue: [ Color gray ] ]
]

{ #category : #'api - configuration' }
GtPlotterHorizontalCompositeBarChartStencil >> withDescriptionAsLabel [
	rowLabelComputation := [ :anExecution | anExecution description ]
]

{ #category : #'api - configuration' }
GtPlotterHorizontalCompositeBarChartStencil >> withDissplayStringAsLabel [
	rowLabelComputation := [ :anExecution | anExecution gtDisplayString ]
]

{ #category : #'as yet unclassified' }
GtPlotterHorizontalCompositeBarChartStencil >> withoutGridlines [
	shouldShowGridlines := false
]

{ #category : #'as yet unclassified' }
GtPlotterHorizontalCompositeBarChartStencil >> withoutRowLabels [
	hideRowLabels := true
]

{ #category : #'as yet unclassified' }
GtPlotterHorizontalCompositeBarChartStencil >> withoutTickLabels [
	hideAxisLabels := true
]
