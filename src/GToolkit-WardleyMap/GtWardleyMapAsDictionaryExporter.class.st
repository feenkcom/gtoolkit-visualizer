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
GtWardleyMapAsDictionaryExporter >> visitWardleyMap: aWardleyMap [
	^ OrderedDictionary new
		at: #nodes put: (aWardleyMap nodes collect: [ :eachNode | eachNode accept: self ] as: Array);
		at: #edges put: (aWardleyMap edges collect: [ :eachEdge | eachEdge accept: self ] as: Array);
		yourself
]

{ #category : #visiting }
GtWardleyMapAsDictionaryExporter >> visitWardleyMapEdge: aWardleyMapEdge [
	^ OrderedDictionary new
		at: #from put: aWardleyMapEdge fromNode id asString;
		at: #to put: aWardleyMapEdge toNode id asString;
		at: #color put: (self visitColor: aWardleyMapEdge color);
		at: #width put: aWardleyMapEdge width;
		at: #arrow put: aWardleyMapEdge arrow;
		yourself
]

{ #category : #visiting }
GtWardleyMapAsDictionaryExporter >> visitWardleyMapNode: aWardleyMapNode [
	^ OrderedDictionary new
		at: #id put: aWardleyMapNode id asString;
		at: #color put: (self visitColor: aWardleyMapNode color);
		at: #x put: aWardleyMapNode x;
		at: #y put: aWardleyMapNode y;
		at: #width put: aWardleyMapNode width;
		at: #height put: aWardleyMapNode height;
		at: #label put: (aWardleyMapNode labelModel accept: self);
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
