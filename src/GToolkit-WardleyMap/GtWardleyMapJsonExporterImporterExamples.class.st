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
	self assert: aFirstNodeDictionary size equals: 8.
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
	self assert: aSecondNodeDictionary size equals: 8.
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
	self assert: aFirstNodeDictionary size equals: 8.
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
	self assert: aSecondNodeDictionary size equals: 8.
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

{ #category : #export }
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
