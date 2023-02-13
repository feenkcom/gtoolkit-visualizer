"
I know how to import Wardley script into the wardley model represented by {{gtClass: GtWardleyMapModel}}.
#Example
The original model: {{gtExample: GtWardleyMapScriptImporterExamples >> #importScript | noCode | previewHeight=450 | previewShow=#gtOriginalWarldeyMapLiveFor:}}
can be exported to the Wardley script: {{gtExample: GtWardleyMapScriptImporterExamples >> #importScript | noCode | previewHeight=220 | previewShow=#gtOriginalWardleyScriptFor:}}
The Wardley script then can be imported to the model (some model properties, e.g., colors, are not stored in the Wardley script): {{gtExample: GtWardleyMapScriptImporterExamples >> #importScript | noCode | previewHeight=450 | previewShow=#gtImportedWarldeyMapLiveFor:}}
"
Class {
	#name : #GtWardleyMapScriptImporter,
	#superclass : #Object,
	#instVars : [
		'stream',
		'ast',
		'wardleyMap',
		'sourcePipelineHeight',
		'sourceCanvasExtent'
	],
	#category : #'GToolkit-WardleyMap-Exporter/Importer'
}

{ #category : #'api - import' }
GtWardleyMapScriptImporter class >> forStream: aStream [
	^ self new
		stream: aStream;
		import;
		wardleyMap
]

{ #category : #'api - import' }
GtWardleyMapScriptImporter class >> forString: aString [
	^ self forStream: aString readStream
]

{ #category : #'private - import' }
GtWardleyMapScriptImporter >> estimateInnerNodes [

	wardleyMap nodes do: [ :aPipelineNode | 
		aPipelineNode isPipelineVisible ifTrue: [ 
			self estimateInnerNodesFor: aPipelineNode
		]
	]
]

{ #category : #'private - import' }
GtWardleyMapScriptImporter >> estimateInnerNodesFor: aPipelineNode [ 

	| estimatedInnerNodes |
	estimatedInnerNodes := self 
		estimateInnerNodesFor: aPipelineNode 
		among: wardleyMap nodes.
		
	estimatedInnerNodes ifNotEmpty: [
		aPipelineNode innerNodes: estimatedInnerNodes ].
]

{ #category : #'private - import' }
GtWardleyMapScriptImporter >> estimateInnerNodesFor: aPipelineNode among: allNodes [
	"All nodes still have their imported coordinates.
	All pipelines have their imported left and right coordinates."

	| candidateNodes aMinX aMaxX aMinY aMaxY aPipelineBounds aMinYInPixels aMaxYInPixels |
	aPipelineNode isPipelineVisible ifFalse: [ ^ #() ].

	candidateNodes := allNodes select: [ :eachNode | 
		eachNode isPipelineVisible not and: [ 
			eachNode pipelineNode isNil and: [
				(eachNode == aPipelineNode) not ] ] ].
			
	candidateNodes ifEmpty: [ ^ #() ].
			
	aMinX := aPipelineNode pipelineCoordinate x.
	aMaxX := aPipelineNode pipelineCoordinate y.
	
	aMinY := aPipelineNode coordinate y.
	aMinYInPixels := aMinY * self sourceCanvasExtent y.
	aMaxYInPixels := aMinYInPixels 
		+ (GtWardleyMapUtility
			computePipelineModelVerticalTopOffset: aPipelineNode)
		+ self sourcePipelineHeight.
	aMaxY := aMinY + (aMaxYInPixels / self sourceCanvasExtent y).
	
	aPipelineBounds := (aMinX @ aMinY) corner: (aMaxX @ aMaxY).
			
	^ candidateNodes select: [ :eachNode | 
		(aPipelineBounds containsPoint: eachNode coordinate) ].
]

{ #category : #'api - import' }
GtWardleyMapScriptImporter >> import [
	stream ifNil: [ ^ self ].

	ast := GtWardleyMapParser parseStream: stream.

	wardleyMap := GtWardleyMapModel new.
	
	self importMap.
	self importNodes.
	self importPipelines.
	self importEdges.
	self estimateInnerNodes.
]

{ #category : #'private - import' }
GtWardleyMapScriptImporter >> importEdges [

	ast allNodesOfType: GtWMLinkNode do: [ :anAstNode | 
		| anEdgeModel aStartName aStopName |
		anEdgeModel := GtWardleyMapEdgeModel new.
		anAstNode start ifNotNil: [ :aToken | aStartName := aToken source ].
		anAstNode end ifNotNil: [ :aToken | aStopName := aToken source ].
		
		(aStartName isNotNil and: [ aStopName isNotNil ]) ifTrue: [ 
			self 
				nodeNamed: aStartName 
				ifFound: [ :aStartNode | 
					self 
						nodeNamed: aStopName 
						ifFound: [ :aStopNode | 
							anEdgeModel fromNode: aStartNode.
							anEdgeModel toNode: aStopNode.
							anEdgeModel color: aStartNode color.
							wardleyMap addEdge: anEdgeModel
						]
						ifNone: [ ] ] 
				ifNone: [ ]
		].
	]
]

{ #category : #'private - import' }
GtWardleyMapScriptImporter >> importMap [
	ast allNodesOfType: GtWMTitleNode do: [ :anAstNode | 
		| aName |
		aName := anAstNode name ifNotNil: #source.
		aName ifNotNil: [ 
			wardleyMap title: aName ] ]
]

{ #category : #'private - import' }
GtWardleyMapScriptImporter >> importNodes [

	ast allNodesOfType: GtWMElementNode do: [ :anAstNode | 
		| aNodeModel |
		aNodeModel := GtWardleyMapNodeModel new.
		aNodeModel color: Color black.
		anAstNode name ifNotNil: [ :aToken | aNodeModel label: aToken source ].
		anAstNode coords ifNotNil: [ :aNode | aNode coordinate 
			ifNotNil: [ :aPoint | aNodeModel coordinate: (aPoint x @ (1 - aPoint y)) ] ].
		anAstNode label ifNotNil: [ :aNode | aNode coordinate 
			ifNotNil: [ :aPoint | 
				| aLabelCoordinate |
				aLabelCoordinate := GtWardleyMapUtility 
					convertWardleyScriptNodeModel: aNodeModel 
					labelCoordiante: aPoint.
				aNodeModel labelModel coordinate: aLabelCoordinate ] ].

		wardleyMap addNode: aNodeModel.
	]
]

{ #category : #'private - import' }
GtWardleyMapScriptImporter >> importPipelines [

	ast allNodesOfType: GtWMPipelineNode do: [ :anAstNode | 
		| aPipelineName |
		anAstNode name ifNotNil: [ :aToken | aPipelineName := aToken source ].
		
		aPipelineName ifNotNil: [ 
			self
				nodeNamed: aPipelineName
				ifFound: [ :aNodeModel | 
					anAstNode coordinate ifNotNil: [ :aPoint | 
						aNodeModel pipelineCoordinate: aPoint.
						aNodeModel isPipelineVisible: true ] ]
				ifNone: [ ]
		].
	]
]

{ #category : #'private - import' }
GtWardleyMapScriptImporter >> nodeNamed: aNodeName ifFound: aFoundBlock ifNone: aNoneBlock [
	wardleyMap nodes reverseDo: [ :eachNodeModel | 
		eachNodeModel label = aNodeName ifTrue: [ 
			^ aFoundBlock value: eachNodeModel ] ].

	^ aNoneBlock value
]

{ #category : #accessing }
GtWardleyMapScriptImporter >> sourceCanvasExtent [
	^ sourceCanvasExtent ifNil: [ sourceCanvasExtent := GtWardleyMapConstants externalCanvasExtent ]
]

{ #category : #accessing }
GtWardleyMapScriptImporter >> sourceCanvasExtent: anObject [
	sourceCanvasExtent := anObject
]

{ #category : #accessing }
GtWardleyMapScriptImporter >> sourcePipelineHeight [
	^ sourcePipelineHeight ifNil: [ sourcePipelineHeight := GtWardleyMapConstants externalPipelineHeight ]
]

{ #category : #accessing }
GtWardleyMapScriptImporter >> sourcePipelineHeight: anObject [
	sourcePipelineHeight := anObject
]

{ #category : #'api - initialization' }
GtWardleyMapScriptImporter >> stream: anObject [
	stream := anObject
]

{ #category : #accessing }
GtWardleyMapScriptImporter >> wardleyMap [
	^ wardleyMap
]
