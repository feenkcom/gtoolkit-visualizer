Class {
	#name : #GtGradExamples,
	#superclass : #Object,
	#category : 'GToolkit-BlocGraph-Grad-Examples'
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
		| fromNode toNode |
		fromNode := nodes at: aPair key.
		toNode := nodes at: aPair value.
		self connectNodesFrom: fromNode to: toNode.
	]


]

{ #category : #'building - edges' }
GtGradExamples >> createEdgeIfNecessaryFrom: fromElement to: toElement [
	^ (self shouldCreateEdgeFrom: fromElement to: toElement)
		ifTrue: [ (self edgeFrom: fromElement to: toElement) ]
]

{ #category : #'examples - instance creation' }
GtGradExamples >> defaultNode [

	^ self rectangle
]

{ #category : #'building - edges' }
GtGradExamples >> edgeFrom: fromElement to: toElement [
	| edge |
	edge := GtGraphEdge new from: fromElement to: toElement.
	fromElement constraints graph addConnectedEdge: edge.
	toElement constraints graph addConnectedEdge: edge.
	^ edge
]

{ #category : #accessing }
GtGradExamples >> nodeExtent [
	^ 30@30
]

{ #category : #'building - graph' }
GtGradExamples >> nodeFor: aModel [
	^ self defaultNode
]

{ #category : #'building - graph' }
GtGradExamples >> nodes: aDataCollection [
	^ aDataCollection collect: [ :model |
		| child |
		child := self nodeFor: model.
		child userData at: #model put: model.
		
		child graph beNode.
		child ]
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
