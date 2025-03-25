Class {
	#name : #GtPlotterScatterChartExamples,
	#superclass : #GtPlotterBuilderExamples,
	#category : #'GToolkit-Plotter-Example - Builders'
}

{ #category : #accessing }
GtPlotterScatterChartExamples >> boxPlotAxisDifferentGeometry [
	<gtExample>
	| aChart |
	aChart :=  self scatterDifferentGeometry.
	aChart labelFormatY: [:aValue | (aValue printShowingDecimalPlaces: 2) asRopedText foreground: Color darkGray ].
	aChart withBoxPlotAxis.
	 ^ aChart
]

{ #category : #accessing }
GtPlotterScatterChartExamples >> boxPlotAxisGradientBox [
	<gtExample>
	| aChart boxStencil |
	aChart :=  self scatterDifferentGeometry.
	aChart labelFormatY: [:aValue | (aValue printShowingDecimalPlaces: 2) asRopedText foreground: Color darkGray ].
	aChart withBoxPlotAxis.
	boxStencil := [
		BlElement new 
			background: (BlPaintBackground new
			paint: (BlLinearGradientPaint new
				stops: {
					0 -> Color red .
					0.5 -> Color yellow.
					1 -> Color blue};
				start: 0@0;
				end: 100@100))
	].
	aChart axisYStencil boxElementStencil: boxStencil.
	aChart axisXStencil boxElementStencil: boxStencil.
	 ^ aChart
]

{ #category : #accessing }
GtPlotterScatterChartExamples >> boxPlotAxisRedDotMedian [
	<gtExample>
	| aChart boxStencil medianStencil |
	aChart :=  self scatterDifferentGeometry.
	aChart labelFormatY: [:aValue | (aValue printShowingDecimalPlaces: 2) asRopedText foreground: Color darkGray ].
	aChart withBoxPlotAxis.
	boxStencil := [ BlElement new].
	medianStencil :=  [
		BrFrame new
			clipChildren: false;
			size: 1 asPoint;
			addChild: (BlElement new
				size: 10 asPoint;
				background: Color red;
				geometry: BlEllipseGeometry new;
				constraintsDo: [:c |
					c frame horizontal alignCenterAt: 0.5.
					c frame vertical alignCenterAt: 0.5.
				])
	].
	aChart axisXStencil boxElementStencil: boxStencil.
	aChart axisXStencil medianElementStencil: medianStencil.
	aChart axisYStencil boxElementStencil: boxStencil.
	aChart axisYStencil medianElementStencil: medianStencil.
	 ^ aChart
]

{ #category : #accessing }
GtPlotterScatterChartExamples >> boxPlotAxisTWhiskers [
	<gtExample>
	| aChart |
	aChart :=  self scatterDifferentGeometry.
	aChart labelFormatY: [:aValue | (aValue printShowingDecimalPlaces: 2) asRopedText foreground: Color darkGray ].
	aChart withBoxPlotAxisTWhiskers.
	aChart axisXStencil color: Color blue.
	aChart axisYStencil color: Color red.
	 ^ aChart
]

{ #category : #accessing }
GtPlotterScatterChartExamples >> emptyPlot [
	<gtExample>
	| chart |
	chart := GtPlotterScatterChart new.
	chart with: GtPlotterDataGroup new.
	^ chart
]

{ #category : #accessing }
GtPlotterScatterChartExamples >> examplePackage [
	<gtExample>
	^ BlElement package definedClasses
]

{ #category : #accessing }
GtPlotterScatterChartExamples >> focusEventHandlersInScatterProjection [
	<gtExample>
	| aChart |
	aChart := self projectionAxis.
	aChart yEventHandler lineStencil: [ BlLineElement new
		toHead: (BlArrowheadTriangle new 
			scale: 4; 
			background: Color blue);
		border: (BlBorder builder 
			dashed;
			width: 2;
			paint: (Color blue);
			build);
		yourself ].
	aChart xEventHandler lineStencil: [ BlLineElement new
		toHead: (BlArrowheadTriangle new 
			scale: 4; 
			background: Color red);
		border: (BlBorder builder 
			dashed;
			width: 2;
			paint: (Color red);
			build);
		yourself ];
		highlightBlock: [:e |
			e class = BlTextElement ifTrue: [
				e textDo: [ :t | t foreground: Color red ]
			] ];
		unhighlightBlock: [:e | 
			e class = BlTextElement ifTrue: [
				e textDo: [ :t | t foreground: Color gray ]
			] ].
	aChart pointEventHandler lineStencil: [ BlLineElement new
		toHead: (BlArrowheadTriangle new 
			scale: 4; 
			background: Color green);
		border: (BlBorder builder
			dashed;
			width: 2;
			paint: (Color green);
			build);
		yourself ];
		highlightBlock: [:e | e background: Color green ].
	^ aChart
]

{ #category : #accessing }
GtPlotterScatterChartExamples >> focusEventHandlersInScatterProjectionWithAnimation [
	<gtExample>
	| aChart |
	aChart := self focusEventHandlersInScatterProjection.
	
	aChart pointEventHandler lineStencil: [ BlLineElement new
		visibility: BlVisibility hidden;
		toHead: (BlArrowheadTriangle new 
			scale: 4; 
			background: Color green);
		border: (BlBorder builder
			width: 1;
			paint: (Color green);
			build);
		yourself ];
		highlightBlock: [:e :lines |
			lines do:[:line |
				| animation from to |
				from := line fromPosition.
				to := line toPosition.
				animation := BlNumberTransition new
					easing: BlEasing bounceOut;
					onStepDo: [ :t | | p newAnchor |
						line visibility: BlVisibility visible.
						p := from interpolateTo: to at: t.
						newAnchor := BlAbsolutePositionAnchor position: p.
						line toAnchor: newAnchor
					];
					from: 0;
					to: 1;
					duration: 1 second.
				e addAnimation: animation
			].
			
		 ].
	^ aChart
]

{ #category : #accessing }
GtPlotterScatterChartExamples >> horizontalProjectionAxis [
	<gtExample>
	| aChart |
	aChart := self projectionAxis.
	aChart axisXStencil: GtPlotterHorizontalProjectionTicksAndLabelsAxisStencil new.
	^ aChart
]

{ #category : #accessing }
GtPlotterScatterChartExamples >> projectionAxis [
	<gtExample>
	| aChart |
	aChart := self scatterChart.
	aChart labelFormatY: [:aValue | (aValue printShowingDecimalPlaces: 2) asRopedText foreground: Color darkGray ].
	aChart withProjectionAxis.
	^ aChart
]

{ #category : #accessing }
GtPlotterScatterChartExamples >> scatterChart [
	<gtExample>
	| dataGroup aChart theData aMaxDuration aBarWidthScale |
	theData := self websiteVisits.
	
	dataGroup := GtPlotterDataGroup new values: theData.
	aMaxDuration := dataGroup 
		inject: 0 days 
		intoValues: [ :aDuration :eachValue | 
			aDuration max: (eachValue at: #duration) ].

	aBarWidthScale := GtPlotterDurationScale new
		domainFrom: 0 minutes to: aMaxDuration.
	aChart := GtPlotterScatterChart new
		with: dataGroup;
		valueX: [ :e | e at: #duration ];
		scaleX: aBarWidthScale;
		titleX: 'Duration';
		ticksX: 10;
		valueY: [ :e | e at: #frequency ];
		scaleY: GtPlotterLinearScale new;
		titleY: 'Frequency';
		ticksY: 10.

	^ aChart	 
]

{ #category : #accessing }
GtPlotterScatterChartExamples >> scatterChart4Package [
	<gtExample>
	| dataGroup aChart theData |
	theData := self examplePackage.

	dataGroup := GtPlotterDataGroup new values: theData asOrderedCollection.

	aChart := GtPlotterScatterChart new
			with: dataGroup;
			valueX: [ :e | e methods size + e class methods size ];
			scaleX: GtPlotterLinearScale new;
			titleX: 'Number of methods';
			ticksX: 10;
			valueY: [ :e | e linesOfCode ];
			scaleY: GtPlotterLinearScale new;
			titleY: 'Lines of Code';
			ticksY: 10;
			withProjectionAxis;
			dotElement: [ :aGtPlotterContext | 
				BlElement new
					geometry: BlEllipseGeometry new;
					size: 5 asPoint;
					aptitude: (BrGlamorousWithExplicitTooltipAptitude
							text: aGtPlotterContext originalValue name) ].

	^ aChart
]

{ #category : #accessing }
GtPlotterScatterChartExamples >> scatterChartWithPopup [
	<gtExample>
	| aChart |
	aChart := self scatterChart
			dotElement: [ :aGtPlotterContext | 
				BlElement new
					geometry: BlSquareGeometry new;
					size: 20 asPoint;
					aptitude: (BrGlamorousWithExplicitTooltipAptitude
							text: (aGtPlotterContext originalValue at: #domain)) ];
			yourself.
	aChart with: (aChart data background: [ :each | Color blue alpha: 0.5 ]).
	^ aChart
]

{ #category : #accessing }
GtPlotterScatterChartExamples >> scatterDifferentGeometry [
	<gtExample>
	| aChart |
	aChart :=  self scatterChart
		dotElement: [ :aGtPlotterContext |
			| geometry domain |
			geometry := BlTriangleGeometry new.
			domain := aGtPlotterContext originalValue at: #domain.
			(domain endsWith: 'com')
				ifTrue: [ geometry := BlEllipseGeometry new ].
			(domain endsWith: 'cn')
				ifTrue: [ geometry := BlSquareGeometry new ].
			(domain endsWith: 'tv')
				ifTrue: [ geometry := BlPolygonGeometry vertices: RSShapeFactory star points * 10 + 10
					 ].
			BlElement new
				geometry: geometry;
				border: (BlBorder paint: Color black);
				size: 20 asPoint ];
		
	 	yourself.
	 aChart contentPadding: (BlInsets all: 20).
	 aChart with: (aChart data background: [ :each |
	 	| domain color |
	 	domain := each at: #domain.
	 	color := Color blue alpha: 0.4.
	 	(domain endsWith: 'com')
			ifTrue: [ color := Color red alpha: 0.4. ].
		(domain endsWith: 'cn')
			ifTrue: [ color := Color yellow alpha: 0.8. ].
		(domain endsWith: 'tv')
			ifTrue: [ color := Color green alpha: 0.4. ].
		color ]).
	 ^ aChart
]

{ #category : #accessing }
GtPlotterScatterChartExamples >> verticalProjectionAxis [
	<gtExample>
	| aChart |
	aChart := self projectionAxis.
	aChart axisXStencil: GtPlotterHorizontalProjectionTicksAndVerticalLabelsAxisStencil new.
	^ aChart
]
