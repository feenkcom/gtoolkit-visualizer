Class {
	#name : #GtWardleyMapAsDictionaryExporter,
	#superclass : #Object,
	#traits : 'TGtWardleyMapVisitor',
	#classTraits : 'TGtWardleyMapVisitor classTrait',
	#category : #'GToolkit-WardleyMap-Exporter/Importer'
}

{ #category : #visiting }
GtWardleyMapAsDictionaryExporter >> visitColor: aColor [
	^ Dictionary new
		at: #red put: aColor red;
		at: #green put: aColor green;
		at: #blue put: aColor blue;
		at: #alpha put: aColor alpha;
		yourself
]

{ #category : #visiting }
GtWardleyMapAsDictionaryExporter >> visitWardleyId: aUUID [
	^ aUUID asString
]

{ #category : #visiting }
GtWardleyMapAsDictionaryExporter >> visitWardleyMap: aWardleyMap [
	| aDictionary |
	aDictionary := OrderedDictionary new.

	aWardleyMap notes
		ifNotEmpty: [ :allNotes | 
			aDictionary
				at: #notes
				put: (allNotes collect: [ :eachNote | eachNote accept: self ] as: Array) ].

	^ aDictionary
		at: #nodes put: (aWardleyMap nodes collect: [ :eachNode | eachNode accept: self ] as: Array);
		at: #edges put: (aWardleyMap edges collect: [ :eachEdge | eachEdge accept: self ] as: Array);
		yourself
]

{ #category : #visiting }
GtWardleyMapAsDictionaryExporter >> visitWardleyMapEdge: aWardleyMapEdge [
	^ OrderedDictionary new
		at: #from put: (self visitWardleyId: aWardleyMapEdge fromNode id);
		at: #to put: (self visitWardleyId: aWardleyMapEdge toNode id);
		at: #color put: (self visitColor: aWardleyMapEdge color);
		at: #width put: aWardleyMapEdge width;
		at: #arrow put: aWardleyMapEdge arrow;
		at: #label put: (aWardleyMapEdge labelModel accept: self);
		yourself
]

{ #category : #visiting }
GtWardleyMapAsDictionaryExporter >> visitWardleyMapEdgeLabel: aWardleyMapEdgeLabel [
	^ OrderedDictionary new
		at: #x put: aWardleyMapEdgeLabel x;
		at: #y put: aWardleyMapEdgeLabel y;
		at: #is_visible put: aWardleyMapEdgeLabel isVisible;
		at: #text put: aWardleyMapEdgeLabel label;
		yourself
]

{ #category : #visiting }
GtWardleyMapAsDictionaryExporter >> visitWardleyMapNode: aWardleyMapNode [
	^ OrderedDictionary new
		at: #id put: (self visitWardleyId: aWardleyMapNode id);
		at: #color put: (self visitColor: aWardleyMapNode color);
		at: #x put: aWardleyMapNode x;
		at: #y put: aWardleyMapNode y;
		at: #width put: aWardleyMapNode width;
		at: #height put: aWardleyMapNode height;
		at: #label put: (aWardleyMapNode labelModel accept: self);
		at: #pipeline
			put: (Dictionary new
					at: #is_visible put: aWardleyMapNode isPipelineVisible;
					in: [ :theDictionary | 
						aWardleyMapNode isPipelineVisible ifTrue: [
							theDictionary
								at: #x put: aWardleyMapNode pipelineCoordinate x;
								at: #y put: aWardleyMapNode pipelineCoordinate y;
								at: #inner_nodes put: (aWardleyMapNode innerNodes collect: [ :each | self visitWardleyId: each id] as: Array) ] ];
					yourself);
		at: #evolve put: (Dictionary new
			at: #is_evolve_target put: aWardleyMapNode type isEvolveTargetType;
			in: [ :theDictionary | 
				aWardleyMapNode type isEvolveTargetType ifTrue: [
					theDictionary 
						at: #source_node 
						put: (self visitWardleyId: aWardleyMapNode type sourceNode id) ] ];
			yourself);
		yourself
]

{ #category : #visiting }
GtWardleyMapAsDictionaryExporter >> visitWardleyMapNodeLabel: aWardleyMapNodeLabel [
	^ OrderedDictionary new
		at: #x put: aWardleyMapNodeLabel x;
		at: #y put: aWardleyMapNodeLabel y;
		at: #text put: aWardleyMapNodeLabel label;
		yourself
]

{ #category : #visiting }
GtWardleyMapAsDictionaryExporter >> visitWardleyMapNote: aWardleyMapNote [
	^ OrderedDictionary new
		at: #id put: (self visitWardleyId: aWardleyMapNote id);
		at: #label put: (aWardleyMapNote label);
		at: #color put: (self visitColor: aWardleyMapNote color);
		at: #x put: aWardleyMapNote x;
		at: #y put: aWardleyMapNote y;
		yourself
]
