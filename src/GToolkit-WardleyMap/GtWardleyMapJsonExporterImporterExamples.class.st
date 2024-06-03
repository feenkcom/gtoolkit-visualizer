Class {
	#name : #GtWardleyMapJsonExporterImporterExamples,
	#superclass : #Object,
	#category : #'GToolkit-WardleyMap-Examples'
}

{ #category : #export }
GtWardleyMapJsonExporterImporterExamples >> exportWardleyMapAsDictionary [
	<gtExample>
	| aWardleyMap anExportedDictionary aFirstNodeDictionary aFirstNodeLabelDictionary aSecondNodeDictionary anEdgeDictionary aFirstNodePipelineDictionary |

	aWardleyMap := GtWardleyMapModelExamples new newMapWithNodes.
	anExportedDictionary := aWardleyMap accept: GtWardleyMapAsDictionaryExporter new.

	self assert: anExportedDictionary size equals: 2.
	self assert: (anExportedDictionary includesKey: #nodes).
	self assert: (anExportedDictionary includesKey: #edges).
	
	self assert: (anExportedDictionary at: #nodes) size equals: 3.
	
	aFirstNodeDictionary := (anExportedDictionary at: #nodes) at: 1.
	self assert: aFirstNodeDictionary size equals: 9.
	self assert: (aFirstNodeDictionary at: #x) equals: 0.25.
	self assert: (aFirstNodeDictionary at: #y) equals: 0.75.
	self assert: (aFirstNodeDictionary at: #width) equals: 12.
	self assert: (aFirstNodeDictionary at: #height) equals: 12.

	aFirstNodeLabelDictionary := aFirstNodeDictionary at: #label.
	self assert: aFirstNodeLabelDictionary size equals: 3.
	self assert: (aFirstNodeLabelDictionary at: #x) equals: 0.5.
	self assert: (aFirstNodeLabelDictionary at: #y) equals: 2.0.
	self assert: (aFirstNodeLabelDictionary at: #text) equals: 'Node A'.
	
	aFirstNodePipelineDictionary := aFirstNodeDictionary at: #pipeline.
	self assert: aFirstNodePipelineDictionary size equals: 1.
	self assert: (aFirstNodePipelineDictionary at: #is_visible) equals:false.

	aSecondNodeDictionary := (anExportedDictionary at: #nodes) at: 2.
	self assert: aSecondNodeDictionary size equals: 9.
	self assert: (aSecondNodeDictionary at: #x) equals: 0.5.
	self assert: (aSecondNodeDictionary at: #y) equals: 0.25.
	self assert: (aSecondNodeDictionary at: #width) equals: 12.
	self assert: (aSecondNodeDictionary at: #height) equals: 12.

	self assert: (anExportedDictionary at: #edges) size equals: 1.
	anEdgeDictionary := (anExportedDictionary at: #edges) at: 1.
	self assert: (anEdgeDictionary at: #from) equals: (aFirstNodeDictionary at: #id).
	self assert: (anEdgeDictionary at: #to) equals: (aSecondNodeDictionary at: #id).
	self assert: (anEdgeDictionary at: #width) equals: 2.
	self assert: (anEdgeDictionary at: #arrow) equals: true.
	
	^ aWardleyMap -> anExportedDictionary
]

{ #category : #export }
GtWardleyMapJsonExporterImporterExamples >> exportWardleyMapWithPipelineInnerNodesAsDictionary [
	<gtExample>
	| aWardleyMap anExportedDictionary aFirstNodeDictionary aFirstNodeLabelDictionary aSecondNodeDictionary anEdgeDictionary aFirstNodePipelineDictionary aFirstNodePipelineInnerNodesArray aFourthNodeDictionary aFifthNodeDictionary aSecondNodePipelineDictionary aNoteADictionary |

	aWardleyMap := GtWardleyMapModelExamples new newMapWithPipelineInnerNodes.
	anExportedDictionary := aWardleyMap accept: GtWardleyMapAsDictionaryExporter new.

	self assert: anExportedDictionary size equals: 3.
	self assert: (anExportedDictionary includesKey: #notes).
	self assert: (anExportedDictionary includesKey: #nodes).
	self assert: (anExportedDictionary includesKey: #edges).
	
	self assert: (anExportedDictionary at: #notes) size equals: 1.
	self assert: (anExportedDictionary at: #nodes) size equals: 7.
	
	aNoteADictionary := (anExportedDictionary at: #notes) at: 1.
	self assert: aNoteADictionary size equals: 5.
	self assert: (aNoteADictionary at: #x) equals: 0.47.
	self assert: (aNoteADictionary at: #y) equals: 0.4.
	self assert: (aNoteADictionary at: #label) equals: 'Note A'.
	self assert: (aNoteADictionary at: #color) size equals: 4.
	self assert: ((aNoteADictionary at: #color) at: #green) equals: Color lightOrange green.
	self assert: ((aNoteADictionary at: #color) at: #blue) equals: Color lightOrange blue.
	self assert: ((aNoteADictionary at: #color) at: #red) equals: Color lightOrange red.
	self assert: ((aNoteADictionary at: #color) at: #alpha) equals: Color lightOrange alpha.
	
	aFirstNodeDictionary := (anExportedDictionary at: #nodes) at: 1.
	self assert: aFirstNodeDictionary size equals: 9.
	self assert: (aFirstNodeDictionary at: #x) equals: 0.25.
	self assert: (aFirstNodeDictionary at: #y) equals: 0.75.
	self assert: (aFirstNodeDictionary at: #width) equals: 12.
	self assert: (aFirstNodeDictionary at: #height) equals: 12.
	self assert: (aFirstNodeDictionary at: #color) size equals: 4.
	self assert: ((aFirstNodeDictionary at: #color) at: #green) equals: Color gray green.
	self assert: ((aFirstNodeDictionary at: #color) at: #blue) equals: Color gray blue.
	self assert: ((aFirstNodeDictionary at: #color) at: #red) equals: Color gray red.
	self assert: ((aFirstNodeDictionary at: #color) at: #alpha) equals: Color gray alpha.

	aFirstNodeLabelDictionary := aFirstNodeDictionary at: #label.
	self assert: aFirstNodeLabelDictionary size equals: 3.
	self assert: (aFirstNodeLabelDictionary at: #x) equals: -1.5.
	self assert: (aFirstNodeLabelDictionary at: #y) equals: -1.5.
	self assert: (aFirstNodeLabelDictionary at: #text) equals: 'Node A'.
	
	aFirstNodePipelineDictionary := aFirstNodeDictionary at: #pipeline.
	self assert: aFirstNodePipelineDictionary size equals: 4.
	self assert: (aFirstNodePipelineDictionary at: #is_visible) equals:true.
	self assert: ((aFirstNodePipelineDictionary at: #x) closeTo: 0.19 precision: 0.01).
	self assert: (aFirstNodePipelineDictionary at: #y) equals: 0.31.
	
	aFirstNodePipelineInnerNodesArray := aFirstNodePipelineDictionary at: #inner_nodes.
	self assert: aFirstNodePipelineInnerNodesArray size equals: 2.
	aFourthNodeDictionary := (anExportedDictionary at: #nodes) at: 4.
	aFifthNodeDictionary := (anExportedDictionary at: #nodes) at: 5.

	self assert: (aFirstNodePipelineInnerNodesArray at: 1) equals: (aFourthNodeDictionary at: #id).
	self assert: (aFirstNodePipelineInnerNodesArray at: 2) equals: (aFifthNodeDictionary at: #id).
		
	aSecondNodeDictionary := (anExportedDictionary at: #nodes) at: 2.
	self assert: aSecondNodeDictionary size equals: 9.
	self assert: (aSecondNodeDictionary at: #x) equals: 0.5.
	self assert: (aSecondNodeDictionary at: #y) equals: 0.25.
	self assert: (aSecondNodeDictionary at: #width) equals: 12.
	self assert: (aSecondNodeDictionary at: #height) equals: 12.

	aSecondNodePipelineDictionary := aSecondNodeDictionary at: #pipeline.
	self assert: aSecondNodePipelineDictionary size equals: 1.
	self assert: (aSecondNodePipelineDictionary at: #is_visible) equals:false.

	self assert: (anExportedDictionary at: #edges) size equals: 1.
	anEdgeDictionary := (anExportedDictionary at: #edges) at: 1.
	self assert: (anEdgeDictionary at: #from) equals: (aFirstNodeDictionary at: #id).
	self assert: (anEdgeDictionary at: #to) equals: (aSecondNodeDictionary at: #id).
	self assert: (anEdgeDictionary at: #width) equals: 2.
	self assert: (anEdgeDictionary at: #arrow) equals: true.
	
	^ aWardleyMap -> anExportedDictionary
]

{ #category : #export }
GtWardleyMapJsonExporterImporterExamples >> exportWardleyMapWithWithNodes_nodeBAsEvolveTarget [
	<gtExample>
	| aWardleyMap anExportedDictionary aNodeBDictionary aNodeBLabelDictionary aNodeBPipelineDictionary aNodeBEvolveDictionary aNodeADictionary |

	aWardleyMap := GtWardleyMapModelExamples new newMapWithNodes_nodeBAsEvolveTarget.
	anExportedDictionary := aWardleyMap accept: GtWardleyMapAsDictionaryExporter new.

	self assert: anExportedDictionary size equals: 2.
	self assert: (anExportedDictionary includesKey: #nodes).
	self assert: (anExportedDictionary includesKey: #edges).
	
	self assert: (anExportedDictionary at: #nodes) size equals: 3.
	
	aNodeADictionary := (anExportedDictionary at: #nodes) at: 1.
	
	aNodeBDictionary := (anExportedDictionary at: #nodes) at: 2.
	self assert: aNodeBDictionary size equals: 9.
	self assert: (aNodeBDictionary at: #x) equals: 0.5.
	self assert: (aNodeBDictionary at: #y) equals: 0.25.
	self assert: (aNodeBDictionary at: #width) equals: 12.
	self assert: (aNodeBDictionary at: #height) equals: 12.
	self assert: (aNodeBDictionary at: #color) size equals: 4.
	self assert: ((aNodeBDictionary at: #color) at: #green) equals: Color black green.
	self assert: ((aNodeBDictionary at: #color) at: #blue) equals: Color black blue.
	self assert: ((aNodeBDictionary at: #color) at: #red) equals: Color black red.
	self assert: ((aNodeBDictionary at: #color) at: #alpha) equals: 0.2.

	aNodeBLabelDictionary := aNodeBDictionary at: #label.
	self assert: aNodeBLabelDictionary size equals: 3.
	self assert: (aNodeBLabelDictionary at: #x) equals: -1.5.
	self assert: (aNodeBLabelDictionary at: #y) equals: -1.5.
	self assert: (aNodeBLabelDictionary at: #text) equals: 'Node B'.
	
	aNodeBPipelineDictionary := aNodeBDictionary at: #pipeline.
	self assert: aNodeBPipelineDictionary size equals: 1.
	self assert: (aNodeBPipelineDictionary at: #is_visible) equals: false.
	
	aNodeBEvolveDictionary := aNodeBDictionary at: #evolve.
	self assert: aNodeBEvolveDictionary size equals: 2.
	self assert: (aNodeBEvolveDictionary at: #is_evolve_target) equals: true.
	self assert: (aNodeBEvolveDictionary at: #source_node) equals: (aNodeADictionary at: #id).
	
	^ aWardleyMap -> anExportedDictionary
]

{ #category : #import }
GtWardleyMapJsonExporterImporterExamples >> importWardleyMapFromDictionary [
	<gtExample>
	| anExportedWardleyMap anExportedDictionary anImportedWardleyMap |
	
	self exportWardleyMapAsDictionary in: [ :anAssociation |
		anExportedWardleyMap := anAssociation key.
		anExportedDictionary := anAssociation value ].

	anImportedWardleyMap := GtWardleyMapFromDictionaryImporter new importWardleyMapFrom: anExportedDictionary.
	
	"make sure that export => import produces the same map"
	self assert: anImportedWardleyMap equals: anExportedWardleyMap.

	^ anImportedWardleyMap
]

{ #category : #'import - legacy' }
GtWardleyMapJsonExporterImporterExamples >> importWardleyMapWithLegacyEvolveNode [
	<gtExample>
	
	| aJsonString anImportedWardleyMap aColor aNode |
	aJsonString := self wardleyMapWithLegacyEvolveNode.
	anImportedWardleyMap := GtWardleyMapFromDictionaryImporter  importMapFromJSONString: aJsonString.
	
	self assert: anImportedWardleyMap nodes size equals: 1.
	self assert: anImportedWardleyMap edges size equals: 0.
	
	aNode := anImportedWardleyMap nodes first.
	aColor := Color r: 0.0 g: 0.8504398826979472 b: 0.0 alpha: 1.0.
	self assert: aNode evolvedColor equals: aColor.
	self assert: aNode isEvolveVisible.
	self assert: aNode evolvedSize equals: 14@14.
	self assert: aNode evolvedSize equals: 14@14.
	self assert: aNode evolvedMaturity equals: 0.5972401245364447.
	self assert: aNode evolvedLabel equals: 'Evolved A'.
	self assert: aNode evolvedLabelCoordinate equals: 1.42 @ 2.25.
	
	^ anImportedWardleyMap
]

{ #category : #import }
GtWardleyMapJsonExporterImporterExamples >> importWardleyMapWithPipelineInnerNodesFromDictionary [
	<gtExample>
	| anExportedWardleyMap anExportedDictionary anImportedWardleyMap |
	
	self exportWardleyMapWithPipelineInnerNodesAsDictionary in: [ :anAssociation |
		anExportedWardleyMap := anAssociation key.
		anExportedDictionary := anAssociation value ].

	anImportedWardleyMap := GtWardleyMapFromDictionaryImporter new importWardleyMapFrom: anExportedDictionary.
	
	"make sure that export => import produces the same map"
	self assert: anImportedWardleyMap equals: anExportedWardleyMap.

	^ anImportedWardleyMap
]

{ #category : #import }
GtWardleyMapJsonExporterImporterExamples >> importWardleyMapWithWithNodes_nodeBAsEvolveTarget [
	<gtExample>
	| anExportedWardleyMap anExportedDictionary anImportedWardleyMap |
	
	self exportWardleyMapWithWithNodes_nodeBAsEvolveTarget in: [ :anAssociation |
		anExportedWardleyMap := anAssociation key.
		anExportedDictionary := anAssociation value ].

	anImportedWardleyMap := GtWardleyMapFromDictionaryImporter new importWardleyMapFrom: anExportedDictionary.
	
	"make sure that export => import produces the same map"
	self assert: anImportedWardleyMap equals: anExportedWardleyMap.

	^ anImportedWardleyMap
]

{ #category : #'import - legacy' }
GtWardleyMapJsonExporterImporterExamples >> wardleyMapWithLegacyEvolveNode [
	<gtExample>
	^ '{
	"nodes" : [
		{
			"id" : "c69b8c83-64d6-0d00-bc51-baa2047e8ee3",
			"color" : {
				"green" : 0.0,
				"blue" : 0.0,
				"alpha" : 1.0,
				"red" : 0.0
			},
			"x" : 0.3436040554395939,
			"y" : 0.35485677083333333,
			"width" : 12,
			"height" : 12,
			"label" : {
				"x" : 0.5,
				"y" : 2.0,
				"text" : "Node A"
			},
			"pipeline" : {
				"is_visible" : false
			},
			"evolve" : {
				"is_evolve_target" : false
			}
		},
		{
			"id" : "294ed183-64d6-0d00-bc52-ec39047e8ee3",
			"color" : {
				"green" : 0.8504398826979472,
				"blue" : 0.0,
				"alpha" : 1.0,
				"red" : 0.0
			},
			"x" : 0.5972401245364447,
			"y" : 0.35485677083333333,
			"width" : 14,
			"height" : 14,
			"label" : {
				"x" : 1.42,
				"y" : 2.25,
				"text" : "Evolved A"
			},
			"pipeline" : {
				"is_visible" : false
			},
			"evolve" : {
				"is_evolve_target" : true,
				"source_node" : "c69b8c83-64d6-0d00-bc51-baa2047e8ee3"
			}
		}
	],
	"edges" : [
		{
			"from" : "c69b8c83-64d6-0d00-bc51-baa2047e8ee3",
			"to" : "294ed183-64d6-0d00-bc52-ec39047e8ee3",
			"color" : {
				"green" : 0.0,
				"blue" : 0.0,
				"alpha" : 1.0,
				"red" : 1.0
			},
			"width" : 1.0,
			"arrow" : true,
			"label" : {
				"x" : 0.5,
				"y" : 0.5,
				"is_visible" : false,
				"text" : "Edge label"
			}
		}
	]
}'
]
