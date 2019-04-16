Class {
	#name : #GtHorizontalSparklineStencil,
	#superclass : #BrStencil,
	#instVars : [
		'values',
		'maxY',
		'minY'
	],
	#category : #'GToolkit-Plotter'
}

{ #category : #'api - instantiation' }
GtHorizontalSparklineStencil >> create [
	<return: #Object>
	| aPlotter aLine |

	aPlotter := GtPlotter new.
	aLine := aPlotter line
		x: #key;
		y: #value;
		minY: self minY.

	maxY ifNotNil: [ :theMax | aLine maxY: theMax ].

	aLine with: self values.

	^ BlElement new
		layout: BlFrameLayout new;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		padding: (BlInsets all: 1);
		addChild: aPlotter root
]

{ #category : #initialization }
GtHorizontalSparklineStencil >> initialize [
	super initialize.
	
	minY := 0.
	values := #()
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
