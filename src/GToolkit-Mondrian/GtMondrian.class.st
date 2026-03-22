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

{ #category : #ui }
GtMondrian >> asElement [
	^ self root removeFromParent
]

{ #category : #ui }
GtMondrian >> asPannableElement [
	^ self asElement asPannableElement
]

{ #category : #ui }
GtMondrian >> asScalableElement [
	^ self asElement
]

{ #category : #accessing }
GtMondrian >> edgeElements [
	^ self root allChildrenBreadthFirstSelect: [ :each | each graph isEdge ]
]

{ #category : #scripting }
GtMondrian >> edges [
	^ GtMondrianEdgeBuilder new mondrian: self
]

{ #category : #views }
GtMondrian >> gtEdgeElementsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Edge elements';
		priority: 15;
		items: [ self edgeElements ];
		column: 'Edge' text: [ :each | each gtDisplayString ]
]

{ #category : #ui }
GtMondrian >> gtLiveFor: aView [
	<gtView>
	^ aView mondrian
		title: 'Live';
		priority: 1;
		initialize: self
]

{ #category : #views }
GtMondrian >> gtNodeElementsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Node elements';
		priority: 10;
		items: [ self nodeElements ];
		column: 'Element' text: [ :each | each gtDisplayString ]
]

{ #category : #initialize }
GtMondrian >> initialize [
	stack := Stack new.
	stack push: (GtMondrianStep new 
		root: ((BlCanvassableElement new
			enableAutoScale;
			in: [ :aRootElement | aRootElement phlow bePopupContainer ];
			constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical matchParent.
				c padding: (BlInsets all: 10) ];
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

{ #category : #accessing }
GtMondrian >> nodeElements [
	^ self root allChildrenBreadthFirstSelect: [ :each | each graph isNode ]
]

{ #category : #scripting }
GtMondrian >> nodes [
	^ GtMondrianNodeBuilder new mondrian: self
]

{ #category : #accessing }
GtMondrian >> positions [
	"Get the positions of my nodes — useful for explicit layouts."

	^ self root children collect: #position
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
