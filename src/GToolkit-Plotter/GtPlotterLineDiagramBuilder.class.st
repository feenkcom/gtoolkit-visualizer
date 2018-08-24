Class {
	#name : #GtPlotterLineDiagramBuilder,
	#superclass : #GtPlotterBuilder,
	#instVars : [
		'axisY',
		'axisX',
		'lineBlock',
		'dotBlock'
	],
	#category : 'GToolkit-Plotter'
}

{ #category : #'private - instance creation' }
GtPlotterLineDiagramBuilder >> defaultDotElement [
	<return: #BlLineElement>

	^ BlElement new
		size: 0@0;
		yourself
]

{ #category : #'private - instance creation' }
GtPlotterLineDiagramBuilder >> defaultLineElement [
	<return: #BlLineElement>

	^ BlLineElement new
		border: (BlBorder paint: Color gray width: 1);
		yourself
]

{ #category : #'private - accessing' }
GtPlotterLineDiagramBuilder >> domianElements [
	<return: #Collection of: #BlElement>

	^ self topStep root children select: [ :aChildElement | aChildElement constraints plotter hasDomainObject ]
]

{ #category : #'api - scripting' }
GtPlotterLineDiagramBuilder >> dot: aBlock [
	dotBlock := aBlock
]

{ #category : #initialization }
GtPlotterLineDiagramBuilder >> initialize [
	super initialize.
	
	axisX := BlElement new.
	axisX background: Color black.
	axisX constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical exact: 0 ].
	axisX constraintsDo: [ :c | c plotter horizontal axis: (GtPlotterContinuousAxis new valueSelector: #yourself) ].
	
	axisY := BlElement new.
	axisY background: Color black.
	axisY constraintsDo: [ :c |
		c horizontal exact: 0.
		c vertical matchParent ].
	axisY constraintsDo: [ :c | c plotter vertical axis: (GtPlotterContinuousAxis new valueSelector: #yourself) ]
]

{ #category : #'private - instance creation' }
GtPlotterLineDiagramBuilder >> lineAnchorElementFor: anObject [
	<return: #BlElement>
	| aDotElement |
	
	aDotElement := dotBlock 
		ifNotNil: [ dotBlock cull: anObject cull: self defaultDotElement ]
		ifNil: [ self defaultDotElement ].

	aDotElement
		constraintsDo: [ :c | c plotter domainObject: (GtPlotterDomainObject new value: anObject) ].

	^ aDotElement
]

{ #category : #'private - instance creation' }
GtPlotterLineDiagramBuilder >> lineElementFrom: aFromAnchorElement to: aToAnchorElement [
	| aLineElement aFromValue aToValue |
			
	aFromValue := aFromAnchorElement constraints plotter domainObject value.
	aToValue := aToAnchorElement constraints plotter domainObject value.
	
	aLineElement := lineBlock 
		ifNotNil: [ lineBlock cull: aFromValue cull: aToValue cull: self defaultLineElement ]
		ifNil: [ self defaultLineElement ].

	aLineElement
		constraintsDo: [ :c | c ignoreByLayout ];
		fromAnchor: (BlElementCenterAnchor element: aFromAnchorElement);
		toAnchor: (BlElementCenterAnchor element: aToAnchorElement).
		
	aFromAnchorElement when: BlElementRemovedEvent do: [ aLineElement removeFromParent ].
	aToAnchorElement when: BlElementRemovedEvent do: [ aLineElement removeFromParent ].
	
	^ aLineElement
]

{ #category : #'api - scripting' }
GtPlotterLineDiagramBuilder >> maxY: aProjectedValue [
	axisY constraints plotter vertical axis maxLimit: (GtPlotterAxisValuedLimit new value: aProjectedValue)
]

{ #category : #'api - scripting' }
GtPlotterLineDiagramBuilder >> minY: aProjectedValue [
	axisY constraints plotter vertical axis minLimit: (GtPlotterAxisValuedLimit new value: aProjectedValue)
]

{ #category : #'api - scripting' }
GtPlotterLineDiagramBuilder >> pop [
	| aFirstLineAnchorElement |

	aFirstLineAnchorElement := self domianElements
		ifEmpty: [ ^ self ]
		ifNotEmpty: #first.
		
	aFirstLineAnchorElement removeFromParent
]

{ #category : #'api - scripting' }
GtPlotterLineDiagramBuilder >> push: anObject [
	| aLineAnchorElement aLastLineAnchorElement aLineElement |

	aLineAnchorElement := self lineAnchorElementFor: anObject.

	aLastLineAnchorElement := self domianElements
		ifEmpty: [
			self topStep addChildren: { aLineAnchorElement }.
			^ self ]
		ifNotEmpty: #last.

	aLineElement := self lineElementFrom: aLastLineAnchorElement to: aLineAnchorElement.

	self topStep addChildren: { aLineAnchorElement . aLineElement }
]

{ #category : #'api - scripting' }
GtPlotterLineDiagramBuilder >> shape: aBlock [
	lineBlock := aBlock
]

{ #category : #'api - scripting' }
GtPlotterLineDiagramBuilder >> with: aCollection [
	| theAnchors theLines |

	self topStep removeChildren.

	self topStep addChildren: { axisX . axisY }.
	
	"we must not proceed, because overlapping pairs does not work with an empty collection :)"
	aCollection
		ifEmpty: [ ^ self ].

	theAnchors := aCollection collect: [ :each |
		| aLineAnchorElement |
		aLineAnchorElement := self lineAnchorElementFor: each.
		aLineAnchorElement ].

	theLines := theAnchors overlappingPairsCollect: [ :aFromAnchorElement :aToAnchorElement |
		self lineElementFrom: aFromAnchorElement to: aToAnchorElement ].

	self topStep addChildren: theAnchors.
	self topStep addChildren: theLines.
]

{ #category : #'api - scripting' }
GtPlotterLineDiagramBuilder >> x: aBlock [
	axisX constraintsDo: [ :c | c plotter horizontal axis: (GtPlotterContinuousAxis new valueSelector: aBlock) ]
]

{ #category : #'api - scripting' }
GtPlotterLineDiagramBuilder >> xAxisDo: aBlock [
	aBlock value: axisX
]

{ #category : #'api - scripting' }
GtPlotterLineDiagramBuilder >> y: aBlock [
	axisY constraintsDo: [ :c | c plotter vertical axis: (GtPlotterContinuousAxis new valueSelector: aBlock) ]
]

{ #category : #'api - scripting' }
GtPlotterLineDiagramBuilder >> yAxisDo: aBlock [
	aBlock value: axisY
]
