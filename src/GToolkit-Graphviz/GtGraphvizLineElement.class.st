"
Native routed curve. Route offsets are relative to its source center anchor so parent translation and layout normalization are preserved. Rerun layout after moving nodes to recompute routing.
"
Class {
	#name : #GtGraphvizLineElement,
	#superclass : #BlBezierElement,
	#instVars : [
		'routeOffsets'
	],
	#category : #'GToolkit-Graphviz-Edges'
}

{ #category : #'instance creation' }
GtGraphvizLineElement class >> from: source to: target [
	| edge |
	edge := self new
		fromAnchor: (BlElementCenterAnchor element: source);
		toAnchor: (BlElementCenterAnchor element: target).
	edge constraints ignoreByLayout.
	edge userData at: #graphvizSource put: source; at: #graphvizTarget put: target.
	^ edge
]

{ #category : #routing }
GtGraphvizLineElement >> anchorPositions [
	routeOffsets ifNil: [ ^ super anchorPositions ].
	^ routeOffsets collect: [ :offset | self fromPosition + offset ]
]

{ #category : #routing }
GtGraphvizLineElement >> clearRoute [
	routeOffsets ifNil: [ ^ self ].
	routeOffsets := nil.
	self requestLayout
]

{ #category : #routing }
GtGraphvizLineElement >> decoratedAnchorPositions [
	"Graphviz already clips the path for arrows; do not shorten it again."
	^ self anchorPositions
]

{ #category : #initialization }
GtGraphvizLineElement >> defaultGeometry [
	^ GtGraphvizSplineGeometry new
]

{ #category : #routing }
GtGraphvizLineElement >> graphvizApplyRoutes: edgeRoutes nodeIds: ids sourceCenters: centers [
	| source target routes |
	source := self userData at: #graphvizSource.
	target := self userData at: #graphvizTarget.
	routes := (ids includesKey: source) & (ids includesKey: target)
		ifTrue: [ edgeRoutes at: (ids at: source) -> (ids at: target) ifAbsent: [ #() ] ]
		ifFalse: [ #() ].
	routes ifEmpty: [ self clearRoute ]
		ifNotEmpty: [ self route: routes removeFirst relativeTo: (centers at: source) ]
]

{ #category : #routing }
GtGraphvizLineElement >> route: points relativeTo: sourceCenter [
	| offsets |
	(points size >= 4 and: [ (points size - 1) \\ 3 = 0 ])
		ifFalse: [ self error: 'Expected a piecewise cubic Graphviz path' ].
	offsets := points collect: [ :point | point - sourceCenter ].
	routeOffsets = offsets ifTrue: [ ^ self ].
	routeOffsets := offsets.
	self requestLayout
]

{ #category : #routing }
GtGraphvizLineElement >> toPosition [
	"Place native arrowheads at the routed endpoint, not at the target's center."
	routeOffsets ifNil: [ ^ super toPosition ].
	^ self fromPosition + routeOffsets last
]
