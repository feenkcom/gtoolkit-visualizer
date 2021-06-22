Class {
	#name : #GtPlotterLineChart,
	#superclass : #GtPlotterBuilder,
	#instVars : [
		'data',
		'valueX',
		'scaleX',
		'scaleY',
		'valueY',
		'minX',
		'maxX',
		'minY',
		'maxY',
		'titleX',
		'titleY',
		'ticksX',
		'ticksY'
	],
	#category : #'GToolkit-Plotter-Builder - Line Chart'
}

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

	aContainer 
		addChildren: { 
			self newAxisYElement.
			self newContentElement.
			self newCornerElement.
			self newAxisXElement.
		 }.
	
	^ aContainer
]

{ #category : #accessing }
GtPlotterLineChart >> data [
	^ data
]

{ #category : #initialization }
GtPlotterLineChart >> initialize [
	super initialize.
	scaleX := GtPlotterLinearScale new.
	valueX := #key.
	ticksX := 10.
	scaleY := GtPlotterLinearScale new.
	valueY := #value.
	ticksY := 10.
]

{ #category : #initialization }
GtPlotterLineChart >> initializeScales [

	| aMinX aMaxX aMinY aMaxY |
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

{ #category : #accessing }
GtPlotterLineChart >> maxX [
	^ maxX
]

{ #category : #accessing }
GtPlotterLineChart >> maxX: anObject [
	maxX := anObject
]

{ #category : #accessing }
GtPlotterLineChart >> maxY [
	^ maxY
]

{ #category : #accessing }
GtPlotterLineChart >> maxY: anObject [
	maxY := anObject
]

{ #category : #accessing }
GtPlotterLineChart >> minX [
	^ minX
]

{ #category : #accessing }
GtPlotterLineChart >> minX: anObject [
	minX := anObject
]

{ #category : #accessing }
GtPlotterLineChart >> minY [
	^ minY
]

{ #category : #accessing }
GtPlotterLineChart >> minY: anObject [
	minY := anObject
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
		labelFormat: [ :eachDateAndTime | 
			(eachDateAndTime monthAbbreviation, ' ',  eachDateAndTime year asString) 
				asRopedText foreground: Color darkGray ];
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
		labelFormat: [ :aValue | 
			(aValue printShowingDecimalPlaces: 0) asRopedText foreground: Color darkGray ];
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

{ #category : #'instance creation' }
GtPlotterLineChart >> newContentElement [
	| aContainer |
	aContainer := BrFrame new
		matchParent;
		addChildren: { 
			self newAxisYLineElement.
			self newAxisXLineElement. }.
	
	data groupsCollect: [ :aGroup |
		aContainer addChild: (self newContentLineElementFor: aGroup) ].
	
	^ aContainer
]

{ #category : #'instance creation' }
GtPlotterLineChart >> newContentLineElementFor: aGroup [
	^ BlElement new
		geometry: (BlNormalizedPolyline vertices: (self newContentLineVerticesFor: aGroup));
		border: (BlBorder paint: aGroup color width: 1);
		outskirts: BlOutskirts centered;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ]
]

{ #category : #'instance creation' }
GtPlotterLineChart >> newContentLineVerticesFor: aGroup [
	^ aGroup collect: [ :eachValue | 
		(scaleX map: (valueX value: eachValue)) @ (1 - (scaleY map: (valueY value: eachValue))) ].
]

{ #category : #'instance creation' }
GtPlotterLineChart >> newCornerElement [
	^ BlElement new
		size: 0@0;
		visibility: BlVisibility hidden
]

{ #category : #accessing }
GtPlotterLineChart >> scaleX [
	^ scaleX
]

{ #category : #accessing }
GtPlotterLineChart >> scaleX: anObject [
	scaleX := anObject
]

{ #category : #accessing }
GtPlotterLineChart >> scaleY [
	^ scaleY
]

{ #category : #accessing }
GtPlotterLineChart >> scaleY: anObject [
	scaleY := anObject
]

{ #category : #'api - axes' }
GtPlotterLineChart >> ticksX: aNumber [
	"Define number of axis ticks"
	ticksX := aNumber
]

{ #category : #'api - axes' }
GtPlotterLineChart >> ticksY: aNumber [
	"Define number of axis ticks"
	ticksY := aNumber
]

{ #category : #'api - axes' }
GtPlotterLineChart >> titleX: aString [
	titleX := aString
]

{ #category : #'api - axes' }
GtPlotterLineChart >> titleY: aString [
	titleY := aString
]

{ #category : #accessing }
GtPlotterLineChart >> valueX [
	^ valueX
]

{ #category : #accessing }
GtPlotterLineChart >> valueX: anObject [
	valueX := anObject
]

{ #category : #accessing }
GtPlotterLineChart >> valueY [
	^ valueY
]

{ #category : #accessing }
GtPlotterLineChart >> valueY: anObject [
	valueY := anObject
]

{ #category : #'api - data' }
GtPlotterLineChart >> with: aGtPlotterDataGroup [
	data := aGtPlotterDataGroup
]
