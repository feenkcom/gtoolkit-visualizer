Class {
	#name : #GtPlotterScatterChart,
	#superclass : #GtPlotterBuilder,
	#instVars : [
		'data',
		'scaleX',
		'scaleY',
		'ticksX',
		'ticksY',
		'titleX',
		'titleY',
		'valueX',
		'valueY',
		'labelFormatX',
		'labelFormatY',
		'isAlreadyInitialized',
		'minX',
		'maxX',
		'minY',
		'maxY',
		'dotElementStencil'
	],
	#category : #'GToolkit-Plotter-Builder - Scatter Chart'
}

{ #category : #'api - instantiation' }
GtPlotterScatterChart >> create [
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

{ #category : #accessing }
GtPlotterScatterChart >> data [
	^ data
]

{ #category : #accessing }
GtPlotterScatterChart >> dotElement [
	^ dotElementStencil
]

{ #category : #accessing }
GtPlotterScatterChart >> dotElement: aStencil [
	dotElementStencil := aStencil asStencilBuilder: GtPlotterScaleBasedStencilBuilder
]

{ #category : #initalization }
GtPlotterScatterChart >> initialize [

	super initialize.
	self dotElement: [:ex | BlElement new
		geometry: BlEllipseGeometry new;
		size: 10 asPoint  ].
	isAlreadyInitialized := false.
	scaleX := GtPlotterLinearScale new.
	valueX := #yourself.
	ticksX := 10.
	labelFormatX := [ :labelObject | labelObject asRopedText foreground: Color darkGray ].
	data :=  GtPlotterDataGroup new.
	scaleY := GtPlotterLinearScale new.
	valueY := #value.
	ticksY := 10.
	labelFormatY := [ :aValue | 
		(aValue printShowingDecimalPlaces: 0) asRopedText foreground: Color darkGray ].	
	
]

{ #category : #'api - instantiation' }
GtPlotterScatterChart >> initializeScales [
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

{ #category : #'api - instantiation' }
GtPlotterScatterChart >> newAxisXElement [
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

{ #category : #'api - instantiation' }
GtPlotterScatterChart >> newAxisXLineElement [
	^ BlElement new
		height: 2;
		background: (Color veryVeryLightGray);
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c frame vertical alignBottom ]
]

{ #category : #'api - instantiation' }
GtPlotterScatterChart >> newAxisXTickLabelsElement [
	^ GtPlotterHorizontalTickLabelsElement new
		scale: self scaleX;
		labelFormat: labelFormatX;
		constraintsDo: [ :c | c vertical fitContent ];
		clipChildren: false;
		labels: ticksX
]

{ #category : #'api - instantiation' }
GtPlotterScatterChart >> newAxisXTicksElement [
	
	^ GtPlotterHorizontalTicksElement new
		scale: self scaleX;
		tickStyle: [ :anElement | anElement
			width: 2;
			background: (Color gray alpha: 0.8) ];
		ticks: ticksX
]

{ #category : #'api - instantiation' }
GtPlotterScatterChart >> newAxisXTitleElement [

	^ BrLabel new
		aptitude: (BrGlamorousLabelAptitude new 
			glamorousRegularFont;
			foreground: Color darkGray;
			fontSize: 16);
		text: titleX asRopedText;
		constraintsDo: [ :c |
			c linear horizontal alignRight ]
]

{ #category : #'api - instantiation' }
GtPlotterScatterChart >> newAxisYElement [
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

{ #category : #'api - instantiation' }
GtPlotterScatterChart >> newAxisYLineElement [
	^ BlElement new
		width: 2;
		background: (Color veryVeryLightGray);
		constraintsDo: [ :c | 
			c vertical matchParent.
			c frame horizontal alignLeft ]
]

{ #category : #'api - instantiation' }
GtPlotterScatterChart >> newAxisYTickLabelsElement [
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

{ #category : #'api - instantiation' }
GtPlotterScatterChart >> newAxisYTicksElement [
	^ GtPlotterVerticalTicksElement new
		scale: self scaleY;
		tickStyle: [ :anElement | anElement
			height: 2;
			background: (Color gray alpha: 0.8) ];
		ticks: ticksY
]

{ #category : #'api - instantiation' }
GtPlotterScatterChart >> newAxisYTitleElement [

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

{ #category : #'api - instantiation' }
GtPlotterScatterChart >> newContentElement [
	| aContainer |
	aContainer := BrFrame new
		matchParent;
		addChildren: {
			self newAxisYLineElement.
			self newAxisXLineElement. }.
	
	data groupsCollect: [ :aGroup |
		aContainer addChild: (self newPointElementFor: aGroup) ].

	^ aContainer
]

{ #category : #'api - instantiation' }
GtPlotterScatterChart >> newCornerElement [
	^ BlElement new
		size: 0@0;
		visibility: BlVisibility hidden
]

{ #category : #accessing }
GtPlotterScatterChart >> newNoDataElement [
	^ BrLabel new 
		aptitude: (BrGlamorousLabelAptitude new foreground: Color lightGray);
		text: 'No data';
		constraintsDo: [ :c | 
			c grid horizontal alignCenter.
			c grid vertical alignCenter ]
]

{ #category : #'api - instantiation' }
GtPlotterScatterChart >> newPointElementFor: aGroup [
	| container |
	container := BrFrame new.
	container matchParent.
	container layout: BlRelativePositionLayout new.
	container addChildren: (aGroup collectWithIndex: [:eachValue :index |
		| positionNormalized element context |
		positionNormalized := self scaledPoint: eachValue .
		context := GtPlotterScaleContext new
			index: index;
			originalValue: eachValue.
		element := (dotElementStencil scaleContext: context) asElement.
		element
			when: BlClickEvent do: [ :anEvent |
				anEvent consumed: true.
				anEvent currentTarget phlow spawnObject: eachValue ];
			background: aGroup color;
			constraintsDo: [:c |
				c relativePosition percent: positionNormalized
			];
			yourself
		
	]).
	^ container

]

{ #category : #accessing }
GtPlotterScatterChart >> scaleX [
	^ scaleX
]

{ #category : #accessing }
GtPlotterScatterChart >> scaleX: anObject [
	scaleX := anObject
]

{ #category : #accessing }
GtPlotterScatterChart >> scaleY [
	^ scaleY
]

{ #category : #accessing }
GtPlotterScatterChart >> scaleY: anObject [
	scaleY := anObject
]

{ #category : #'api - instantiation' }
GtPlotterScatterChart >> scaledPoint: eachValue [
	^ (scaleX map: (valueX value: eachValue)) @ (1 - (scaleY map: (valueY value: eachValue)))
]

{ #category : #accessing }
GtPlotterScatterChart >> ticksX: aNumber [
	"Define number of axis ticks"
	ticksX := aNumber
]

{ #category : #accessing }
GtPlotterScatterChart >> ticksY: aNumber [
	"Define number of axis ticks"
	ticksY := aNumber
]

{ #category : #accessing }
GtPlotterScatterChart >> titleX: aString [
	titleX := aString
]

{ #category : #accessing }
GtPlotterScatterChart >> titleY: aString [
	titleY := aString
]

{ #category : #accessing }
GtPlotterScatterChart >> valueX [
	^ valueX
]

{ #category : #accessing }
GtPlotterScatterChart >> valueX: anObject [
	valueX := anObject
]

{ #category : #accessing }
GtPlotterScatterChart >> valueY [
	^ valueY
]

{ #category : #accessing }
GtPlotterScatterChart >> valueY: anObject [
	valueY := anObject
]

{ #category : #accessing }
GtPlotterScatterChart >> with: aGtPlotterDataGroup [
	data := aGtPlotterDataGroup
]
