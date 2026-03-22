Class {
	#name : #GtWardleyMapJsonExporterImporterExamples,
	#superclass : #Object,
	#category : #'GToolkit-WardleyMap-Examples'
}

{ #category : #export }
GtWardleyMapJsonExporterImporterExamples >> exportWardleyMapAsDictionary [
	<gtExample>
	<return: #Association>
	| aWardleyMap anExportedDictionary aFirstNodeDictionary aFirstNodeLabelDictionary aSecondNodeDictionary anEdgeDictionary aFirstNodePipelineDictionary |
	aWardleyMap := GtWardleyMapModelExamples new newMapWithNodes.
	anExportedDictionary := aWardleyMap
			accept: GtWardleyMapAsDictionaryExporter new.

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
	self assert: (aFirstNodePipelineDictionary at: #is_visible) equals: false.

	aSecondNodeDictionary := (anExportedDictionary at: #nodes) at: 2.
	self assert: aSecondNodeDictionary size equals: 9.
	self assert: (aSecondNodeDictionary at: #x) equals: 0.5.
	self assert: (aSecondNodeDictionary at: #y) equals: 0.25.
	self assert: (aSecondNodeDictionary at: #width) equals: 12.
	self assert: (aSecondNodeDictionary at: #height) equals: 12.

	self assert: (anExportedDictionary at: #edges) size equals: 1.
	anEdgeDictionary := (anExportedDictionary at: #edges) at: 1.
	self
		assert: (anEdgeDictionary at: #from)
		equals: (aFirstNodeDictionary at: #id).
	self assert: (anEdgeDictionary at: #to) equals: (aSecondNodeDictionary at: #id).
	self assert: (anEdgeDictionary at: #width) equals: 2.
	self assert: (anEdgeDictionary at: #arrow) equals: true.

	^ aWardleyMap -> anExportedDictionary
]

{ #category : #export }
GtWardleyMapJsonExporterImporterExamples >> exportWardleyMapAsDictionaryWithEvolutionAndVisibility [
	<gtExample>
	<return: #Association>
	| aWardleyMap anExporter anExportedDictionary aFirstNodeDictionary aFirstNodeLabelDictionary aSecondNodeDictionary anEdgeDictionary aFirstNodePipelineDictionary |
	aWardleyMap := GtWardleyMapModelExamples new newMapWithNodes.
	anExporter := GtWardleyMapAsDictionaryExporter new
			beEvolutionAndVisibilityExport.
	anExportedDictionary := aWardleyMap accept: anExporter.

	self assert: anExportedDictionary size equals: 2.
	self assert: (anExportedDictionary includesKey: #nodes).
	self assert: (anExportedDictionary includesKey: #edges).

	self assert: (anExportedDictionary at: #nodes) size equals: 3.

	aFirstNodeDictionary := (anExportedDictionary at: #nodes) at: 1.
	self assert: aFirstNodeDictionary size equals: 9.
	self assert: (aFirstNodeDictionary at: #evolution) equals: 0.25.
	self assert: (aFirstNodeDictionary at: #visibility) equals: 1 - 0.75.
	self assert: (aFirstNodeDictionary at: #width) equals: 12.
	self assert: (aFirstNodeDictionary at: #height) equals: 12.

	aFirstNodeLabelDictionary := aFirstNodeDictionary at: #label.
	self assert: aFirstNodeLabelDictionary size equals: 3.
	self assert: (aFirstNodeLabelDictionary at: #x) equals: 0.5.
	self assert: (aFirstNodeLabelDictionary at: #y) equals: 2.0.
	self assert: (aFirstNodeLabelDictionary at: #text) equals: 'Node A'.

	aFirstNodePipelineDictionary := aFirstNodeDictionary at: #pipeline.
	self assert: aFirstNodePipelineDictionary size equals: 1.
	self assert: (aFirstNodePipelineDictionary at: #is_visible) equals: false.

	aSecondNodeDictionary := (anExportedDictionary at: #nodes) at: 2.
	self assert: aSecondNodeDictionary size equals: 9.
	self assert: (aSecondNodeDictionary at: #evolution) equals: 0.5.
	self assert: (aSecondNodeDictionary at: #visibility) equals: 1 - 0.25.
	self assert: (aSecondNodeDictionary at: #width) equals: 12.
	self assert: (aSecondNodeDictionary at: #height) equals: 12.

	self assert: (anExportedDictionary at: #edges) size equals: 1.
	anEdgeDictionary := (anExportedDictionary at: #edges) at: 1.
	self
		assert: (anEdgeDictionary at: #from)
		equals: (aFirstNodeDictionary at: #id).
	self assert: (anEdgeDictionary at: #to) equals: (aSecondNodeDictionary at: #id).
	self assert: (anEdgeDictionary at: #width) equals: 2.
	self assert: (anEdgeDictionary at: #arrow) equals: true.

	^ aWardleyMap -> anExportedDictionary
]

{ #category : #export }
GtWardleyMapJsonExporterImporterExamples >> exportWardleyMapWithPipelineInnerNodesAsDictionary [
	<gtExample>
	<return: #Association>
	| aWardleyMap anExportedDictionary aFirstNodeDictionary aFirstNodeLabelDictionary aSecondNodeDictionary anEdgeDictionary aFirstNodePipelineDictionary aFirstNodePipelineInnerNodesArray aFourthNodeDictionary aFifthNodeDictionary aSecondNodePipelineDictionary aNoteADictionary |
	aWardleyMap := GtWardleyMapModelExamples new newMapWithPipelineInnerNodes.
	anExportedDictionary := aWardleyMap
			accept: GtWardleyMapAsDictionaryExporter new.

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
	self
		assert: ((aNoteADictionary at: #color) at: #green)
		equals: Color lightOrange green.
	self
		assert: ((aNoteADictionary at: #color) at: #blue)
		equals: Color lightOrange blue.
	self
		assert: ((aNoteADictionary at: #color) at: #red)
		equals: Color lightOrange red.
	self
		assert: ((aNoteADictionary at: #color) at: #alpha)
		equals: Color lightOrange alpha.

	aFirstNodeDictionary := (anExportedDictionary at: #nodes) at: 1.
	self assert: aFirstNodeDictionary size equals: 9.
	self assert: (aFirstNodeDictionary at: #x) equals: 0.25.
	self assert: (aFirstNodeDictionary at: #y) equals: 0.75.
	self assert: (aFirstNodeDictionary at: #width) equals: 12.
	self assert: (aFirstNodeDictionary at: #height) equals: 12.
	self assert: (aFirstNodeDictionary at: #color) size equals: 4.
	self
		assert: ((aFirstNodeDictionary at: #color) at: #green)
		equals: Color gray green.
	self
		assert: ((aFirstNodeDictionary at: #color) at: #blue)
		equals: Color gray blue.
	self
		assert: ((aFirstNodeDictionary at: #color) at: #red)
		equals: Color gray red.
	self
		assert: ((aFirstNodeDictionary at: #color) at: #alpha)
		equals: Color gray alpha.

	aFirstNodeLabelDictionary := aFirstNodeDictionary at: #label.
	self assert: aFirstNodeLabelDictionary size equals: 3.
	self assert: (aFirstNodeLabelDictionary at: #x) equals: -1.5.
	self assert: (aFirstNodeLabelDictionary at: #y) equals: -1.5.
	self assert: (aFirstNodeLabelDictionary at: #text) equals: 'Node A'.

	aFirstNodePipelineDictionary := aFirstNodeDictionary at: #pipeline.
	self assert: aFirstNodePipelineDictionary size equals: 4.
	self assert: (aFirstNodePipelineDictionary at: #is_visible) equals: true.
	self
		assert: ((aFirstNodePipelineDictionary at: #x) closeTo: 0.19 precision: 0.01).
	self assert: (aFirstNodePipelineDictionary at: #y) equals: 0.31.

	aFirstNodePipelineInnerNodesArray := aFirstNodePipelineDictionary
			at: #inner_nodes.
	self assert: aFirstNodePipelineInnerNodesArray size equals: 2.
	aFourthNodeDictionary := (anExportedDictionary at: #nodes) at: 4.
	aFifthNodeDictionary := (anExportedDictionary at: #nodes) at: 5.

	self
		assert: (aFirstNodePipelineInnerNodesArray at: 1)
		equals: (aFourthNodeDictionary at: #id).
	self
		assert: (aFirstNodePipelineInnerNodesArray at: 2)
		equals: (aFifthNodeDictionary at: #id).

	aSecondNodeDictionary := (anExportedDictionary at: #nodes) at: 2.
	self assert: aSecondNodeDictionary size equals: 9.
	self assert: (aSecondNodeDictionary at: #x) equals: 0.5.
	self assert: (aSecondNodeDictionary at: #y) equals: 0.25.
	self assert: (aSecondNodeDictionary at: #width) equals: 12.
	self assert: (aSecondNodeDictionary at: #height) equals: 12.

	aSecondNodePipelineDictionary := aSecondNodeDictionary at: #pipeline.
	self assert: aSecondNodePipelineDictionary size equals: 1.
	self assert: (aSecondNodePipelineDictionary at: #is_visible) equals: false.

	self assert: (anExportedDictionary at: #edges) size equals: 1.
	anEdgeDictionary := (anExportedDictionary at: #edges) at: 1.
	self
		assert: (anEdgeDictionary at: #from)
		equals: (aFirstNodeDictionary at: #id).
	self assert: (anEdgeDictionary at: #to) equals: (aSecondNodeDictionary at: #id).
	self assert: (anEdgeDictionary at: #width) equals: 2.
	self assert: (anEdgeDictionary at: #arrow) equals: true.

	^ aWardleyMap -> anExportedDictionary
]

{ #category : #export }
GtWardleyMapJsonExporterImporterExamples >> exportWardleyMapWithTitleAsDictionary [
	<gtExample>
	<return: #Association>
	| aWardleyMap anExportedDictionary aTitleDictionary |
	aWardleyMap := GtWardleyMapModelExamples new newMapWithNodesAndTitle.
	anExportedDictionary := aWardleyMap
			accept: GtWardleyMapAsDictionaryExporter new.

	self assert: anExportedDictionary size equals: 3.
	self assert: (anExportedDictionary includesKey: #title).
	self assert: (anExportedDictionary includesKey: #nodes).
	self assert: (anExportedDictionary includesKey: #edges).

	aTitleDictionary := anExportedDictionary at: #title.
	self assert: aTitleDictionary size equals: 2.
	self assert: (aTitleDictionary at: #text) equals: 'Wardley Map with nodes'.
	self assert: (aTitleDictionary at: #is_visible) equals: true.

	^ aWardleyMap -> anExportedDictionary
]

{ #category : #export }
GtWardleyMapJsonExporterImporterExamples >> exportWardleyMapWithWithNodes_nodeBAsEvolveTarget [
	<gtExample>
	<return: #Association>
	| aWardleyMap anExportedDictionary aNodeBDictionary aNodeBLabelDictionary aNodeBPipelineDictionary aNodeBEvolveDictionary aNodeADictionary aNodeALabelDictionary aNodeAEvolveDictionary aNodeAEvolveLabelDictionary |
	aWardleyMap := GtWardleyMapModelExamples new
			newMapWithNodes_nodeBAsEvolveTarget.
	anExportedDictionary := aWardleyMap
			accept: GtWardleyMapAsDictionaryExporter new.

	self assert: anExportedDictionary size equals: 2.
	self assert: (anExportedDictionary includesKey: #nodes).
	self assert: (anExportedDictionary includesKey: #edges).

	self assert: (anExportedDictionary at: #nodes) size equals: 3.

	aNodeADictionary := (anExportedDictionary at: #nodes) at: 1.
	self assert: aNodeADictionary size equals: 9.
	self assert: (aNodeADictionary at: #x) equals: 0.25.
	self assert: (aNodeADictionary at: #y) equals: 0.75.
	self assert: (aNodeADictionary at: #width) equals: 12.
	self assert: (aNodeADictionary at: #height) equals: 12.
	self assert: (aNodeADictionary at: #color) size equals: 4.
	self
		assert: ((aNodeADictionary at: #color) at: #green)
		equals: Color gray green.
	self assert: ((aNodeADictionary at: #color) at: #blue) equals: Color gray blue.
	self assert: ((aNodeADictionary at: #color) at: #red) equals: Color gray red.
	self assert: ((aNodeADictionary at: #color) at: #alpha) equals: 1.0.

	aNodeALabelDictionary := aNodeADictionary at: #label.
	self assert: aNodeALabelDictionary size equals: 3.
	self assert: (aNodeALabelDictionary at: #x) equals: 0.5.
	self assert: (aNodeALabelDictionary at: #y) equals: 2.0.
	self assert: (aNodeALabelDictionary at: #text) equals: 'Node A'.

	aNodeAEvolveDictionary := aNodeADictionary at: #evolve.
	self assert: aNodeAEvolveDictionary size equals: 6.
	self assert: (aNodeAEvolveDictionary at: #evolution) equals: 0.8.
	self
		assert: ((aNodeAEvolveDictionary at: #color) at: #green)
		equals: Color red green.
	self
		assert: ((aNodeAEvolveDictionary at: #color) at: #blue)
		equals: Color red blue.
	self
		assert: ((aNodeAEvolveDictionary at: #color) at: #red)
		equals: Color red red.
	self assert: ((aNodeAEvolveDictionary at: #color) at: #alpha) equals: 1.0.

	aNodeAEvolveLabelDictionary := aNodeAEvolveDictionary at: #label.
	self assert: aNodeAEvolveLabelDictionary size equals: 4.
	self assert: (aNodeAEvolveLabelDictionary at: #is_visible) equals: true.
	self assert: (aNodeAEvolveLabelDictionary at: #x) equals: 0.5.
	self assert: (aNodeAEvolveLabelDictionary at: #y) equals: 2.0.
	self assert: (aNodeAEvolveLabelDictionary at: #text) equals: 'Evolved Node A'.

	aNodeBDictionary := (anExportedDictionary at: #nodes) at: 2.
	self assert: aNodeBDictionary size equals: 9.
	self assert: (aNodeBDictionary at: #x) equals: 0.5.
	self assert: (aNodeBDictionary at: #y) equals: 0.25.
	self assert: (aNodeBDictionary at: #width) equals: 12.
	self assert: (aNodeBDictionary at: #height) equals: 12.
	self assert: (aNodeBDictionary at: #color) size equals: 4.
	self
		assert: ((aNodeBDictionary at: #color) at: #green)
		equals: Color black green.
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
	self assert: aNodeBEvolveDictionary size equals: 1.
	self assert: (aNodeBEvolveDictionary at: #is_visible) equals: false.

	^ aWardleyMap -> anExportedDictionary
]

{ #category : #export }
GtWardleyMapJsonExporterImporterExamples >> exportWardleyWithEvolutionSectionsMapAsDictionary [
	<gtExample>
	<return: #Association>
	| aWardleyMap anExportedDictionary aFirstNodeDictionary aFirstNodeLabelDictionary aSecondNodeDictionary anEdgeDictionary aFirstNodePipelineDictionary aTitleDictionary anEvolutionAxisDictionary |
	aWardleyMap := GtWardleyMapModelExamples new newMapWithEvolutionSections.
	anExportedDictionary := aWardleyMap
			accept: GtWardleyMapAsDictionaryExporter new.

	self assert: anExportedDictionary size equals: 4.
	self assert: (anExportedDictionary includesKey: #title).
	self assert: (anExportedDictionary includesKey: #evolution_axis).
	self assert: (anExportedDictionary includesKey: #nodes).
	self assert: (anExportedDictionary includesKey: #edges).

	aTitleDictionary := anExportedDictionary at: #title.
	self assert: aTitleDictionary size equals: 2.
	self assert: (aTitleDictionary at: #text) equals: 'Wardley Map with nodes'.
	self assert: (aTitleDictionary at: #is_visible) equals: true.

	anEvolutionAxisDictionary := anExportedDictionary at: #evolution_axis.
	self assert: anEvolutionAxisDictionary size equals: 2.
	self
		assert: (anEvolutionAxisDictionary at: #sections)
		equals: GtWardleyMapModelExamples new evolutionSections.
	self assert: (anEvolutionAxisDictionary at: #is_visible) equals: true.

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
	self assert: (aFirstNodePipelineDictionary at: #is_visible) equals: false.

	aSecondNodeDictionary := (anExportedDictionary at: #nodes) at: 2.
	self assert: aSecondNodeDictionary size equals: 9.
	self assert: (aSecondNodeDictionary at: #x) equals: 0.5.
	self assert: (aSecondNodeDictionary at: #y) equals: 0.25.
	self assert: (aSecondNodeDictionary at: #width) equals: 12.
	self assert: (aSecondNodeDictionary at: #height) equals: 12.

	self assert: (anExportedDictionary at: #edges) size equals: 1.
	anEdgeDictionary := (anExportedDictionary at: #edges) at: 1.
	self
		assert: (anEdgeDictionary at: #from)
		equals: (aFirstNodeDictionary at: #id).
	self assert: (anEdgeDictionary at: #to) equals: (aSecondNodeDictionary at: #id).
	self assert: (anEdgeDictionary at: #width) equals: 2.
	self assert: (anEdgeDictionary at: #arrow) equals: true.

	^ aWardleyMap -> anExportedDictionary
]

{ #category : #import }
GtWardleyMapJsonExporterImporterExamples >> importWardleyMapFromDictionary [
	<gtExample>
	<return: #GtWardleyMapModel>
	| anExportedWardleyMap anExportedDictionary anImportedWardleyMap |
	self exportWardleyMapAsDictionary
		in: [ :anAssociation | 
			anExportedWardleyMap := anAssociation key.
			anExportedDictionary := anAssociation value ].

	anImportedWardleyMap := GtWardleyMapFromDictionaryImporter new
			importWardleyMapFrom: anExportedDictionary.	"make sure that export => import produces the same map"
	self assert: anImportedWardleyMap equals: anExportedWardleyMap.

	^ anImportedWardleyMap
]

{ #category : #import }
GtWardleyMapJsonExporterImporterExamples >> importWardleyMapFromDictionaryWithEvolutionAndVisibility [
	<gtExample>
	<return: #GtWardleyMapModel>
	| anExportedWardleyMap anExportedDictionary anImportedWardleyMap |
	self exportWardleyMapAsDictionaryWithEvolutionAndVisibility
		in: [ :anAssociation | 
			anExportedWardleyMap := anAssociation key.
			anExportedDictionary := anAssociation value ].

	anImportedWardleyMap := GtWardleyMapFromDictionaryImporter new
			importWardleyMapFrom: anExportedDictionary.	"make sure that export => import produces the same map"
	self assert: anImportedWardleyMap equals: anExportedWardleyMap.

	^ anImportedWardleyMap
]

{ #category : #import }
GtWardleyMapJsonExporterImporterExamples >> importWardleyMapWithEvolutionSectionsFromDictionary [
	<gtExample>
	<return: #GtWardleyMapModel>
	| anExportedWardleyMap anExportedDictionary anImportedWardleyMap |
	self exportWardleyWithEvolutionSectionsMapAsDictionary
		in: [ :anAssociation | 
			anExportedWardleyMap := anAssociation key.
			anExportedDictionary := anAssociation value ].

	anImportedWardleyMap := GtWardleyMapFromDictionaryImporter new
			importWardleyMapFrom: anExportedDictionary.	"make sure that export => import produces the same map"
	self assert: anImportedWardleyMap equals: anExportedWardleyMap.

	^ anImportedWardleyMap
]

{ #category : #'import - legacy' }
GtWardleyMapJsonExporterImporterExamples >> importWardleyMapWithLegacyEvolveNode [
	<gtExample>
	<return: #GtWardleyMapModel>
	| aJsonString anImportedWardleyMap aColor aNode |
	aJsonString := self wardleyMapWithLegacyEvolveNode.
	anImportedWardleyMap := GtWardleyMapFromDictionaryImporter
			importMapFromJSONString: aJsonString.

	self assert: anImportedWardleyMap nodes size equals: 1.
	self assert: anImportedWardleyMap edges size equals: 0.

	aNode := anImportedWardleyMap nodes first.
	aColor := Color
			r: 0.0
			g: 0.8504398826979472
			b: 0.0
			alpha: 1.0.
	self assert: aNode evolvedColor equals: aColor.
	self assert: aNode isEvolveVisible.
	self assert: aNode evolvedSize equals: 14 @ 14.
	self assert: aNode evolvedSize equals: 14 @ 14.
	self assert: aNode evolvedEvolution equals: 0.5972401245364447.
	self assert: aNode evolvedLabel equals: 'Evolved A'.
	self assert: aNode evolvedLabelCoordinate equals: 1.42 @ 2.25.

	^ anImportedWardleyMap
]

{ #category : #'import - legacy' }
GtWardleyMapJsonExporterImporterExamples >> importWardleyMapWithOptionalNodeEvolutionAndVisibility [
	<gtExample>
	<return: #GtWardleyMapModel>
	| aJsonString anImportedWardleyMap aColor aNodeA aNodeF aNoteA |
	aJsonString := self wardleyMapWithOptionalNodeEvolutionAndVisibility.
	anImportedWardleyMap := GtWardleyMapFromDictionaryImporter
			importMapFromJSONString: aJsonString.

	self assert: anImportedWardleyMap nodes size equals: 7.
	self assert: anImportedWardleyMap edges size equals: 1.
	self assert: anImportedWardleyMap notes size equals: 1.

	aNoteA := anImportedWardleyMap
			noteWithText: 'Note A'
			ifFound: [ :e | e ]
			ifNone: [ nil ].
	self assert: aNoteA x equals: 0.47.
	self assert: aNoteA y equals: 0.4.

	aNodeA := anImportedWardleyMap
			nodeWithName: 'Node A'
			ifFound: [ :e | e ]
			ifNone: [ nil ].
	aColor := Color
			r: 0.5004887585532747
			g: 0.5004887585532747
			b: 0.5004887585532747
			alpha: 1.0.
	self assert: aNodeA color equals: aColor.
	self assert: aNodeA isEvolveVisible not.
	self assert: aNodeA isPipelineVisible.
	self assert: aNodeA innerNodes size equals: 2.
	self assert: aNodeA x equals: 0.25.
	self assert: aNodeA y equals: 0.75.
	self assert: aNodeA pipelineCoordinate equals: 0.19 @ 0.31.

	aNodeF := anImportedWardleyMap
			nodeWithName: 'Node F'
			ifFound: [ :e | e ]
			ifNone: [ nil ].
	aColor := Color
			r: 1.0
			g: 0.0
			b: 0.0
			alpha: 1.0.
	self assert: aNodeF isEvolveVisible.
	self assert: aNodeA evolvedColor equals: aColor.
	self assert: aNodeF evolvedSize equals: 12 @ 12.
	self assert: aNodeF evolvedEvolution equals: 0.61.
	self assert: aNodeF evolvedLabel equals: 'Evolved F'.
	self assert: aNodeF evolvedLabelCoordinate equals: 0.5 @ 2.0.

	^ anImportedWardleyMap
]

{ #category : #'import - legacy' }
GtWardleyMapJsonExporterImporterExamples >> importWardleyMapWithOptionalNodeMaturityAndVisibility [
	"The maturity is not recommended and therefore obsolete. Use evolution instead.
	Read more on https://swardley.medium.com/map-evolution-not-maturity-bae6ea1a2743"

	<gtExample>
	<return: #GtWardleyMapModel>
	| aJsonString anImportedWardleyMap aColor aNodeA aNodeF aNoteA |
	aJsonString := self wardleyMapWithOptionalNodeMaturityAndVisibility.
	anImportedWardleyMap := GtWardleyMapFromDictionaryImporter
			importMapFromJSONString: aJsonString.

	self assert: anImportedWardleyMap nodes size equals: 7.
	self assert: anImportedWardleyMap edges size equals: 1.
	self assert: anImportedWardleyMap notes size equals: 1.

	aNoteA := anImportedWardleyMap
			noteWithText: 'Note A'
			ifFound: [ :e | e ]
			ifNone: [ nil ].
	self assert: aNoteA x equals: 0.47.
	self assert: aNoteA y equals: 0.4.

	aNodeA := anImportedWardleyMap
			nodeWithName: 'Node A'
			ifFound: [ :e | e ]
			ifNone: [ nil ].
	aColor := Color
			r: 0.5004887585532747
			g: 0.5004887585532747
			b: 0.5004887585532747
			alpha: 1.0.
	self assert: aNodeA color equals: aColor.
	self assert: aNodeA isEvolveVisible not.
	self assert: aNodeA isPipelineVisible.
	self assert: aNodeA innerNodes size equals: 2.
	self assert: aNodeA x equals: 0.25.
	self assert: aNodeA y equals: 0.75.
	self assert: aNodeA pipelineCoordinate equals: 0.19 @ 0.31.

	aNodeF := anImportedWardleyMap
			nodeWithName: 'Node F'
			ifFound: [ :e | e ]
			ifNone: [ nil ].
	aColor := Color
			r: 1.0
			g: 0.0
			b: 0.0
			alpha: 1.0.
	self assert: aNodeF isEvolveVisible.
	self assert: aNodeA evolvedColor equals: aColor.
	self assert: aNodeF evolvedSize equals: 12 @ 12.
	self assert: aNodeF evolvedEvolution equals: 0.61.
	self assert: aNodeF evolvedLabel equals: 'Evolved F'.
	self assert: aNodeF evolvedLabelCoordinate equals: 0.5 @ 2.0.

	^ anImportedWardleyMap
]

{ #category : #'import - legacy' }
GtWardleyMapJsonExporterImporterExamples >> importWardleyMapWithOptionalNodeXY [
	<gtExample>
	<return: #GtWardleyMapModel>
	| aJsonString anImportedWardleyMap aColor aNodeA aNodeF aNoteA |
	aJsonString := self wardleyMapWithOptionalNodeXY.
	anImportedWardleyMap := GtWardleyMapFromDictionaryImporter
			importMapFromJSONString: aJsonString.

	self assert: anImportedWardleyMap nodes size equals: 7.
	self assert: anImportedWardleyMap edges size equals: 1.
	self assert: anImportedWardleyMap notes size equals: 1.

	aNoteA := anImportedWardleyMap
			noteWithText: 'Note A'
			ifFound: [ :e | e ]
			ifNone: [ nil ].
	self assert: aNoteA x equals: 0.47.
	self assert: aNoteA y equals: 0.4.

	aNodeA := anImportedWardleyMap
			nodeWithName: 'Node A'
			ifFound: [ :e | e ]
			ifNone: [ nil ].
	aColor := Color
			r: 0.5004887585532747
			g: 0.5004887585532747
			b: 0.5004887585532747
			alpha: 1.0.
	self assert: aNodeA color equals: aColor.
	self assert: aNodeA isEvolveVisible not.
	self assert: aNodeA isPipelineVisible.
	self assert: aNodeA innerNodes size equals: 2.
	self assert: aNodeA x equals: 0.25.
	self assert: aNodeA y equals: 0.75.
	self assert: aNodeA pipelineCoordinate equals: 0.19 @ 0.31.

	aNodeF := anImportedWardleyMap
			nodeWithName: 'Node F'
			ifFound: [ :e | e ]
			ifNone: [ nil ].
	aColor := Color
			r: 1.0
			g: 0.0
			b: 0.0
			alpha: 1.0.
	self assert: aNodeF isEvolveVisible.
	self assert: aNodeA evolvedColor equals: aColor.
	self assert: aNodeF evolvedSize equals: 12 @ 12.
	self assert: aNodeF evolvedEvolution equals: 0.61.
	self assert: aNodeF evolvedLabel equals: 'Evolved F'.
	self assert: aNodeF evolvedLabelCoordinate equals: 0.5 @ 2.0.

	^ anImportedWardleyMap
]

{ #category : #import }
GtWardleyMapJsonExporterImporterExamples >> importWardleyMapWithPipelineInnerNodesFromDictionary [
	<gtExample>
	<return: #GtWardleyMapModel>
	| anExportedWardleyMap anExportedDictionary anImportedWardleyMap |
	self exportWardleyMapWithPipelineInnerNodesAsDictionary
		in: [ :anAssociation | 
			anExportedWardleyMap := anAssociation key.
			anExportedDictionary := anAssociation value ].

	anImportedWardleyMap := GtWardleyMapFromDictionaryImporter new
			importWardleyMapFrom: anExportedDictionary.	"make sure that export => import produces the same map"
	self assert: anImportedWardleyMap equals: anExportedWardleyMap.

	^ anImportedWardleyMap
]

{ #category : #import }
GtWardleyMapJsonExporterImporterExamples >> importWardleyMapWithTitleAsDictionary [
	<gtExample>
	<return: #GtWardleyMapModel>
	| anExportedWardleyMap anExportedDictionary anImportedWardleyMap |
	self exportWardleyMapWithTitleAsDictionary
		in: [ :anAssociation | 
			anExportedWardleyMap := anAssociation key.
			anExportedDictionary := anAssociation value ].

	anImportedWardleyMap := GtWardleyMapFromDictionaryImporter new
			importWardleyMapFrom: anExportedDictionary.	"make sure that export => import produces the same map"
	self assert: anImportedWardleyMap equals: anExportedWardleyMap.

	^ anImportedWardleyMap
]

{ #category : #import }
GtWardleyMapJsonExporterImporterExamples >> importWardleyMapWithWithNodes_nodeBAsEvolveTarget [
	<gtExample>
	<return: #GtWardleyMapModel>
	| anExportedWardleyMap anExportedDictionary anImportedWardleyMap |
	self exportWardleyMapWithWithNodes_nodeBAsEvolveTarget
		in: [ :anAssociation | 
			anExportedWardleyMap := anAssociation key.
			anExportedDictionary := anAssociation value ].

	anImportedWardleyMap := GtWardleyMapFromDictionaryImporter new
			importWardleyMapFrom: anExportedDictionary.	"make sure that export => import produces the same map"
	self assert: anImportedWardleyMap equals: anExportedWardleyMap.

	^ anImportedWardleyMap
]

{ #category : #'import - legacy' }
GtWardleyMapJsonExporterImporterExamples >> wardleyMapWithLegacyEvolveNode [
	<gtExample>
	<return: #ByteString>
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

{ #category : #'import - legacy' }
GtWardleyMapJsonExporterImporterExamples >> wardleyMapWithOptionalNodeEvolutionAndVisibility [
	<gtExample>
	<return: #ByteString>
	^ '{
	"notes" : [
		{
			"id" : "8e448aa3-ead6-0d00-9f73-be2d0f547d46",
			"label" : "Note A",
			"color" : {
				"green" : 0.7996089931573802,
				"blue" : 0.3998044965786901,
				"alpha" : 1.0,
				"red" : 1.0
			},
			"evolution" : 0.47,
			"visibility" : 0.6
		}
	],
	"nodes" : [
		{
			"id" : "00438aa3-ead6-0d00-9f6c-9afa0f547d46",
			"color" : {
				"green" : 0.5004887585532747,
				"blue" : 0.5004887585532747,
				"alpha" : 1.0,
				"red" : 0.5004887585532747
			},
			"evolution" : 0.25,
			"visibility" : 0.25,
			"width" : 12,
			"height" : 12,
			"label" : {
				"x" : -1.5,
				"y" : -1.5,
				"text" : "Node A"
			},
			"pipeline" : {
				"is_visible" : true,
				"min_evolution" : 0.19,
				"max_evolution" : 0.31,
				"inner_nodes" : [
					"85448aa3-ead6-0d00-9f6f-f32e0f547d46",
					"87448aa3-ead6-0d00-9f70-615f0f547d46"
				]
			},
			"evolve" : {
				"is_visible" : false
			}
		},
		{
			"id" : "4e438aa3-ead6-0d00-9f6d-94ee0f547d46",
			"color" : {
				"green" : 0.0,
				"blue" : 0.0,
				"alpha" : 0.2,
				"red" : 0.0
			},
			"evolution" : 0.5,
			"visibility" : 0.75,
			"width" : 12,
			"height" : 12,
			"label" : {
				"x" : -1.5,
				"y" : -1.5,
				"text" : "Node B"
			},
			"pipeline" : {
				"is_visible" : false
			},
			"evolve" : {
				"is_visible" : false
			}
		},
		{
			"id" : "83438aa3-ead6-0d00-9f6e-a1840f547d46",
			"color" : {
				"green" : 0.0,
				"blue" : 0.0,
				"alpha" : 1.0,
				"red" : 0.9198435972629521
			},
			"evolution" : 0.75,
			"visibility" : 0.5,
			"width" : 12,
			"height" : 12,
			"label" : {
				"x" : 0.5,
				"y" : 2.0,
				"text" : "Node C"
			},
			"pipeline" : {
				"is_visible" : false
			},
			"evolve" : {
				"is_visible" : false
			}
		},
		{
			"id" : "85448aa3-ead6-0d00-9f6f-f32e0f547d46",
			"color" : {
				"green" : 0.0,
				"blue" : 1.0,
				"alpha" : 1.0,
				"red" : 0.0
			},
			"evolution" : 0.2,
			"visibility" : 0.25,
			"width" : 12,
			"height" : 12,
			"label" : {
				"x" : 0.5,
				"y" : 2.0,
				"text" : "Node D"
			},
			"pipeline" : {
				"is_visible" : false
			},
			"evolve" : {
				"is_visible" : false
			}
		},
		{
			"id" : "87448aa3-ead6-0d00-9f70-615f0f547d46",
			"color" : {
				"green" : 0.0,
				"blue" : 1.0,
				"alpha" : 1.0,
				"red" : 0.0
			},
			"evolution" : 0.3,
			"visibility" : 0.25,
			"width" : 12,
			"height" : 12,
			"label" : {
				"x" : 0.5,
				"y" : 2.0,
				"text" : "Node E"
			},
			"pipeline" : {
				"is_visible" : false
			},
			"evolve" : {
				"is_visible" : false
			}
		},
		{
			"id" : "89448aa3-ead6-0d00-9f71-e0db0f547d46",
			"color" : {
				"green" : 0.9198435972629521,
				"blue" : 0.0,
				"alpha" : 1.0,
				"red" : 0.9198435972629521
			},
			"evolution" : 0.41,
			"visibility" : 0.24,
			"width" : 12,
			"height" : 12,
			"label" : {
				"x" : 0.5,
				"y" : 2.0,
				"text" : "Node F"
			},
			"pipeline" : {
				"is_visible" : false
			},
			"evolve" : {
				"is_visible" : true,
				"evolution" : 0.61,
				"color" : {
					"green" : 0.0,
					"blue" : 0.0,
					"alpha" : 1.0,
					"red" : 1.0
				},
				"width" : 12,
				"height" : 12,
				"label" : {
					"x" : 0.5,
					"y" : 2.0,
					"text" : "Evolved F",
					"is_visible" : false
				}
			}
		},
		{
			"id" : "8b448aa3-ead6-0d00-9f72-8a830f547d46",
			"color" : {
				"green" : 0.9198435972629521,
				"blue" : 0.0,
				"alpha" : 1.0,
				"red" : 0.9198435972629521
			},
			"evolution" : 0.38,
			"visibility" : 0.21999999999999997,
			"width" : 12,
			"height" : 12,
			"label" : {
				"x" : 0.5,
				"y" : 2.0,
				"text" : "Node G"
			},
			"pipeline" : {
				"is_visible" : false
			},
			"evolve" : {
				"is_visible" : false
			}
		}
	],
	"edges" : [
		{
			"from" : "00438aa3-ead6-0d00-9f6c-9afa0f547d46",
			"to" : "4e438aa3-ead6-0d00-9f6d-94ee0f547d46",
			"color" : {
				"green" : 0.5004887585532747,
				"blue" : 0.5004887585532747,
				"alpha" : 1.0,
				"red" : 0.5004887585532747
			},
			"width" : 2,
			"arrow" : true,
			"label" : {
				"x" : 0.5,
				"y" : 0.5,
				"is_visible" : true,
				"text" : "Edge A->B"
			}
		}
	]
}'
]

{ #category : #'import - legacy' }
GtWardleyMapJsonExporterImporterExamples >> wardleyMapWithOptionalNodeMaturityAndVisibility [
	"The maturity is not recommended and therefore obsolete. Use evolution instead.
	Read more on https://swardley.medium.com/map-evolution-not-maturity-bae6ea1a2743"

	<gtExample>
	<return: #ByteString>
	^ '{
	"notes" : [
		{
			"id" : "8e448aa3-ead6-0d00-9f73-be2d0f547d46",
			"label" : "Note A",
			"color" : {
				"green" : 0.7996089931573802,
				"blue" : 0.3998044965786901,
				"alpha" : 1.0,
				"red" : 1.0
			},
			"maturity" : 0.47,
			"visibility" : 0.6
		}
	],
	"nodes" : [
		{
			"id" : "00438aa3-ead6-0d00-9f6c-9afa0f547d46",
			"color" : {
				"green" : 0.5004887585532747,
				"blue" : 0.5004887585532747,
				"alpha" : 1.0,
				"red" : 0.5004887585532747
			},
			"maturity" : 0.25,
			"visibility" : 0.25,
			"width" : 12,
			"height" : 12,
			"label" : {
				"x" : -1.5,
				"y" : -1.5,
				"text" : "Node A"
			},
			"pipeline" : {
				"is_visible" : true,
				"min_maturity" : 0.19,
				"max_maturity" : 0.31,
				"inner_nodes" : [
					"85448aa3-ead6-0d00-9f6f-f32e0f547d46",
					"87448aa3-ead6-0d00-9f70-615f0f547d46"
				]
			},
			"evolve" : {
				"is_visible" : false
			}
		},
		{
			"id" : "4e438aa3-ead6-0d00-9f6d-94ee0f547d46",
			"color" : {
				"green" : 0.0,
				"blue" : 0.0,
				"alpha" : 0.2,
				"red" : 0.0
			},
			"maturity" : 0.5,
			"visibility" : 0.75,
			"width" : 12,
			"height" : 12,
			"label" : {
				"x" : -1.5,
				"y" : -1.5,
				"text" : "Node B"
			},
			"pipeline" : {
				"is_visible" : false
			},
			"evolve" : {
				"is_visible" : false
			}
		},
		{
			"id" : "83438aa3-ead6-0d00-9f6e-a1840f547d46",
			"color" : {
				"green" : 0.0,
				"blue" : 0.0,
				"alpha" : 1.0,
				"red" : 0.9198435972629521
			},
			"maturity" : 0.75,
			"visibility" : 0.5,
			"width" : 12,
			"height" : 12,
			"label" : {
				"x" : 0.5,
				"y" : 2.0,
				"text" : "Node C"
			},
			"pipeline" : {
				"is_visible" : false
			},
			"evolve" : {
				"is_visible" : false
			}
		},
		{
			"id" : "85448aa3-ead6-0d00-9f6f-f32e0f547d46",
			"color" : {
				"green" : 0.0,
				"blue" : 1.0,
				"alpha" : 1.0,
				"red" : 0.0
			},
			"maturity" : 0.2,
			"visibility" : 0.25,
			"width" : 12,
			"height" : 12,
			"label" : {
				"x" : 0.5,
				"y" : 2.0,
				"text" : "Node D"
			},
			"pipeline" : {
				"is_visible" : false
			},
			"evolve" : {
				"is_visible" : false
			}
		},
		{
			"id" : "87448aa3-ead6-0d00-9f70-615f0f547d46",
			"color" : {
				"green" : 0.0,
				"blue" : 1.0,
				"alpha" : 1.0,
				"red" : 0.0
			},
			"maturity" : 0.3,
			"visibility" : 0.25,
			"width" : 12,
			"height" : 12,
			"label" : {
				"x" : 0.5,
				"y" : 2.0,
				"text" : "Node E"
			},
			"pipeline" : {
				"is_visible" : false
			},
			"evolve" : {
				"is_visible" : false
			}
		},
		{
			"id" : "89448aa3-ead6-0d00-9f71-e0db0f547d46",
			"color" : {
				"green" : 0.9198435972629521,
				"blue" : 0.0,
				"alpha" : 1.0,
				"red" : 0.9198435972629521
			},
			"maturity" : 0.41,
			"visibility" : 0.24,
			"width" : 12,
			"height" : 12,
			"label" : {
				"x" : 0.5,
				"y" : 2.0,
				"text" : "Node F"
			},
			"pipeline" : {
				"is_visible" : false
			},
			"evolve" : {
				"is_visible" : true,
				"maturity" : 0.61,
				"color" : {
					"green" : 0.0,
					"blue" : 0.0,
					"alpha" : 1.0,
					"red" : 1.0
				},
				"width" : 12,
				"height" : 12,
				"label" : {
					"x" : 0.5,
					"y" : 2.0,
					"text" : "Evolved F",
					"is_visible" : false
				}
			}
		},
		{
			"id" : "8b448aa3-ead6-0d00-9f72-8a830f547d46",
			"color" : {
				"green" : 0.9198435972629521,
				"blue" : 0.0,
				"alpha" : 1.0,
				"red" : 0.9198435972629521
			},
			"maturity" : 0.38,
			"visibility" : 0.21999999999999997,
			"width" : 12,
			"height" : 12,
			"label" : {
				"x" : 0.5,
				"y" : 2.0,
				"text" : "Node G"
			},
			"pipeline" : {
				"is_visible" : false
			},
			"evolve" : {
				"is_visible" : false
			}
		}
	],
	"edges" : [
		{
			"from" : "00438aa3-ead6-0d00-9f6c-9afa0f547d46",
			"to" : "4e438aa3-ead6-0d00-9f6d-94ee0f547d46",
			"color" : {
				"green" : 0.5004887585532747,
				"blue" : 0.5004887585532747,
				"alpha" : 1.0,
				"red" : 0.5004887585532747
			},
			"width" : 2,
			"arrow" : true,
			"label" : {
				"x" : 0.5,
				"y" : 0.5,
				"is_visible" : true,
				"text" : "Edge A->B"
			}
		}
	]
}'
]

{ #category : #'import - legacy' }
GtWardleyMapJsonExporterImporterExamples >> wardleyMapWithOptionalNodeXY [
	<gtExample>
	<return: #ByteString>
	^ '{
	"notes" : [
		{
			"id" : "8e448aa3-ead6-0d00-9f73-be2d0f547d46",
			"label" : "Note A",
			"color" : {
				"green" : 0.7996089931573802,
				"blue" : 0.3998044965786901,
				"alpha" : 1.0,
				"red" : 1.0
			},
			"x" : 0.47,
			"y" : 0.4
		}
	],
	"nodes" : [
		{
			"id" : "00438aa3-ead6-0d00-9f6c-9afa0f547d46",
			"color" : {
				"green" : 0.5004887585532747,
				"blue" : 0.5004887585532747,
				"alpha" : 1.0,
				"red" : 0.5004887585532747
			},
			"x" : 0.25,
			"y" : 0.75,
			"width" : 12,
			"height" : 12,
			"label" : {
				"x" : -1.5,
				"y" : -1.5,
				"text" : "Node A"
			},
			"pipeline" : {
				"is_visible" : true,
				"x" : 0.19,
				"y" : 0.31,
				"inner_nodes" : [
					"85448aa3-ead6-0d00-9f6f-f32e0f547d46",
					"87448aa3-ead6-0d00-9f70-615f0f547d46"
				]
			},
			"evolve" : {
				"is_visible" : false
			}
		},
		{
			"id" : "4e438aa3-ead6-0d00-9f6d-94ee0f547d46",
			"color" : {
				"green" : 0.0,
				"blue" : 0.0,
				"alpha" : 0.2,
				"red" : 0.0
			},
			"x" : 0.5,
			"y" : 0.25,
			"width" : 12,
			"height" : 12,
			"label" : {
				"x" : -1.5,
				"y" : -1.5,
				"text" : "Node B"
			},
			"pipeline" : {
				"is_visible" : false
			},
			"evolve" : {
				"is_visible" : false
			}
		},
		{
			"id" : "83438aa3-ead6-0d00-9f6e-a1840f547d46",
			"color" : {
				"green" : 0.0,
				"blue" : 0.0,
				"alpha" : 1.0,
				"red" : 0.9198435972629521
			},
			"x" : 0.75,
			"y" : 0.5,
			"width" : 12,
			"height" : 12,
			"label" : {
				"x" : 0.5,
				"y" : 2.0,
				"text" : "Node C"
			},
			"pipeline" : {
				"is_visible" : false
			},
			"evolve" : {
				"is_visible" : false
			}
		},
		{
			"id" : "85448aa3-ead6-0d00-9f6f-f32e0f547d46",
			"color" : {
				"green" : 0.0,
				"blue" : 1.0,
				"alpha" : 1.0,
				"red" : 0.0
			},
			"x" : 0.2,
			"y" : 0.75,
			"width" : 12,
			"height" : 12,
			"label" : {
				"x" : 0.5,
				"y" : 2.0,
				"text" : "Node D"
			},
			"pipeline" : {
				"is_visible" : false
			},
			"evolve" : {
				"is_visible" : false
			}
		},
		{
			"id" : "87448aa3-ead6-0d00-9f70-615f0f547d46",
			"color" : {
				"green" : 0.0,
				"blue" : 1.0,
				"alpha" : 1.0,
				"red" : 0.0
			},
			"x" : 0.3,
			"y" : 0.75,
			"width" : 12,
			"height" : 12,
			"label" : {
				"x" : 0.5,
				"y" : 2.0,
				"text" : "Node E"
			},
			"pipeline" : {
				"is_visible" : false
			},
			"evolve" : {
				"is_visible" : false
			}
		},
		{
			"id" : "89448aa3-ead6-0d00-9f71-e0db0f547d46",
			"color" : {
				"green" : 0.9198435972629521,
				"blue" : 0.0,
				"alpha" : 1.0,
				"red" : 0.9198435972629521
			},
			"x" : 0.41,
			"y" : 0.76,
			"width" : 12,
			"height" : 12,
			"label" : {
				"x" : 0.5,
				"y" : 2.0,
				"text" : "Node F"
			},
			"pipeline" : {
				"is_visible" : false
			},
			"evolve" : {
				"is_visible" : true,
				"maturity" : 0.61,
				"color" : {
					"green" : 0.0,
					"blue" : 0.0,
					"alpha" : 1.0,
					"red" : 1.0
				},
				"width" : 12,
				"height" : 12,
				"label" : {
					"x" : 0.5,
					"y" : 2.0,
					"text" : "Evolved F",
					"is_visible" : false
				}
			}
		},
		{
			"id" : "8b448aa3-ead6-0d00-9f72-8a830f547d46",
			"color" : {
				"green" : 0.9198435972629521,
				"blue" : 0.0,
				"alpha" : 1.0,
				"red" : 0.9198435972629521
			},
			"x" : 0.38,
			"y" : 0.78,
			"width" : 12,
			"height" : 12,
			"label" : {
				"x" : 0.5,
				"y" : 2.0,
				"text" : "Node G"
			},
			"pipeline" : {
				"is_visible" : false
			},
			"evolve" : {
				"is_visible" : false
			}
		}
	],
	"edges" : [
		{
			"from" : "00438aa3-ead6-0d00-9f6c-9afa0f547d46",
			"to" : "4e438aa3-ead6-0d00-9f6d-94ee0f547d46",
			"color" : {
				"green" : 0.5004887585532747,
				"blue" : 0.5004887585532747,
				"alpha" : 1.0,
				"red" : 0.5004887585532747
			},
			"width" : 2,
			"arrow" : true,
			"label" : {
				"x" : 0.5,
				"y" : 0.5,
				"is_visible" : true,
				"text" : "Edge A->B"
			}
		}
	]
}'
]
