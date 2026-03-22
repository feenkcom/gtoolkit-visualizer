Class {
	#name : #GtPlotterHorizontalSparkline,
	#superclass : #GtPlotterBuilder,
	#instVars : [
		'scaleX',
		'scaleY',
		'data',
		'scaleDataBlockX',
		'scaleDataBlockY',
		'lineWidth'
	],
	#category : #'GToolkit-Plotter-Builder - Sparkline'
}

{ #category : #'api - instantiation' }
GtPlotterHorizontalSparkline >> create [
	<return: #Object>
	| aContainer |
	
	aContainer := BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ].

	aContainer addChildren: (data groupsCollect: [ :aGroup |
		| theVertices |
		
		theVertices := aGroup values collect: [ :eachValue | ((scaleX map: (scaleDataBlockX cull: eachValue)) @ (1 - (scaleY map: (scaleDataBlockY cull: eachValue)))) ].
		
		BlElement new
			geometry: (BlNormalizedPolylineGeometry vertices: theVertices);
			border: (BlBorder paint: aGroup color width: self lineWidth);
			outskirts: BlOutskirts centered;
			constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical matchParent ] ]).

	^ aContainer
]

{ #category : #initialization }
GtPlotterHorizontalSparkline >> initialize [
	super initialize.
	
	scaleX := GtPlotterLinearScale new.
	scaleDataBlockX := [ :eachValue | eachValue ].
	
	scaleY := GtPlotterLinearScale new.
	scaleDataBlockY := [ :eachValue | eachValue ].
	
	lineWidth := 1.
	
	data := GtPlotterDataGroup new
]

{ #category : #'api  - line' }
GtPlotterHorizontalSparkline >> lineWidth [
	^ lineWidth
]

{ #category : #'api  - line' }
GtPlotterHorizontalSparkline >> lineWidth: aNumber [
	lineWidth := aNumber
]

{ #category : #accessing }
GtPlotterHorizontalSparkline >> scaleDataX [
	^ scaleDataBlockX
]

{ #category : #accessing }
GtPlotterHorizontalSparkline >> scaleDataX: anObject [
	scaleDataBlockX := anObject
]

{ #category : #accessing }
GtPlotterHorizontalSparkline >> scaleDataY [
	^ scaleDataBlockY
]

{ #category : #accessing }
GtPlotterHorizontalSparkline >> scaleDataY: anObject [
	scaleDataBlockY := anObject
]

{ #category : #accessing }
GtPlotterHorizontalSparkline >> scaleX [
	^ scaleX
]

{ #category : #accessing }
GtPlotterHorizontalSparkline >> scaleX: anObject [
	scaleX := anObject
]

{ #category : #accessing }
GtPlotterHorizontalSparkline >> scaleY [
	^ scaleY
]

{ #category : #accessing }
GtPlotterHorizontalSparkline >> scaleY: anObject [
	scaleY := anObject
]

{ #category : #accessing }
GtPlotterHorizontalSparkline >> with: aGtPlotterDataEntity [
	data := aGtPlotterDataEntity
]
