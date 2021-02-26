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
GtWardleyMapFromDictionaryImporter >> importWardleyMapEdgeFrom: aDictionary [
	| aWardleyMapEdge |

	aWardleyMapEdge := GtWardleyMapEdgeModel new.

	aDictionary
		at: #color
		ifPresent: [ :aColorDictionary | aWardleyMapEdge color: (self importColorFrom: aColorDictionary) ].

	aDictionary at: #width ifPresent: [ :aWidth | aWardleyMapEdge width: aWidth ].
	aDictionary at: #arrow ifPresent: [ :anArrow | aWardleyMapEdge arrow: anArrow ].
	
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
				ifFound: [ :aFromNode | aWardleyMapEdge fromNode: aFromNode ]
				ifNone: [  ] ].

	aDictionary
		at: #to
		ifPresent: [ :aToId |
			aWardleyMap
				nodeWithId: (self importIdFrom: aToId)
				ifFound: [ :aToNode | aWardleyMapEdge toNode: aToNode ]
				ifNone: [  ] ].
	
	^ aWardleyMapEdge
]

{ #category : #'api - importer' }
GtWardleyMapFromDictionaryImporter >> importWardleyMapFrom: aDictionary [
	| aWardleyMap |
	
	aWardleyMap := GtWardleyMapModel new.
	(aDictionary at: #nodes ifPresent: [ :theNodeDictionaries |
		theNodeDictionaries do: [ :eachNodeDictionary |
			aWardleyMap addNode: (self importWardleyMapNodeFrom: eachNodeDictionary) ] ]).
	
	(aDictionary at: #edges ifPresent: [ :theEdgeDictionaries |
		theEdgeDictionaries do: [ :eachEdgeDictionary |
			aWardleyMap addEdge: (self importWardleyMapEdgeFrom: eachEdgeDictionary map: aWardleyMap) ] ]).
	
	^ aWardleyMap
]

{ #category : #'api - importer' }
GtWardleyMapFromDictionaryImporter >> importWardleyMapNodeFrom: aDictionary [
	| aWardleyMapNode |

	aWardleyMapNode := GtWardleyMapNodeModel new.
	aDictionary
		at: #id
		ifPresent: [ :anId | aWardleyMapNode id: (self importIdFrom: anId) ].

	aDictionary
		at: #color
		ifPresent: [ :aColorDictionary | aWardleyMapNode color: (self importColorFrom: aColorDictionary) ].

	aDictionary at: #x ifPresent: [ :anX | aWardleyMapNode x: anX ].
	aDictionary at: #y ifPresent: [ :anY | aWardleyMapNode y: anY ].
	aDictionary at: #width ifPresent: [ :aWidth | aWardleyMapNode width: aWidth ].
	aDictionary at: #height ifPresent: [ :aHeight | aWardleyMapNode height: aHeight ].

	aDictionary
		at: #label
		ifPresent: [ :aLabelDictionary | aWardleyMapNode labelModel: (self importWardleyMapNodeLabelFrom: aLabelDictionary) ].

	^ aWardleyMapNode
]

{ #category : #'api - importer' }
GtWardleyMapFromDictionaryImporter >> importWardleyMapNodeLabelFrom: aDictionary [
	| aWardleyMapNodeLabel |
	
	aWardleyMapNodeLabel := GtWardleyMapNodeLabelModel new.
	
	aDictionary at: #x ifPresent: [ :anX | aWardleyMapNodeLabel x: anX ].
	aDictionary at: #y ifPresent: [ :anY | aWardleyMapNodeLabel y: anY ].
	aDictionary at: #text ifPresent: [ :aText | aWardleyMapNodeLabel label: aText ].

	^ aWardleyMapNodeLabel
]
