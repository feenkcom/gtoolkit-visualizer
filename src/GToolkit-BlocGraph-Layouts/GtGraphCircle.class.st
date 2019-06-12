Class {
	#name : #GtGraphCircle,
	#superclass : #Object,
	#instVars : [
		'center',
		'radius',
		'margin'
	],
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Circle'
}

{ #category : #converting }
GtGraphCircle >> asElement [
	| aContainer aMarginCircle anActualCircle aCenter aBorderWidth aCenterBounds |

	aBorderWidth := (self radius / 50.0) min: 0.5.

	aContainer := BlElement new.
	aContainer size: (self radius + self margin) * 2 asPoint.

	aMarginCircle := BlElement new.
	aMarginCircle geometry: BlEllipse new.
	aMarginCircle size: (self radius + self margin) * 2 asPoint.
	aMarginCircle border: (BlBorder builder dashedSmall paint: (Color gray alpha: 0.2); width: aBorderWidth; build).

	anActualCircle := BlElement new.
	anActualCircle geometry: BlEllipse new.
	anActualCircle size: self radius * 2 asPoint.
	anActualCircle relocate: self margin asPoint.
	anActualCircle border: (BlBorder paint: Color black width: aBorderWidth).
	anActualCircle when: BlClickEvent do: [ :anEvent |
		anEvent consumed: true.
		anEvent currentTarget phlow spawnObject: self ].

	aCenterBounds := (self outerRadius asPoint - (self radius / 20) asPoint) extent: (self radius / 10) asPoint.
	aCenter := BlElement new.
	aCenter geometry: BlEllipse new.
	aCenter relocate: aCenterBounds origin.
	aCenter size: aCenterBounds extent.
	aCenter background: Color red.
	aCenter userData at: #centerBounds put: aCenterBounds.

	aContainer addChild: aMarginCircle as: #margin.
	aContainer addChild: anActualCircle as: #circle.
	aContainer addChild: aCenter as: #center.
	
	^ aContainer
]

{ #category : #accessing }
GtGraphCircle >> center [
	^ center
]

{ #category : #accessing }
GtGraphCircle >> center: aPoint [
	center := aPoint
]

{ #category : #'gt-inspector-extension' }
GtGraphCircle >> gtPreviewFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Preview';
		stencil: [ self asElement asScalableElement ]
]

{ #category : #initialization }
GtGraphCircle >> initialize [
	super initialize.
	
	radius := 0.
	center := 0@0.
	margin := 0.
]

{ #category : #accessing }
GtGraphCircle >> margin [
	^ margin
]

{ #category : #accessing }
GtGraphCircle >> margin: aNumber [
	margin := aNumber
]

{ #category : #accessing }
GtGraphCircle >> origin [
	^ self center - (self radius + self margin) asPoint
]

{ #category : #accessing }
GtGraphCircle >> outerRadius [
	^ self radius + self margin
]

{ #category : #accessing }
GtGraphCircle >> radius [
	^ radius
]

{ #category : #accessing }
GtGraphCircle >> radius: aNumber [
	radius := aNumber
]
