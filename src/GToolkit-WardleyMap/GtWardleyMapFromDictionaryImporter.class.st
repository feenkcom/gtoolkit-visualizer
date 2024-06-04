Class {
	#name : #GtWardleyMapFromDictionaryImporter,
	#superclass : #Object,
	#category : #'GToolkit-WardleyMap-Exporter/Importer'
}

{ #category : #'api - import' }
GtWardleyMapFromDictionaryImporter class >> importMapFromJSONString: aString [
	^ self new importWardleyMapFrom: (STONJSON fromString: aString)
]

{ #category : #'api - importer' }
GtWardleyMapFromDictionaryImporter >> connectWardleyMapNodePipelines: theMapNodes from: theNodeDictionaries [ 

	theMapNodes withIndexDo: [ :eachPipelineNode :anIndex |
		eachPipelineNode isPipelineVisible ifTrue: [ 
			| aNodeDictionary |
			aNodeDictionary := theNodeDictionaries at: anIndex.
			aNodeDictionary 
				at: #pipeline 
				ifPresent: [ :aPipelineDictionary | 
					aPipelineDictionary 
						at: #inner_nodes
						ifPresent: [ :theInnerNodeIds | 
							| theInnerNodes |
							theInnerNodes := theInnerNodeIds 
								collect: [ :eachInnerNodeId | 
									| anId | 
									anId := self importIdFrom: eachInnerNodeId.
									theMapNodes 
										detect: [ :otherNode | 
											otherNode id = anId and: [ 
												otherNode isPipelineVisible not ] ]
										ifNone: [ nil ] ]
								thenReject: #isNil.
							eachPipelineNode innerNodes: theInnerNodes
						]
				]
		]
	]
]

{ #category : #'api - importer' }
GtWardleyMapFromDictionaryImporter >> importColorFrom: aDictionary [
	| aRed aGreen aBlue anAlpha |
	
	aRed := aDictionary at: #red ifAbsent: [ 0 ].
	aGreen := aDictionary at: #green ifAbsent: [ 0 ].
	aBlue := aDictionary at: #blue ifAbsent: [ 0 ].
	anAlpha := aDictionary at: #alpha ifAbsent: [ 1 ].
	
	^ Color r: aRed g: aGreen b: aBlue alpha: anAlpha
]

{ #category : #'api - importer' }
GtWardleyMapFromDictionaryImporter >> importIdFrom: aString [
	^ UUID fromString: aString
]

{ #category : #'api - importer' }
GtWardleyMapFromDictionaryImporter >> importLegacyEvolveNodeFrom: aDictionary to: aWardleyMapNode [
	aWardleyMapNode isEvolveVisible: true.

	aDictionary
		at: #color
		ifPresent: [ :aColorDictionary | 
			aWardleyMapNode evolveModel color: (self importColorFrom: aColorDictionary) ].

	aDictionary at: #x ifPresent: [ :anX | aWardleyMapNode evolveModel maturity: anX ].
	aDictionary at: #width ifPresent: [ :aWidth | aWardleyMapNode evolveModel width: aWidth ].
	aDictionary at: #height ifPresent: [ :aHeight | aWardleyMapNode evolveModel height: aHeight ].

	aDictionary
		at: #label
		ifPresent: [ :aLabelDictionary | aWardleyMapNode evolveModel labelModel: (self importWardleyMapNodeLabelFrom: aLabelDictionary) ].
]

{ #category : #'api - importer' }
GtWardleyMapFromDictionaryImporter >> importLegacyEvolveNodesFrom: theNodeDictionaries to: theMapNodes [ 
	theNodeDictionaries do: [ :aNodeDictionary |
		(self isEvolveNodeDictionary: aNodeDictionary) ifTrue: [ 
			aNodeDictionary
				at: #evolve 
				ifPresent: [ :anEvolveDictionary | 
					anEvolveDictionary
						at: #source_node
						ifPresent: [ :aSourceNodeId | 
							| anId | 
							anId := self importIdFrom: aSourceNodeId.
							theMapNodes
								detect: [ :otherNode | 
									otherNode id = anId ]
								ifFound: [ :aSourceNode | 
									self importLegacyEvolveNodeFrom: aNodeDictionary to: aSourceNode ]
								ifNone: [ ]
						]
				]
		]
	].
]

{ #category : #'api - importer' }
GtWardleyMapFromDictionaryImporter >> importWardleyMapEdgeFrom: aDictionary [
	| aWardleyMapEdge |

	aWardleyMapEdge := GtWardleyMapEdgeModel new.

	aDictionary
		at: #color
		ifPresent: [ :aColorDictionary | aWardleyMapEdge color: (self importColorFrom: aColorDictionary) ].

	aDictionary at: #width ifPresent: [ :aWidth | aWardleyMapEdge width: aWidth ].
	aDictionary at: #arrow ifPresent: [ :anArrow | aWardleyMapEdge arrow: anArrow ].
	
	aDictionary
		at: #label
		ifPresent: [ :aLabelDictionary | 
			aWardleyMapEdge labelModel: (self importWardleyMapEdgeLabelFrom: aLabelDictionary) ].
		
	^ aWardleyMapEdge
]

{ #category : #'api - importer' }
GtWardleyMapFromDictionaryImporter >> importWardleyMapEdgeFrom: aDictionary map: aWardleyMap [
	| aWardleyMapEdge |

	aWardleyMapEdge := self importWardleyMapEdgeFrom: aDictionary.

	aDictionary
		at: #from
		ifPresent: [ :aFromId |
			aWardleyMap
				nodeWithId: (self importIdFrom: aFromId)
				ifFound: [ :aFromNode |
					aWardleyMapEdge fromNode: aFromNode ]
				ifNone: [  ] ].

	aDictionary
		at: #to
		ifPresent: [ :aToId |
			aWardleyMap
				nodeWithId: (self importIdFrom: aToId)
				ifFound: [ :aToNode | aWardleyMapEdge toNode: aToNode ]
				ifNone: [ 
					"It is a legacy edge to an evolve node
					which we do not import as a standalone node,
					therefore do not import it."
					^ nil ] ].
	
	^ aWardleyMapEdge
]

{ #category : #'api - importer' }
GtWardleyMapFromDictionaryImporter >> importWardleyMapEdgeLabelFrom: aDictionary [
	| aWardleyMapEdgeLabel |
	
	aWardleyMapEdgeLabel := GtWardleyMapEdgeLabelModel new.
	
	aDictionary at: #x ifPresent: [ :anX | aWardleyMapEdgeLabel x: anX ].
	aDictionary at: #y ifPresent: [ :anY | aWardleyMapEdgeLabel y: anY ].
	aDictionary at: #text ifPresent: [ :aText | aWardleyMapEdgeLabel label: aText ].
	aDictionary at: #is_visible ifPresent: [ :aBoolean | aWardleyMapEdgeLabel isVisible: aBoolean ].

	^ aWardleyMapEdgeLabel
]

{ #category : #'api - importer' }
GtWardleyMapFromDictionaryImporter >> importWardleyMapEvolveFrom: aDictionary [
	| aWardleyMapEvolve |
	
	aWardleyMapEvolve := GtWardleyMapNodeEvolveModel new.
	
	aDictionary at: #maturity ifPresent: [ :aMaturity | aWardleyMapEvolve maturity: aMaturity ].
	aDictionary at: #width ifPresent: [ :aWidth | aWardleyMapEvolve width: aWidth ].
	aDictionary at: #height ifPresent: [ :aHeight | aWardleyMapEvolve height: aHeight ].
	aDictionary
		at: #color
		ifPresent: [ :aColorDictionary | 
			aWardleyMapEvolve color: (self importColorFrom: aColorDictionary) ].
	
	aDictionary
		at: #label
		ifPresent: [ :aLabelDictionary | aWardleyMapEvolve labelModel: (self importWardleyMapEvolveLabelFrom: aLabelDictionary) ].

	^ aWardleyMapEvolve
]

{ #category : #'api - importer' }
GtWardleyMapFromDictionaryImporter >> importWardleyMapEvolveLabelFrom: aDictionary [
	| aWardleyMapEvolveLabel |
	
	aWardleyMapEvolveLabel := GtWardleyMapEvolveLabelModel new.
	
	self importWardleyMapNodeLabelFrom: aDictionary to: aWardleyMapEvolveLabel.
	aDictionary at: #is_visible ifPresent: [ :aBoolean | aWardleyMapEvolveLabel isVisible: aBoolean ].

	^ aWardleyMapEvolveLabel
]

{ #category : #'api - importer' }
GtWardleyMapFromDictionaryImporter >> importWardleyMapFrom: aDictionary [
	| aWardleyMap |
	aWardleyMap := GtWardleyMapModel new.
	aDictionary
		at: #notes
		ifPresent: [ :theNoteDictionaries | 
			theNoteDictionaries
				do: [ :eachNoteDictionary | aWardleyMap addNote: (self importWardleyMapNoteFrom: eachNoteDictionary) ] ].

	aDictionary
		at: #nodes
		ifPresent: [ :theNodeDictionaries | 
			theNodeDictionaries
				do: [ :eachNodeDictionary | 
					(self importWardleyMapNodeFrom: eachNodeDictionary)
						ifNotNil: [ :aNode | aWardleyMap addNode: aNode ] ].

			self
				connectWardleyMapNodePipelines: aWardleyMap nodes
				from: theNodeDictionaries.
			self importLegacyEvolveNodesFrom: theNodeDictionaries to: aWardleyMap nodes ].

	aDictionary
		at: #edges
		ifPresent: [ :theEdgeDictionaries | 
			theEdgeDictionaries
				do: [ :eachEdgeDictionary | 
					(self importWardleyMapEdgeFrom: eachEdgeDictionary map: aWardleyMap) 
						ifNotNil: [ :anEdge |
							aWardleyMap addEdge: anEdge ] ] ].

	^ aWardleyMap
]

{ #category : #'api - importer' }
GtWardleyMapFromDictionaryImporter >> importWardleyMapNodeFrom: aDictionary [
	| aWardleyMapNode |

	"A legacy form of storing evolve information.
	We skip such nodes here and import the evolve information later."
	(self isEvolveNodeDictionary: aDictionary) ifTrue: [ ^ nil ].
	
	aWardleyMapNode := GtWardleyMapNodeModel new.
	aDictionary
		at: #id
		ifPresent: [ :anId | aWardleyMapNode id: (self importIdFrom: anId) ].

	aDictionary
		at: #color
		ifPresent: [ :aColorDictionary | 
			aWardleyMapNode color: (self importColorFrom: aColorDictionary) ].

	aDictionary at: #x ifPresent: [ :anX | aWardleyMapNode x: anX ].
	aDictionary at: #y ifPresent: [ :anY | aWardleyMapNode y: anY ].
	aDictionary at: #width ifPresent: [ :aWidth | aWardleyMapNode width: aWidth ].
	aDictionary at: #height ifPresent: [ :aHeight | aWardleyMapNode height: aHeight ].

	aDictionary
		at: #label
		ifPresent: [ :aLabelDictionary | aWardleyMapNode labelModel: (self importWardleyMapNodeLabelFrom: aLabelDictionary) ].
		
	aDictionary
		at: #pipeline
		ifPresent: [ :aPipelineDictionary | 
			aPipelineDictionary 
				at: #is_visible 
				ifPresent: [ :aValue | aWardleyMapNode isPipelineVisible: aValue ].
			aPipelineDictionary 
				at: #x 
				ifPresent: [ :aXValue | 
					aPipelineDictionary 
					at: #y 
					ifPresent: [ :aYValue | aWardleyMapNode pipelineCoordinate: aXValue @ aYValue ] ] ].
					
	aDictionary
		at: #evolve
		ifPresent: [ :anEvolveDictionary | 
			anEvolveDictionary 
				at: #is_visible 
				ifPresent: [ :aBoolean | aWardleyMapNode isEvolveVisible: aBoolean ].
			aWardleyMapNode evolveModel: (self importWardleyMapEvolveFrom: anEvolveDictionary) ].

	^ aWardleyMapNode
]

{ #category : #'api - importer' }
GtWardleyMapFromDictionaryImporter >> importWardleyMapNodeLabelFrom: aDictionary [
	| aWardleyMapNodeLabel |
	aWardleyMapNodeLabel := GtWardleyMapNodeLabelModel new.
	
	self importWardleyMapNodeLabelFrom: aDictionary to: aWardleyMapNodeLabel.
	
	^ aWardleyMapNodeLabel
]

{ #category : #private }
GtWardleyMapFromDictionaryImporter >> importWardleyMapNodeLabelFrom: aDictionary to: aWardleyMapNodeLabel [
	aDictionary at: #x ifPresent: [ :anX | aWardleyMapNodeLabel x: anX ].
	aDictionary at: #y ifPresent: [ :anY | aWardleyMapNodeLabel y: anY ].
	aDictionary at: #text ifPresent: [ :aText | aWardleyMapNodeLabel label: aText ]
]

{ #category : #'api - importer' }
GtWardleyMapFromDictionaryImporter >> importWardleyMapNoteFrom: aDictionary [
	| aWardleyMapNote |

	aWardleyMapNote := GtWardleyMapNoteModel new.
	aDictionary
		at: #id
		ifPresent: [ :anId | aWardleyMapNote id: (self importIdFrom: anId) ].

	aDictionary
		at: #color
		ifPresent: [ :aColorDictionary | 
			aWardleyMapNote color: (self importColorFrom: aColorDictionary) ].

	aDictionary at: #x ifPresent: [ :anX | aWardleyMapNote x: anX ].
	aDictionary at: #y ifPresent: [ :anY | aWardleyMapNote y: anY ].

	aDictionary
		at: #label
		ifPresent: [ :aLabel | aWardleyMapNote label: aLabel ].
	
	^ aWardleyMapNote
]

{ #category : #'api - importer' }
GtWardleyMapFromDictionaryImporter >> isEvolveNodeDictionary: aDictionary [ 
	aDictionary 
		at: #evolve 
		ifPresent: [ :anEvolveDictionary |
			anEvolveDictionary 
				at: #is_evolve_target 
				ifPresent: [ :aBoolean |
					^ aBoolean ] ].
					
	^ false
]
