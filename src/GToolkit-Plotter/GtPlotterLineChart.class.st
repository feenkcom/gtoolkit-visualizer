"
I draw line charts.

Highlight observations with highlightPointsWhere: (a condition on each original observation), highlightPoints: (a collection matched by identity), or highlightAllPoints. Each replaces the previous selection and returns the chart. By default no markers are shown. highlightPoints: snapshots collection membership, highlights every occurrence of selected objects, and ignores unknown objects. Use highlightPoints: #() to clear selection.

pointStencil: accepts a block returning a fresh BlElement, optionally receiving a GtPlotterLineChartPointContext with originalValue, group, and one-based source index. Configure appearance, tooltips and interaction inside the stencil. The default stencil creates a circular marker in its group color and installs click-to-inspect. Custom stencils own their click behavior; no click handler is installed outside the stencil. To retain default interaction while customizing, capture chart pointStencil and decorate the element returned by that block. pointStencil: nil restores the default stencil.

The chart installs normalized positioning and retains context in marker userData at #plotterPointContext. Configuration affects newly built content. Normal content construction initializes scales. Markers share line scales and appear above lines and X projections. Existing clipping applies; overlapping markers may obscure one another. Selection does not change domains. Singleton/constant domains follow existing scale behavior; use explicit nondegenerate bounds if needed. X labels accept dates or printString; Y retains numeric integer formatting.

