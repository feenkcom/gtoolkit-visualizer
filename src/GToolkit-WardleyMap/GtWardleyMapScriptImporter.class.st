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
		'sourceCanvasExtent',
		'isNewPipelineSyntax'
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
	"https://onlinewardleymaps.com pipeline's top position is in the middle of its node"
	aMaxYInPixels := aMinYInPixels + self sourcePipelineHeight.
	aMaxY := aMaxYInPixels / self sourceCanvasExtent y.
	
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
	isNewPipelineSyntax ifFalse: [ self estimateInnerNodes ].
	self importEvolves.
	self importNotes.
]

{ #category : #'private - import' }
GtWardleyMapScriptImporter >> importEdges [

	ast allNodesOfType: GtWMLinkNode do: [ :anAstNode | 
		| anEdgeModel aStartName aStopName |
		anEdgeModel := GtWardleyMapEdgeModel new.
		anAstNode start ifNotNil: [ :aToken | aStartName := aToken source ].
		anAstNode end ifNotNil: [ :aToken | aStopName := aToken source ].
		anAstNode comment ifNotNil: [ :aToken | 
			anEdgeModel label: aToken source.
			anEdgeModel isLabelVisible: true ].
		
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
GtWardleyMapScriptImporter >> importEvolves [
	ast
		allNodesOfType: GtWMEvolveNode
		do: [ :anAstNode | 
			| aNameParts aSourceNodeName anEvolveName anAstName |
			anAstName := anAstNode name ifNotNil: #source.
			anAstName
				ifNotNil: [ aNameParts := '->' split: anAstName.
					self
						assert: [ #(1 2) includes: aNameParts size ]
						description: [ 'Evolve name can be with or without one arrow (->): ' format: {anAstName} ].
					aSourceNodeName := aNameParts first trimRight.
					anEvolveName := aNameParts size = 1
							ifTrue: [ aSourceNodeName ]
							ifFalse: [ aNameParts second trimBoth ].
					self
						nodeNamed: aSourceNodeName
						ifFound: [ :aSourceNodeModel | 
							anAstNode maturityNumber
								ifNotNil: [ :aMaturity | 
									aSourceNodeModel evolveModel maturity: aMaturity.
									aSourceNodeModel evolveModel color: GtWardleyMapConstants evolveColor.

									anAstNode label
										ifNotNil: [ :aNode | 
											aNode coordinate
												ifNotNil: [ :aPoint | 
													| aLabelCoordinate |
													aLabelCoordinate := GtWardleyMapUtility
															convertWardleyScriptNodeModel: aSourceNodeModel evolveModel
															labelCoordiante: aPoint.
													aSourceNodeModel evolveModel labelModel coordinate: aLabelCoordinate ] ].

									aSourceNodeModel evolveModel label: anEvolveName ] ]
						ifNone: [  ] ] ]
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
GtWardleyMapScriptImporter >> importNotes [

	ast allNodesOfType: GtWMNoteNode do: [ :anAstNode | 
		| aNoteModel |
		aNoteModel := GtWardleyMapNoteModel new.
		aNoteModel color: Color black.
		anAstNode label ifNotNil: [ :aToken | aNoteModel label: aToken source ].
		anAstNode position ifNotNil: [ :aNode | aNode coordinate 
			ifNotNil: [ :aPoint | aNoteModel coordinate: (aPoint x @ (1 - aPoint y)) ] ].

		wardleyMap addNote: aNoteModel.
	]
]

{ #category : #'private - import' }
GtWardleyMapScriptImporter >> importPipeline: aPipelineNode innerNodes: aPipelineAst [
	| allInnerNodes aMinMaturity aMaxMaturity |
	aPipelineAst elements ifEmpty: [ ^ self ].

	allInnerNodes := aPipelineAst elements
			collect: [ :anAstElement | 
				| aName |
				anAstElement name ifNotNil: [ :aToken | aName := aToken source ].
				aName
					ifNotNil: [ self
							nodeNamed: aName
							ifFound: [ :anElementNode | 
								anElementNode
									coordinate: anAstElement maturityNumber @ (aPipelineNode y) ]
							ifNone: [ nil ] ] ]
			thenReject: #isNil.

	allInnerNodes ifEmpty: [ ^ self ].
	isNewPipelineSyntax := true.
	aPipelineNode innerNodes: allInnerNodes.
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
					aNodeModel isPipelineVisible: true.
					anAstNode coordinate 
						ifNotNil: [ :aPoint | aNodeModel pipelineCoordinate: aPoint ].
					self importPipeline: aNodeModel innerNodes: anAstNode ]
				ifNone: [ ]
		].
	]
]

{ #category : #initialization }
GtWardleyMapScriptImporter >> initialize [
	super initialize.
	isNewPipelineSyntax := false
]

{ #category : #'private - import' }
GtWardleyMapScriptImporter >> nodeNamed: aNodeName ifFound: aFoundBlock ifNone: aNoneBlock [
	wardleyMap nodes reverseDo: [ :eachNodeModel | 
		(eachNodeModel label = aNodeName) 
			ifTrue: [ ^ aFoundBlock value: eachNodeModel ] ].

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
