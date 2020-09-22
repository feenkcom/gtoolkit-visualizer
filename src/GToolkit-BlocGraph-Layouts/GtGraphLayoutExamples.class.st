Class {
	#name : #GtGraphLayoutExamples,
	#superclass : #Object,
	#category : #'GToolkit-BlocGraph-Layouts-Examples'
}

{ #category : #examples }
GtGraphLayoutExamples class >> gtExamplesProvider [
	^ self new
]

{ #category : #'as yet unclassified' }
GtGraphLayoutExamples >> applyLayoutIn: anElement [
	anElement forceLayout
]

{ #category : #'building - graph' }
GtGraphLayoutExamples >> connect: nodes from: aBlockOrASymbol [
	^ self connect: nodes from: aBlockOrASymbol to: #yourself
]

{ #category : #'building - graph' }
GtGraphLayoutExamples >> connect: nodes from: aFromBlock to: aBlockOrSymbol [

	^ nodes
		collect: [ :e | 
			| fromModel toModel fromElement toElement |

			fromModel := aFromBlock cull: (e userData at: #model).
			toModel := aBlockOrSymbol cull: (e userData at: #model).
			
			fromElement := nodes detect: [ :el | (el userData at: #model) = fromModel ] ifNone: [ nil ].
			toElement := nodes detect: [ :el | (el userData at: #model) = toModel ] ifNone: [ nil ].	
			self createEdgeIfNecessaryFrom: fromElement to: toElement ]
		thenSelect: #isNotNil
]

{ #category : #'building - edges' }
GtGraphLayoutExamples >> connectPairsOfNodes: nodes pairs: pairsOfNodes [
	pairsOfNodes do: [ :aPair |
		((aPair key between: 1 and: nodes size)
			and: [ aPair value between: 1 and: nodes size ])
				ifTrue: [
					| fromNode toNode anEdge |
					fromNode := nodes at: aPair key.
					toNode := nodes at: aPair value.
					
					anEdge := self edgeFrom: fromNode to: toNode.
					
					fromNode addConnectedEdge: anEdge.
					toNode addConnectedEdge: anEdge ] ]
]

{ #category : #'building - edges' }
GtGraphLayoutExamples >> createEdgeIfNecessaryFrom: fromElement to: toElement [
	^ (self shouldCreateEdgeFrom: fromElement to: toElement)
		ifTrue: [ (self edgeFrom: fromElement to: toElement) ]
]

{ #category : #'building - graph' }
GtGraphLayoutExamples >> createGraph: anAmountOfNodes extent: anExtent pairs: anArrayOfPairs [
	| theNodes |

	theNodes := self nodes: (1 to: anAmountOfNodes) extent: anExtent .

	self connectPairsOfNodes: theNodes pairs: anArrayOfPairs.

	^ BlLayoutParentNodeWithEdges new
		parentNode: (BlLayoutParentNode new
			constraints: (BlLayoutCommonConstraints new);
			extentSpec: (BlExtentMeasurementSpec unspecified));
		children: theNodes
]

{ #category : #'building - graph' }
GtGraphLayoutExamples >> createGraph: anAmountOfNodes pairs: anArrayOfPairs [
	| theNodes |

	theNodes := self nodes: (1 to: anAmountOfNodes).

	self connectPairsOfNodes: theNodes pairs: anArrayOfPairs.

	^ BlLayoutParentNodeWithEdges new
		parentNode: (BlLayoutParentNode new
			constraints: (BlLayoutCommonConstraints new);
			extentSpec: (BlExtentMeasurementSpec unspecified));
		children: theNodes
]

{ #category : #'building - graph' }
GtGraphLayoutExamples >> createNodes: anAmountOfNodes extent: anExtent [
	| theNodes |

	theNodes := self nodes: (1 to: anAmountOfNodes) extent: anExtent.

	^ BlLayoutParentNodeWithEdges new
		parentNode: (BlLayoutParentNode new
			constraints: (BlLayoutCommonConstraints new);
			extentSpec: (BlExtentMeasurementSpec unspecified));
		children: theNodes
]

{ #category : #'initialize-release' }
GtGraphLayoutExamples >> defaultNode [
	^ BlElement new
		background: Color lightGray;
		size: 6@6
]

{ #category : #'initialize-release' }
GtGraphLayoutExamples >> defaultView [
	^ BlElement new
		background: Color blue
]

{ #category : #'building - edges' }
GtGraphLayoutExamples >> edgeFrom: aFromLayoutNode to: aToLayoutNode [
	^ BlLayoutEdge new
		fromNode: aFromLayoutNode;
		toNode: aToLayoutNode
]

{ #category : #accessing }
GtGraphLayoutExamples >> nodeExtent [
	^ 50@20
]

{ #category : #'building - graph' }
GtGraphLayoutExamples >> nodeFor: aModel [
	^ self defaultNode
]

{ #category : #'building - graph' }
GtGraphLayoutExamples >> nodes: aDataCollection [
	^ self
		nodes: aDataCollection
		extent: self nodeExtent
]

{ #category : #'building - graph' }
GtGraphLayoutExamples >> nodes: aDataCollection extent: anExtent [
	^ aDataCollection collect: [ :model |
		| childConstraints child |

		childConstraints := BlLayoutCommonConstraints new.
		childConstraints graph
			beNode;
			model: model.

		child := BlLayoutChildNode new
			constraints: childConstraints;
			measurement: (BlLayoutNodeComputedMeasurement new extent: anExtent).

		child withEdges: #() ]
]

{ #category : #'building - edges' }
GtGraphLayoutExamples >> shouldCreateEdgeFrom: fromElement to: toElement [
	"Return true if an edge has to be created"
	fromElement == toElement ifTrue: [ ^ false ].
	(fromElement isNil or: [ toElement isNil ]) ifTrue: [ ^ false ].
	^ true
]

{ #category : #'building - graph' }
GtGraphLayoutExamples >> view [
	^ self defaultView
		constraintsDo: [ :constraints |
			constraints horizontal fitContent.
			constraints vertical fitContent.
			constraints padding: (BlInsets all: 10) ];
		background: Color white
]
