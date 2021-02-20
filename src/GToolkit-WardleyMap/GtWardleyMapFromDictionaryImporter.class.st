Class {
	#name : #GtWardleyMapFromDictionaryImporter,
	#superclass : #Object,
	#category : #'GToolkit-WardleyMap-Exporter/Importer'
}

{ #category : #'api - importer' }
GtWardleyMapFromDictionaryImporter >> importWardleyMapEdgeFrom: aDictionary [
	| aWardleyMapNode |
	
	aWardleyMapNode := GtWardleyMapEdgeModel new.
	"(aDictionary at: #nodes) do: [ :eachNodeDictionary |
		aWardleyMap addNode: (self importWardleyMapNodeFrom: eachNodeDictionary) ]."
	
	^ aWardleyMapNode
]

{ #category : #'api - importer' }
GtWardleyMapFromDictionaryImporter >> importWardleyMapFrom: aDictionary [
	| aWardleyMap |
	
	aWardleyMap := GtWardleyMapModel new.
	(aDictionary at: #nodes) do: [ :eachNodeDictionary |
		aWardleyMap addNode: (self importWardleyMapNodeFrom: eachNodeDictionary) ].
	
	^ aWardleyMap
]

{ #category : #'api - importer' }
GtWardleyMapFromDictionaryImporter >> importWardleyMapNodeFrom: aDictionary [
	| aWardleyMapNode |
	
	aWardleyMapNode := GtWardleyMapNodeModel new.
	"(aDictionary at: #nodes) do: [ :eachNodeDictionary |
		aWardleyMap addNode: (self importWardleyMapNodeFrom: eachNodeDictionary) ]."
	
	^ aWardleyMapNode
]