# Examples
{{gtExample:GtPlotterLineChartExamples>>#highlightedPoints|codeExpanded=true|previewExpanded=true}}
{{gtExample:GtPlotterLineChartExamples>>#highlightedPointsWithTooltips|codeExpanded=true|previewExpanded=true}}
{{gtExample:GtPlotterLineChartExamples>>#pointStencilPreservesInspection|codeExpanded=true|previewExpanded=true}}
{{gtExample:GtPlotterLineChartExamples>>#plotWithProjections|codeExpanded=false|previewExpanded=true}}
"
Class {
	#name : #GtPlotterLineChart,
	#superclass : #GtPlotterXYChart,
	#instVars : [
		'pointPredicate',
		'pointStencil'
	],
	#category : #'GToolkit-Plotter-Builder - Line Chart'
}

{ #category : #accessing }
GtPlotterLineChart >> autoscale: aBoolean [
	isAlreadyInitialized := aBoolean not
]

{ #category : #'api - instantiation' }
GtPlotterLineChart >> axisXStencil [
	self initializeScales.
	^ GtPlotterAxisStencil new
		valuable: [ 
			self newAxisXElement ];
		scale: self scaleX
]

{ #category : #'api - instantiation' }
GtPlotterLineChart >> axisYStencil [
	self initializeScales.
	^ GtPlotterAxisStencil new
		valuable: [ 
			self newAxisYElement ];
		scale: self scaleY
]

{ #category : #'api - instantiation' }
GtPlotterLineChart >> create [
	<return: #BlElement>
	| aContainer |

	self initializeScales.

	aContainer := BrHorizontalGrid new
		cellSpacing: 0;
		columnCount: 2;
		matchParent;
		padding: (BlInsets all: 20).	

	self data size isZero 
		ifTrue: [ 
			aContainer 
				columnCount: 1;
				addChild: self newNoDataElement ]
		ifFalse: [
			projectionXValues ifNotNil: [ 
				aContainer
					addChildren: { 
						self newCornerElement.
						self newProjectionXLabelsElement.
					 }	
			].
			
			aContainer 
				addChildren: { 
					self newAxisYElement.
					self newContentElement.
					self newCornerElement.
					self newAxisXElement.
				 } ].
	
	self styleChartElement: aContainer.
	
	^ aContainer
]

{ #category : #'private - axes' }
GtPlotterLineChart >> defaultAxisLabelFor: anObject [
	^ ((anObject isKindOf: Date)
		or: [ anObject isKindOf: DateAndTime ])
		ifTrue: [ (anObject monthAbbreviation, ' ', anObject year asString)
			asRopedText foreground: Color darkGray ]
		ifFalse: [ anObject printString asRopedText foreground: Color darkGray ]
]

{ #category : #'private - points' }
GtPlotterLineChart >> defaultPointStencil [
	^ [ :aContext |
		BlElement new
			geometry: BlCircleGeometry new;
			size: 8 @ 8;
			background: aContext group color;
			border: (BlBorder paint: Color white width: 1);
			when: BlClickEvent do: [ :anEvent |
				anEvent consumed: true.
				anEvent currentTarget phlow spawnObject: aContext originalValue ] ]
]

{ #category : #'accessing - points' }
GtPlotterLineChart >> highlightAllPoints [
	self highlightPointsWhere: [ :each | true ]
]

{ #category : #'accessing - points' }
GtPlotterLineChart >> highlightPoints: observations [
	| selected |
	selected := IdentitySet new.
	observations do: [ :each | selected add: each ].
	self highlightPointsWhere: [ :each | selected includes: each ]
]

{ #category : #'accessing - points' }
GtPlotterLineChart >> highlightPointsWhere: aBlock [
	pointPredicate := aBlock
]

{ #category : #initialization }
GtPlotterLineChart >> initialize [
	super initialize.
	isAlreadyInitialized := false.
	scaleX := GtPlotterLinearScale new.
	valueX := #key.
	ticksX := 10.
	labelFormatX := [ :aValue | self defaultAxisLabelFor: aValue ].
	projectionXLineStyle := [ :anElement :aContext | anElement background: Color veryLightGray ].
	scaleY := GtPlotterLinearScale new.
	valueY := #value.
	ticksY := 10.
	labelFormatY := [ :aValue |
		(aValue printShowingDecimalPlaces: 0) asRopedText foreground: Color darkGray ]
]

{ #category : #initialization }
GtPlotterLineChart >> initializeScales [

	| aMinX aMaxX aMinY aMaxY |
	
	isAlreadyInitialized ifTrue: [ ^ self ].
	
	aMinX := minX ifNil: [ 
		| aCurrentValue |
		data valuesDo: [ :eachValue | 
			aCurrentValue 
				ifNil: [ aCurrentValue := valueX value: eachValue ]
				ifNotNil: [ aCurrentValue := aCurrentValue min: (valueX value: eachValue) ] ].
		aCurrentValue ].

	aMaxX := maxX ifNil: [ 
		| aCurrentValue |
		data valuesDo: [ :eachValue | 
			aCurrentValue 
				ifNil: [ aCurrentValue := valueX value: eachValue ]
				ifNotNil: [ aCurrentValue := aCurrentValue max: (valueX value: eachValue) ] ].
		aCurrentValue ].

		
	aMinY := minY ifNil: [ 
		| aCurrentValue |
		data valuesDo: [ :eachValue | 
			aCurrentValue 
				ifNil: [ aCurrentValue := valueY value: eachValue ]
				ifNotNil: [ aCurrentValue := aCurrentValue min: (valueY value: eachValue) ] ].
		aCurrentValue ].

	aMaxY := maxY ifNil: [ 
		| aCurrentValue |
		data valuesDo: [ :eachValue | 
			aCurrentValue 
				ifNil: [ aCurrentValue := valueY value: eachValue ]
				ifNotNil: [ aCurrentValue := aCurrentValue max: (valueY value: eachValue) ] ].
		aCurrentValue ].

	scaleX domainFrom: aMinX to: aMaxX.
	scaleY domainFrom: aMinY to: aMaxY.
	
]

{ #category : #'instance creation' }
GtPlotterLineChart >> newAxisXElement [
	| aContainer |
	aContainer := BrVerticalPane new
		vFitContent;
		hMatchParent;
		clipChildren: false;
		addChildren: { 
			self newAxisXTicksElement height: 10.
			self newAxisXTickLabelsElement. }.
		
	titleX ifNotNil: [ 
		aContainer addChild: self newAxisXTitleElement ].
	
	^ aContainer
]

{ #category : #'instance creation' }
GtPlotterLineChart >> newAxisXLineElement [
	^ BlElement new
		height: 2;
		background: (Color veryVeryLightGray);
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c frame vertical alignBottom ]
]

{ #category : #'instance creation' }
GtPlotterLineChart >> newAxisXTickLabelsElement [
	^ GtPlotterHorizontalTickLabelsElement new
		scale: self scaleX;
		labelFormat: labelFormatX;
		constraintsDo: [ :c | c vertical fitContent ];
		clipChildren: false;
		labels: ticksX
]

{ #category : #'instance creation' }
GtPlotterLineChart >> newAxisXTicksElement [
	
	^ GtPlotterHorizontalTicksElement new
		scale: self scaleX;
		tickStyle: [ :anElement | anElement
			width: 2;
			background: (Color gray alpha: 0.8) ];
		ticks: ticksX
]

{ #category : #'instance creation' }
GtPlotterLineChart >> newAxisXTitleElement [

	^ BrLabel new
		aptitude: (BrGlamorousLabelAptitude new 
			glamorousRegularFont;
			foreground: Color darkGray;
			fontSize: 16);
		text: titleX asRopedText;
		constraintsDo: [ :c |
			c linear horizontal alignRight ]
]

{ #category : #'instance creation' }
GtPlotterLineChart >> newAxisYElement [
	| aContainer |
	aContainer := BrHorizontalPane new
		hFitContent;
		vMatchParent;
		clipChildren: false.
		
	titleY ifNotNil: [ 
		aContainer addChild: self newAxisYTitleElement ].
	
	aContainer
		addChildren: { 
			self newAxisYTickLabelsElement.
			self newAxisYTicksElement width: 10. }.
			
	^ aContainer
]

{ #category : #'instance creation' }
GtPlotterLineChart >> newAxisYLineElement [
	^ BlElement new
		width: 2;
		background: (Color veryVeryLightGray);
		constraintsDo: [ :c | 
			c vertical matchParent.
			c frame horizontal alignLeft ]
]

{ #category : #'instance creation' }
GtPlotterLineChart >> newAxisYTickLabelsElement [
	^ GtPlotterVerticalTickLabelsElement new
		scale: self scaleY;
		inverse;
		labelFormat: labelFormatY;
		labelStyle: [ :anElement |
			(anElement background: Color white)
				constraintsDo: [ :c |
					c frame horizontal alignRight.
					c horizontal fitContent.
					c vertical fitContent ] ];
		constraintsDo: [ :c | 
			c horizontal fitContent.
			c padding: (BlInsets left: 10 right: 10) ];
		clipChildren: false;
		labels: ticksY
]

{ #category : #'instance creation' }
GtPlotterLineChart >> newAxisYTicksElement [
	^ GtPlotterVerticalTicksElement new
		scale: self scaleY;
		tickStyle: [ :anElement | anElement
			height: 2;
			background: (Color gray alpha: 0.8) ];
		ticks: ticksY
]

{ #category : #'instance creation' }
GtPlotterLineChart >> newAxisYTitleElement [

	^ BrFrame new
		fitContent;
		background: BlBackground transparent;
		constraintsDo: [ :c | 
			c linear vertical alignTop ];
		addChild: (BrLabel new
			aptitude: (BrGlamorousLabelAptitude new 
				glamorousRegularFont;
				foreground: Color darkGray;
				fontSize: 16);
			text: titleY asRopedText;
			constraintsDo: [ :c |
				c linear vertical alignCenter.
				c accountTransformation ];
			transformDo: [ :t | 
				t rotateBy: 270 ])
]

{ #category : #private }
GtPlotterLineChart >> newContentElement [
	| aContainer |
	aContainer := BrFrame new
		matchParent;
		addChildren: { self newAxisYLineElement. self newAxisXLineElement }.
	data groupsCollect: [ :aGroup |
		aContainer addChild: (self newContentLineElementFor: aGroup) ].
	projectionXValues ifNotNil: [
		aContainer addChild: self newProjectionXLinesElement ].
	pointPredicate ifNotNil: [ aContainer addChildren: self newPointElements ].
	^ aContainer
]

{ #category : #'instance creation' }
GtPlotterLineChart >> newContentLineElementFor: aGroup [
	^ BlElement new
		geometry: (BlNormalizedPolylineGeometry vertices: (self newContentLineVerticesFor: aGroup));
		border: (BlBorder paint: aGroup color width: 1);
		outskirts: BlOutskirts centered;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ]
]

{ #category : #private }
GtPlotterLineChart >> newContentLineVerticesFor: aGroup [
	^ aGroup collect: [ :eachValue | self normalizedPointFor: eachValue ]
]

{ #category : #'instance creation' }
GtPlotterLineChart >> newCornerElement [
	^ BlElement new
		size: 0@0;
		visibility: BlVisibility hidden
]

{ #category : #'instance creation' }
GtPlotterLineChart >> newNoDataElement [
	^ BrLabel new 
		aptitude: (BrGlamorousLabelAptitude new foreground: Color lightGray);
		text: 'no data';
		constraintsDo: [ :c | 
			c grid horizontal alignCenter.
			c grid vertical alignCenter ]
]

{ #category : #'private - points' }
GtPlotterLineChart >> newPointElementFor: aContext [
	| element position |
	position := self normalizedPointFor: aContext originalValue.
	element := self pointStencil cull: aContext.
	element userData at: #plotterPointContext put: aContext.
	element constraintsDo: [ :c |
		c frame horizontal alignCenterAt: position x.
		c frame vertical alignCenterAt: position y ].
	^ element
]

{ #category : #'private - points' }
GtPlotterLineChart >> newPointElements [
	| elements |
	elements := OrderedCollection new.
	pointPredicate ifNil: [ ^ elements ].
	data groupsCollect: [ :aGroup |
		| index |
		index := 0.
		aGroup valuesDo: [ :observation |
			index := index + 1.
			(pointPredicate value: observation) ifTrue: [
				elements add: (self newPointElementFor: (GtPlotterLineChartPointContext new
					originalValue: observation;
					group: aGroup;
					index: index;
					yourself)) ] ] ].
	^ elements
]

{ #category : #'private - points' }
GtPlotterLineChart >> normalizedPointFor: anObservation [
	^ (scaleX map: (valueX value: anObservation))
		@ (1 - (scaleY map: (valueY value: anObservation)))
]

{ #category : #'accessing - points' }
GtPlotterLineChart >> pointStencil [
	^ pointStencil ifNil: [ self defaultPointStencil ]
]

{ #category : #'accessing - points' }
GtPlotterLineChart >> pointStencil: aBlock [
	pointStencil := aBlock
]

{ #category : #'api - data' }
GtPlotterLineChart >> with: aGtPlotterDataGroup [
	data := aGtPlotterDataGroup
]
