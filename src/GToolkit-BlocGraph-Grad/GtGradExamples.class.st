Class {
	#name : #GtGradExamples,
	#superclass : #Object,
	#category : #'GToolkit-BlocGraph-Grad-Examples'
}

{ #category : #'building - graph' }
GtGradExamples >> connect: nodes from: aBlockOrASymbol [
	^ self connect: nodes from: aBlockOrASymbol to: #yourself
]

{ #category : #'building - graph' }
GtGradExamples >> connect: nodes from: aFromBlock to: aBlockOrSymbol [

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

{ #category : #'building - graph' }
GtGradExamples >> connectNodesFrom: fromNode to: toNode [

	^ self createEdgeIfNecessaryFrom: fromNode to: toNode

]

{ #category : #'building - graph' }
GtGradExamples >> connectPairsOfNodes: nodes pairs: pairsOfNodes [
	^ pairsOfNodes collect: [ :aPair |
		| fromNode toNode anEdge |
		fromNode := nodes at: aPair key.
		toNode := nodes at: aPair value.
		
		anEdge := self edgeFrom: fromNode to: toNode.
		
		fromNode addConnectedEdge: anEdge.
		toNode addConnectedEdge: anEdge.
		
		anEdge ]
]

{ #category : #'building - edges' }
GtGradExamples >> createEdgeIfNecessaryFrom: fromLayoutNode to: toLayoutNode [
	^ (self shouldCreateEdgeFrom: fromLayoutNode to: toLayoutNode)
		ifTrue: [ (self edgeFrom: fromLayoutNode to: toLayoutNode) ]
]

{ #category : #'examples - instance creation' }
GtGradExamples >> createGraph: anAmountOfNodes pairs: anArrayOfPairs [
	^ self
		createGraph: anAmountOfNodes
		pairs: anArrayOfPairs
		scaled: #()
]

{ #category : #'examples - instance creation' }
GtGradExamples >> createGraph: anAmountOfNodes pairs: anArrayOfPairs scaled: aCollectionOfScaledNodes [
	| theNodes |

	theNodes := self nodes: (1 to: anAmountOfNodes) scaled: aCollectionOfScaledNodes.

	self connectPairsOfNodes: theNodes pairs: anArrayOfPairs.

	^ BlLayoutParentNodeWithEdges new
		parentNode: (BlLayoutParentNode new
			constraints: (BlLayoutCommonConstraints new);
			extentSpec: (BlExtentMeasurementSpec unspecified));
		children: theNodes
]

{ #category : #'examples - instance creation' }
GtGradExamples >> defaultNode [

	^ self rectangle
]

{ #category : #'building - edges' }
GtGradExamples >> edgeFrom: aFromLayoutNode to: aToLayoutNode [
	^ BlLayoutEdge new
		fromNode: aFromLayoutNode;
		toNode: aToLayoutNode
]

{ #category : #accessing }
GtGradExamples >> nodeExtent [
	^ 50@20
]

{ #category : #'building - graph' }
GtGradExamples >> nodeFor: aModel [
	^ self defaultNode
]

{ #category : #'building - graph' }
GtGradExamples >> nodes: aDataCollection [
	^ self
		nodes: aDataCollection
		extent: self nodeExtent
]

{ #category : #'building - graph' }
GtGradExamples >> nodes: aDataCollection extent: anExtent [
	^ self
		nodes: aDataCollection
		extent: anExtent
		scaled: #()
]

{ #category : #'building - graph' }
GtGradExamples >> nodes: aDataCollection extent: anExtent scaled: aCollectionOfScaledNodes [
	^ aDataCollection collectWithIndex: [ :model :eachIndex |
		| childConstraints child aScale |

		childConstraints := BlLayoutCommonConstraints new.
		childConstraints graph
			beNode;
			model: model.

		child := BlLayoutChildNode new
			constraints: childConstraints;
			measurement: (BlLayoutNodeComputedMeasurement new extent: anExtent).
			
		child userData at: #label put: eachIndex asString.
		
		aScale := aCollectionOfScaledNodes
			detect: [ :assoc | assoc key = eachIndex ]
			ifFound: [ :assoc | assoc value ]
			ifNone: [ nil ].
		
		(aScale 
			ifNotNil: [ :scale | (child withTransformation: (BlElementTransformation scale: scale)) ]
			ifNil: [ child ]) withEdges: #() ]
]

{ #category : #'building - graph' }
GtGradExamples >> nodes: aDataCollection scaled: aCollectionOfScaledNodes [
	^ self
		nodes: aDataCollection
		extent: self nodeExtent
		scaled: aCollectionOfScaledNodes
]

{ #category : #accessing }
GtGradExamples >> rectangle [
	<gtExample>

	^ BlElement new
		background: (Color gray alpha: 0.5);
		border: (BlBorder builder width: 1; paint: Color black) build;
		size: self nodeExtent
]

{ #category : #'building - edges' }
GtGradExamples >> shouldCreateEdgeFrom: fromElement to: toElement [
	"Return true if an edge has to be created"
	fromElement == toElement ifTrue: [ ^ false ].
	(fromElement isNil or: [ toElement isNil ]) ifTrue: [ ^ false ].
	^ true
]
