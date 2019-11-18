"
I offer a fluent API for constructing graph-based visualizations.
"
Class {
	#name : #GtMondrian,
	#superclass : #Object,
	#instVars : [
		'stack'
	],
	#category : #'GToolkit-Mondrian'
}

{ #category : #accessing }
GtMondrian >> asElement [
	^ self asPannableElement
]

{ #category : #ui }
GtMondrian >> asPannableElement [
	| pannable |
	pannable := BlPannableElement new.
	pannable
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].	
	pannable contentElement: self root removeFromParent.
	pannable zoomableElement clipChildren: false.
	^ pannable
]

{ #category : #ui }
GtMondrian >> asScalableElement [
	| scalable |
	scalable := BlScalableElement new.
	scalable
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
	scalable contentElement: self topStep root.
	^ scalable
]

{ #category : #scripting }
GtMondrian >> edges [
	^ GtMondrianEdgeBuilder new mondrian: self
]

{ #category : #ui }
GtMondrian >> gtInspectorLiveIn: composite [
	<gtInspectorPresentationOrder: 0>
	
	^ composite blocMondrian 
		title: 'Live';
		initializeView: [ self ];
		when: [ self topStep root hasParent not ]
]

{ #category : #ui }
GtMondrian >> gtInspectorPreviewIn: composite [
	<gtInspectorPresentationOrder: 1>
	self topStep root gtInspectorPreviewIn: composite
]

{ #category : #ui }
GtMondrian >> gtLiveFor: aView [
	<gtView>
	^ aView mondrian
		title: 'Live';
		priority: 50;
		initialize: self
]

{ #category : #initialize }
GtMondrian >> initialize [
	stack := Stack new.
	stack push: (GtMondrianStep new 
		root: ((BlElement new
			in: [ :aRootElement | aRootElement phlow bePopupContainer ];
			constraintsDo: [ :constraints |
				constraints horizontal fitContent.
				constraints vertical fitContent.
				constraints padding: (BlInsets all: 50) ];
			background: Color white;
			zIndex: 1)))
]

{ #category : #scripting }
GtMondrian >> layout [
	^ GtMondrianLayoutBuilder new mondrian: self
]

{ #category : #accessing }
GtMondrian >> nodeAt: anObject ifAbsent: aBlock [
	^ self topStep nodeAt: anObject ifAbsent: aBlock
]

{ #category : #accessing }
GtMondrian >> nodeAt: anObject put: aNode [
	^ self topStep nodeAt: anObject put: aNode
]

{ #category : #scripting }
GtMondrian >> nodes [
	^ GtMondrianNodeBuilder new mondrian: self
]

{ #category : #accessing }
GtMondrian >> root [
	^ self topStep root
]

{ #category : #stack }
GtMondrian >> topStep [
	^ stack top
]

{ #category : #stack }
GtMondrian >> with: aStep do: aBlock [
	stack push: aStep.
	aBlock value.
	stack pop 
]
