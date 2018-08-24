Class {
	#name : #GtGraphLayoutExamples,
	#superclass : #Object,
	#category : 'GToolkit-BlocGraph-Layouts-Examples'
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
GtGraphLayoutExamples >> createEdgeIfNecessaryFrom: fromElement to: toElement [
	^ (self shouldCreateEdgeFrom: fromElement to: toElement)
		ifTrue: [ (self edgeFrom: fromElement to: toElement) ]
]

{ #category : #'initialize-release' }
GtGraphLayoutExamples >> defaultNode [
	^ BlElement new
		background: (BlBackground paint: Color lightGray);
		size: 6@6
]

{ #category : #'initialize-release' }
GtGraphLayoutExamples >> defaultView [
	^ BlElement new
		background: (BlBackground paint: Color blue)
]

{ #category : #'building - edges' }
GtGraphLayoutExamples >> edgeFrom: fromElement to: toElement [
	| edge |
	edge := GtGraphEdge new from: fromElement to: toElement.
	fromElement constraints graph addConnectedEdge: edge.
	toElement constraints graph addConnectedEdge: edge.
	^ edge
]

{ #category : #'building - graph' }
GtGraphLayoutExamples >> nodeFor: aModel [
	^ self defaultNode
]

{ #category : #'building - graph' }
GtGraphLayoutExamples >> nodes: aDataCollection [
	^ aDataCollection collect: [ :model |
		| child |
		child := self nodeFor: model.
		child userData at: #model put: model.
		child ]
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
		background: (BlBackground paint: Color white)
]
