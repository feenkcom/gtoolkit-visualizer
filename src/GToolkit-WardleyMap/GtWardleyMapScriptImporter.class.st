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
		'wardleyMap'
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

{ #category : #'api - import' }
GtWardleyMapScriptImporter >> import [
	stream ifNil: [ ^ self ].

	ast := GtWardleyMapParser parseStream: stream.

	wardleyMap := GtWardleyMapModel new.
	
	self importNodes.
	self importPipelines.
	self importEdges.
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
							wardleyMap addEdge: anEdgeModel
						]
						ifNone: [ ] ] 
				ifNone: [ ]
		].
	]
]

{ #category : #'private - import' }
GtWardleyMapScriptImporter >> importNodes [

	ast allNodesOfType: GtWMElementNode do: [ :aAstNode | 
		| aNodeModel |
		aNodeModel := GtWardleyMapNodeModel new.
		aAstNode name ifNotNil: [ :aToken | aNodeModel label: aToken source ].
		aAstNode coords ifNotNil: [ :aNode | aNode coordinate 
			ifNotNil: [ :aPoint | aNodeModel coordinate: (aPoint x @ (1 - aPoint y)) ] ].
		aAstNode label ifNotNil: [ :aNode | aNode coordinate 
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

	ast allNodesOfType: GtWMPipelineNode do: [ :aAstNode | 
		| aPipelineName |
		aAstNode name ifNotNil: [ :aToken | aPipelineName := aToken source ].
		
		aPipelineName ifNotNil: [ 
			self
				nodeNamed: aPipelineName
				ifFound: [ :aNodeModel | 
					aAstNode coordinate ifNotNil: [ :aPoint | 
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

{ #category : #'api - initialization' }
GtWardleyMapScriptImporter >> stream: anObject [
	stream := anObject
]

{ #category : #accessing }
GtWardleyMapScriptImporter >> wardleyMap [
	^ wardleyMap
]
