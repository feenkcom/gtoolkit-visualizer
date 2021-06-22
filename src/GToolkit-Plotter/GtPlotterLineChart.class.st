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
		'maxY'
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
			self newCornerElement.
			self newContentElement.
			self newCornerElement.
			self newCornerElement.
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
	scaleY := GtPlotterLinearScale new.
	valueY := #value.
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
GtPlotterLineChart >> newAxisXLineElement [
	^ BlElement new
		height: 2;
		background: (Color veryVeryLightGray);
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c frame vertical alignBottom ]
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
GtPlotterLineChart >> newContentElement [
	^ BrFrame new
		matchParent;
		addChildren: { 
			self newAxisYLineElement.
			self newAxisXLineElement.		
			self newContentLineElement. }
]

{ #category : #'instance creation' }
GtPlotterLineChart >> newContentLineElement [
	^ BlElement new
		geometry: (BlNormalizedPolyline vertices: self newContentLineVertices);
		border: (BlBorder paint: Color orange width: 2);
		outskirts: BlOutskirts centered;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ]
]

{ #category : #'instance creation' }
GtPlotterLineChart >> newContentLineVertices [
	^ self data collect: [ :eachValue | 
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

{ #category : #'instance creation' }
GtPlotterLineChart >> with: aGtPlotterDataGroup [
	data := aGtPlotterDataGroup
]
