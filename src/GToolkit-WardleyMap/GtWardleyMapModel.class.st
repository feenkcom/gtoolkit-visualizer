"
#Wardley Map model
Represents a Wardley Map model, see [](https://en.wikipedia.org/wiki/Wardley_map) to learn more about the concept.
A map consists of {{gtClass:GtWardleyMapNodeModel}} that can be connected with {{gtClass:GtWardleyMapEdgeModel}}.
{{gtExample:GtWardleyMapModelExamples>>#newMapWithNodes|codeExpanded=false|previewExpanded=true|previewShow=#gtLiveFor:|previewHeight=200}}
#Visitor
Each model entity that uses {{gtClass:TGtWardleyMapVisitable}} is able to be visited by {{gtClass:TGtWardleyMapVisitor}}. One of the applications is an ability to export a map to various formats such as {{gtClass:Dictionary}} or {{gtClass:STONJSON}}:
{{gtExample:GtWardleyMapModelExamples>>#newMapWithNodes|codeExpanded=false|previewExpanded=true|previewShow=#gtJSONFor:|previewHeight=300}}


"
Class {
	#name : #GtWardleyMapModel,
	#superclass : #Object,
	#traits : 'TGtAnnouncer + TGtWardleyMapExportable + TGtWardleyMapVisitable',
	#classTraits : 'TGtAnnouncer classTrait + TGtWardleyMapExportable classTrait + TGtWardleyMapVisitable classTrait',
	#instVars : [
		'announcer',
		'nodes',
		'edges',
		'sections'
	],
	#category : #'GToolkit-WardleyMap-! Models'
}

{ #category : #comparing }
GtWardleyMapModel >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ nodes = anObject nodes and: [ edges = anObject edges ]
]

{ #category : #visiting }
GtWardleyMapModel >> accept: aWardleyMapVisitor [
	^ aWardleyMapVisitor visitWardleyMap: self
]

{ #category : #'api - edges' }
GtWardleyMapModel >> addEdge: aGtWardleyMapEdgeModel [
	aGtWardleyMapEdgeModel hasParent
		ifTrue: [ GtWardleyMapParentAlreadySetError signal ].

	self
		assert: [ aGtWardleyMapEdgeModel notNil ]
		description: [ 'Edge must not be nil' ].

	self
		assert: [ self hasNode: aGtWardleyMapEdgeModel fromNode ]
		description: [ 'The edge must be from the existing node' ].

	self
		assert: [ self hasNode: aGtWardleyMapEdgeModel toNode ]
		description: [ 'The edge must be from the existing node' ].

	"`self` edges are not permitted"
	aGtWardleyMapEdgeModel fromNode = aGtWardleyMapEdgeModel toNode
		ifTrue: [ ^ self ].

	"only one edges between nodes is allowed"
	(self hasEdgeConnecting: aGtWardleyMapEdgeModel fromNode and: aGtWardleyMapEdgeModel toNode)
		ifTrue: [ ^ self ].

	self edges add: aGtWardleyMapEdgeModel.
	aGtWardleyMapEdgeModel parent: self.
	self announce: (GtWardleyMapEdgeModelAdded new edgeModel: aGtWardleyMapEdgeModel)
]

{ #category : #'api - nodes' }
GtWardleyMapModel >> addNode: aGtWardleyMapNodeModel [
	aGtWardleyMapNodeModel hasParent
		ifTrue: [ GtWardleyMapParentAlreadySetError signal ].

	aGtWardleyMapNodeModel hasId
		ifFalse: [ aGtWardleyMapNodeModel id: self nextUniqueId ]
		ifTrue: [
			(self hasNodeWithId: aGtWardleyMapNodeModel id)
				ifTrue: [ self error: 'Can not add a node with already used id' ]. ].

	nodes add: aGtWardleyMapNodeModel.
	aGtWardleyMapNodeModel parent: self.
	self announce: (GtWardleyMapNodeModelAdded new nodeModel: aGtWardleyMapNodeModel)
]

{ #category : #'api - edges' }
GtWardleyMapModel >> allEdgesConnecting: aWardleyMapNodeModel do: aBlock [
	| theEdges |
	
	theEdges := self edges select: [ :eachEdge | eachEdge fromNode = aWardleyMapNodeModel or: [ eachEdge toNode = aWardleyMapNodeModel ] ].
	theEdges do: aBlock
]

{ #category : #announcer }
GtWardleyMapModel >> announcer [
	<return: #Announcer>

	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #converting }
GtWardleyMapModel >> asWardleyMapScript [
	^ String
		streamContents:
			[ :stream | 
			self nodes
				do:
					[ :eachNode | 
						stream
							nextPutAll: 'component ';
							nextPutAll: eachNode label;
							nextPutAll: ' [ ';
							print: 1 - eachNode y;
							nextPutAll: ', ';
							print: eachNode x;
							nextPutAll: ' ] label [ ';
							print: eachNode labelModel x;
							nextPutAll: ', ';
							print: eachNode labelModel y;
							nextPutAll: ' ]' ;
							cr.
							
						eachNode isPipelineVisible ifTrue: [ 
							stream
								nextPutAll: 'pipeline ';
								nextPutAll: eachNode label;
								nextPutAll: ' [ ';
								print: eachNode pipelineCoordinate x;
								nextPutAll: ', ';
								print: eachNode pipelineCoordinate y;
								nextPutAll: ' ]';
								cr;
								cr.
						]
					].
			stream cr.
			self edges
				do:
					[ :each | 
					stream
						nextPutAll: each fromNode label;
						nextPutAll: '->';
						nextPutAll: each toNode label;
						cr ] ]
]

{ #category : #'api - edges' }
GtWardleyMapModel >> edges [
	^ edges
]

{ #category : #'api - export / import' }
GtWardleyMapModel >> gtJSONFor: aView [
	<gtView>

	^ aView textEditor
		title: 'JSON';
		priority: 8;
		aptitude: [ BrGlamorousCodeEditorAptitude ];
		styler: [ JSONParser gtStyler ];
		text: [ self asJSONForExport ];
		actionUpdateButtonTooltip: 'Update JSON';
		actionButtonLabel: 'Copy'
			action: [ Clipboard clipboardText: self asJSONForExport ]
]

{ #category : #'gt-extensions' }
GtWardleyMapModel >> gtLiveFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Live';
		priority: 2;
		stencil: [
			GtWardleyMapElement new
				wardleyMapViewModel: (GtWardleyMapViewModel new wardleyMapModel: self);
				yourself ]
]

{ #category : #'api - export / import' }
GtWardleyMapModel >> gtWardleyScriptFor: aView [
	<gtView>
	
	^ (aView textEditor)
		title: 'Script';
		priority: 9;
		aptitude: [ BrGlamorousCodeEditorAptitude ];
		styler: [ GtWardleyMapParser gtStyler ];
		text: [ self asWardleyMapScript ];
		actionUpdateButtonTooltip: 'Update Script';
		actionButtonLabel: 'Copy' action: [ Clipboard clipboardText: self asWardleyMapScript ];
		actionButtonLabel: 'AST' tooltip: 'Parse script' action: [ :aButton | 
			aButton phlow spawnObject: (GtWardleyMapParser parse: self asWardleyMapScript) ]
]

{ #category : #testing }
GtWardleyMapModel >> hasEdgeConnecting: aNodeModel and: anotherNodeModel [

	^ self edges anySatisfy: [ :eachEdge |
		(eachEdge fromNode = aNodeModel
			or: [ eachEdge fromNode = anotherNodeModel ])
				and: [ eachEdge toNode = aNodeModel
					or: [ eachEdge toNode = anotherNodeModel ] ] ]
]

{ #category : #testing }
GtWardleyMapModel >> hasNode: aGtWardleyMapNodeModel [
	self
		assert: [ aGtWardleyMapNodeModel notNil ]
		description: [ 'Map node must not be nil' ].
		
	^ self nodes includes: aGtWardleyMapNodeModel
]

{ #category : #testing }
GtWardleyMapModel >> hasNodeWithId: anId [
	^ self
		nodeWithId: anId
		ifFound: [ true ]
		ifNone: [ false ]
]

{ #category : #testing }
GtWardleyMapModel >> hasParent [
	^ false
]

{ #category : #comparing }
GtWardleyMapModel >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ nodes hash bitXor: edges hash
]

{ #category : #initialization }
GtWardleyMapModel >> initialize [
	super initialize.

	nodes := OrderedCollection new.
	edges := OrderedCollection new.
	sections := OrderedCollection new
]

{ #category : #private }
GtWardleyMapModel >> nextUniqueId [
	| aNextId |
	
	aNextId := UUIDGenerator next.
	[
	self
		nodeWithId: aNextId
		ifFound: [ false ]
		ifNone: [ true ] ] whileFalse: [ aNextId := UUIDGenerator next ].

	^ aNextId
]

{ #category : #'api - nodes' }
GtWardleyMapModel >> nodeWithId: anId ifFound: aFoundBlock ifNone: aNoneBlock [
	^ self nodes
		detect: [ :eachNode | eachNode id = anId ]
		ifFound: aFoundBlock
		ifNone: aNoneBlock
]

{ #category : #'api - nodes' }
GtWardleyMapModel >> nodes [
	^ nodes
]

{ #category : #'api - edges' }
GtWardleyMapModel >> removeEdge: aGtWardleyMapEdgeModel [
	self
		assert: [ aGtWardleyMapEdgeModel notNil ]
		description: [ 'Edge must not be nil' ].
		
	self
		assert: [ self hasNode: aGtWardleyMapEdgeModel fromNode ]
		description: [ 'The edge must be from the existing node' ].
		
	self
		assert: [ self hasNode: aGtWardleyMapEdgeModel toNode ]
		description: [ 'The edge must be from the existing node' ].

	self edges remove: aGtWardleyMapEdgeModel ifAbsent: [ ^ self ].
	aGtWardleyMapEdgeModel removeParent.
	self announce: (GtWardleyMapEdgeModelRemoved new edgeModel: aGtWardleyMapEdgeModel)
]

{ #category : #'api - nodes' }
GtWardleyMapModel >> removeNode: aGtWardleyMapNodeModel [

	"before removing a node we should remove all connected edges"	
	self allEdgesConnecting: aGtWardleyMapNodeModel do: [ :eachEdge | self removeEdge: eachEdge ].
	nodes remove: aGtWardleyMapNodeModel ifAbsent: [ ^ self ].
	aGtWardleyMapNodeModel removeParent.
	aGtWardleyMapNodeModel removeFromPipeline.
	aGtWardleyMapNodeModel removeInnerNodes.
	self announce: (GtWardleyMapNodeModelRemoved new nodeModel: aGtWardleyMapNodeModel)
]

{ #category : #printing }
GtWardleyMapModel >> storeOn: aStream [
	aStream
		nextPut: $(;
		nextPutAll:
			'GtWardleyMapFromDictionaryImporter new importWardleyMapFrom: (STONJSON fromString: ';
		nextPutAll: self asJSONForExport storeString;
		nextPutAll: '))'
]
