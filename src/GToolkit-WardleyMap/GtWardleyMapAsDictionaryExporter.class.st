Class {
	#name : #GtWardleyMapAsDictionaryExporter,
	#superclass : #Object,
	#traits : 'TGtWardleyMapVisitor',
	#classTraits : 'TGtWardleyMapVisitor classTrait',
	#instVars : [
		'isMaturityAndVisibilityExport'
	],
	#category : #'GToolkit-WardleyMap-Exporter/Importer'
}

{ #category : #initialization }
GtWardleyMapAsDictionaryExporter >> beMaturityAndVisibilityExport [
	"Export corresponding coordinates as maturity and visibility values.
	Note: maturity == x, visibility == 1 - y"

	isMaturityAndVisibilityExport := true
]

{ #category : #initialization }
GtWardleyMapAsDictionaryExporter >> beXYPositionExport [
	"Export corresponding coordinates as x and y values.
	Note: x == maturity, y == 1 - visibility"

	isMaturityAndVisibilityExport := false
]

{ #category : #initialization }
GtWardleyMapAsDictionaryExporter >> initialize [
	super initialize.
	self beXYPositionExport
]

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

	(aWardleyMap title = GtWardleyMapUtility defaultMapTitle 
		and: [ aWardleyMap isTitleVisible not ]) 
			ifFalse: [
				aDictionary 
					at: #title
					put: (OrderedDictionary new
						at: #text put: aWardleyMap title;
						at: #is_visible put: aWardleyMap isTitleVisible;
						yourself) ].
	
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
GtWardleyMapAsDictionaryExporter >> visitWardleyMapEvolve: aWardleyMapEvolve [
	^ OrderedDictionary new
		at: #maturity put: aWardleyMapEvolve maturity;
		at: #color put: (self visitColor: aWardleyMapEvolve color);
		at: #width put: aWardleyMapEvolve width;
		at: #height put: aWardleyMapEvolve height;
		at: #label put: (aWardleyMapEvolve labelModel accept: self);
		yourself
]

{ #category : #visiting }
GtWardleyMapAsDictionaryExporter >> visitWardleyMapEvolveLabel: aWardleyMapEvolveLabel [
	^ (self visitWardleyMapNodeLabel: aWardleyMapEvolveLabel)
		at: #is_visible put: aWardleyMapEvolveLabel isVisible;
		yourself
]

{ #category : #visiting }
GtWardleyMapAsDictionaryExporter >> visitWardleyMapNode: aWardleyMapNode [
	^ OrderedDictionary new
		at: #id put: (self visitWardleyId: aWardleyMapNode id);
		at: #color put: (self visitColor: aWardleyMapNode color);
		in: [ :theDictionary | 
			isMaturityAndVisibilityExport 
				ifTrue: [
					theDictionary
						at: #maturity put: aWardleyMapNode maturity;
						at: #visibility put: aWardleyMapNode visibility ]
				ifFalse: [
					theDictionary
						at: #x put: aWardleyMapNode x;
						at: #y put: aWardleyMapNode y ] ];
		at: #width put: aWardleyMapNode width;
		at: #height put: aWardleyMapNode height;
		at: #label put: (aWardleyMapNode labelModel accept: self);
		at: #pipeline
			put: (OrderedDictionary new
					at: #is_visible put: aWardleyMapNode isPipelineVisible;
					in: [ :theDictionary | 
						aWardleyMapNode isPipelineVisible ifTrue: [
							isMaturityAndVisibilityExport 
								ifTrue: [
									theDictionary
										at: #min_maturity put: aWardleyMapNode pipelineCoordinate x;
										at: #max_maturity put: aWardleyMapNode pipelineCoordinate y ]
								ifFalse: [
									theDictionary
										at: #x put: aWardleyMapNode pipelineCoordinate x;
										at: #y put: aWardleyMapNode pipelineCoordinate y ].
							theDictionary
								at: #inner_nodes put: (aWardleyMapNode innerNodes collect: [ :each | self visitWardleyId: each id] as: Array) ] ];
					yourself);
		at: #evolve put: (OrderedDictionary new
			at: #is_visible put: aWardleyMapNode isEvolveVisible;
			in: [ :theDictionary |
				aWardleyMapNode isEvolveVisible ifTrue: [
					(aWardleyMapNode evolveModel accept: self) 
						keysAndValuesDo: [ :aKey :aValue |
							theDictionary at: aKey put: aValue ] ] ];
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
		in: [ :theDictionary | 
			isMaturityAndVisibilityExport 
				ifTrue: [
					theDictionary
						at: #maturity put: aWardleyMapNote maturity;
						at: #visibility put: aWardleyMapNote visibility ]
				ifFalse: [
					theDictionary
						at: #x put: aWardleyMapNote x;
						at: #y put: aWardleyMapNote y ] ];
		yourself
]
