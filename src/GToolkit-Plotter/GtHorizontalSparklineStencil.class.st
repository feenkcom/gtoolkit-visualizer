Class {
	#name : #GtHorizontalSparklineStencil,
	#superclass : #BrStencil,
	#instVars : [
		'values',
		'maxY',
		'minY',
		'minX',
		'maxX',
		'color'
	],
	#category : #'GToolkit-Plotter-! Plotter - Stencils'
}

{ #category : #accessing }
GtHorizontalSparklineStencil >> color [
	^ color
]

{ #category : #accessing }
GtHorizontalSparklineStencil >> color: aColorBlock [
	color := aColorBlock
]

{ #category : #'api - instantiation' }
GtHorizontalSparklineStencil >> create [
	<return: #Object>
	| theData aMinY aMaxY aMinX aMaxX aScaleX aScaleY |

	theData := GtPlotterDataGroup new values: values.
	
	color ifNotNil: [ :aColorBlock | theData := theData background: aColorBlock ].
	
	aMinX := minX ifNil: [ theData inject: Float infinity intoValues: [ :eachMin :eachValue | eachMin min: eachValue value ] ].
	aMaxX := maxX ifNil: [ theData inject: Float negativeInfinity intoValues: [ :eachMax :eachValue | eachMax max: eachValue value ] ].

	aMinX isInfinite
		ifTrue: [ aMinX := 0 ].
	aMaxX isInfinite
		ifTrue: [ aMaxX := 0 ].

	aMinY := minY ifNil: [ theData inject: Float infinity intoValues: [ :eachMin :eachValue | eachMin min: eachValue key ] ].
	aMaxY := maxY ifNil: [ theData inject: Float negativeInfinity intoValues: [ :eachMax :eachValue | eachMax max: eachValue key ] ].

	aMinY isInfinite
		ifTrue: [ aMinY := 0 ].
	aMaxY isInfinite
		ifTrue: [ aMaxY := 0 ].

	aScaleX := GtPlotterLinearScale new domainFrom: aMinX to: aMaxX.
	aScaleY := GtPlotterLinearScale new domainFrom: aMinY to: aMaxY.

	^ (GtPlotterHorizontalSparkline new
		lineWidth: 1;
		scaleX: aScaleX;
		scaleDataX: [ :eachItem | eachItem value ];
		scaleY: aScaleY;
		scaleDataY: [ :eachItem | eachItem key ];
		with: theData) asElement
]

{ #category : #initialization }
GtHorizontalSparklineStencil >> initialize [
	super initialize.
	
	minX := nil.
	maxX := nil.
	minY := nil.
	maxY := nil.
	values := #()
]

{ #category : #accessing }
GtHorizontalSparklineStencil >> maxX [
	^ maxX
]

{ #category : #accessing }
GtHorizontalSparklineStencil >> maxX: anObject [
	maxX := anObject
]

{ #category : #accessing }
GtHorizontalSparklineStencil >> maxY [
	^ maxY
]

{ #category : #accessing }
GtHorizontalSparklineStencil >> maxY: anObject [
	maxY := anObject
]

{ #category : #accessing }
GtHorizontalSparklineStencil >> minX [
	^ minX
]

{ #category : #accessing }
GtHorizontalSparklineStencil >> minX: anObject [
	minX := anObject
]

{ #category : #accessing }
GtHorizontalSparklineStencil >> minY [
	^ minY
]

{ #category : #accessing }
GtHorizontalSparklineStencil >> minY: anObject [
	minY := anObject
]

{ #category : #accessing }
GtHorizontalSparklineStencil >> values [
	^ values
]

{ #category : #accessing }
GtHorizontalSparklineStencil >> values: anObject [
	values := anObject
]
