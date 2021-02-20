Class {
	#name : #GtWardleyMapAsDictionaryExporter,
	#superclass : #Object,
	#traits : 'TGtWardleyMapVisitor',
	#classTraits : 'TGtWardleyMapVisitor classTrait',
	#category : #'GToolkit-WardleyMap-Exporter/Importer'
}

{ #category : #visiting }
GtWardleyMapAsDictionaryExporter >> visitColor: aCcolor [
	^ Dictionary new
		at: #red put: aCcolor red;
		at: #green put: aCcolor green;
		at: #blue put: aCcolor blue;
		at: #alpha put: aCcolor alpha;
		yourself
]

{ #category : #visiting }
GtWardleyMapAsDictionaryExporter >> visitWardleyMap: aWardleyMap [
	^ OrderedDictionary new
		at: #nodes put: (aWardleyMap nodes collect: [ :eachNode | eachNode acceptVisitor: self ] as: Array);
		at: #edges put: (aWardleyMap edges collect: [ :eachEdge | eachEdge acceptVisitor: self ] as: Array);
		yourself
]

{ #category : #visiting }
GtWardleyMapAsDictionaryExporter >> visitWardleyMapEdge: aWardleyMapEdge [
	^ OrderedDictionary new
		at: #from put: aWardleyMapEdge fromNode id;
		at: #to put: aWardleyMapEdge toNode id;
		at: #color put: (self visitColor: aWardleyMapEdge color);
		at: #width put: aWardleyMapEdge width;
		yourself
]

{ #category : #visiting }
GtWardleyMapAsDictionaryExporter >> visitWardleyMapNode: aWardleyMapNode [
	^ OrderedDictionary new
		at: #id put: aWardleyMapNode id;
		at: #color put: (self visitColor: aWardleyMapNode color);
		at: #x put: aWardleyMapNode coordinate x;
		at: #y put: aWardleyMapNode coordinate y;
		at: #width put: aWardleyMapNode size x;
		at: #height put: aWardleyMapNode size y;
		at: #label put: (aWardleyMapNode labelModel acceptVisitor: self);
		yourself
]

{ #category : #visiting }
GtWardleyMapAsDictionaryExporter >> visitWardleyMapNodeLabel: aWardleyMapNodeLabel [
	^ OrderedDictionary new
		at: #x put: aWardleyMapNodeLabel coordinate x;
		at: #y put: aWardleyMapNodeLabel coordinate y;
		at: #text put: aWardleyMapNodeLabel label;
		yourself
]
