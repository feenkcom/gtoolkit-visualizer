Class {
	#name : #GtWardleyMapExporterImporterExamples,
	#superclass : #Object,
	#category : #'GToolkit-WardleyMap-Examples'
}

{ #category : #export }
GtWardleyMapExporterImporterExamples >> exportWardleyMapAsDictionary [
	<gtExample>
	| aWardleyMap anExportedDictionary aFirstNodeDictionary aFirstNodeLabelDictionary aSecondNodeDictionary anEdgeDictionary |

	aWardleyMap := GtWardleyMapModelExamples new newMapWithNodes.
	anExportedDictionary := aWardleyMap accept: GtWardleyMapAsDictionaryExporter new.

	self assert: anExportedDictionary size equals: 2.
	self assert: (anExportedDictionary includesKey: #nodes).
	self assert: (anExportedDictionary includesKey: #edges).
	
	self assert: (anExportedDictionary at: #nodes) size equals: 3.
	
	aFirstNodeDictionary := (anExportedDictionary at: #nodes) at: 1.
	self assert: aFirstNodeDictionary size equals: 7.
	self assert: (aFirstNodeDictionary at: #x) equals: 0.25.
	self assert: (aFirstNodeDictionary at: #y) equals: 0.75.
	self assert: (aFirstNodeDictionary at: #width) equals: 12.
	self assert: (aFirstNodeDictionary at: #height) equals: 12.

	aFirstNodeLabelDictionary := aFirstNodeDictionary at: #label.
	self assert: aFirstNodeLabelDictionary size equals: 3.
	self assert: (aFirstNodeLabelDictionary at: #x) equals: 0.5.
	self assert: (aFirstNodeLabelDictionary at: #y) equals: 2.0.
	self assert: (aFirstNodeLabelDictionary at: #text) equals: 'Node A'.
	
	aSecondNodeDictionary := (anExportedDictionary at: #nodes) at: 2.
	self assert: aSecondNodeDictionary size equals: 7.
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
GtWardleyMapExporterImporterExamples >> importWardleyMapAsDictionary [
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
