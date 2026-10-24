"
Piecewise cubic Bezier geometry for Graphviz paths (1 + 3n control points), not a single higher-order Bezier.
"
Class {
	#name : #GtGraphvizSplineGeometry,
	#superclass : #BlBezierCurveGeometry,
	#category : #'GToolkit-Graphviz-Edges'
}

{ #category : #drawing }
GtGraphvizSplineGeometry >> buildPathOnSpartaCanvas: canvas [
	| path |
	self controlPoints size < 4 ifTrue: [ ^ super buildPathOnSpartaCanvas: canvas ].
	path := canvas path moveTo: self controlPoints first.
	2 to: self controlPoints size - 2 by: 3 do: [ :i |
		path curveVia: (self controlPoints at: i) and: (self controlPoints at: i + 1) to: (self controlPoints at: i + 2) ].
	^ path build
]
