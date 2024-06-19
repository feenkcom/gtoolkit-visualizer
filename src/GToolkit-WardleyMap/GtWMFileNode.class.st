Class {
	#name : #GtWMFileNode,
	#superclass : #GtWMProgramNode,
	#instVars : [
		'titles',
		'anchors',
		'elements',
		'evolves',
		'links',
		'annotations',
		'presentationAnnotations',
		'styles',
		'notes',
		'pipelines',
		'yAxises',
		'evolutions',
		'methods',
		'submaps',
		'urls',
		'attitudes',
		'markets',
		'ecosystems'
	],
	#category : #'GToolkit-WardleyMap-Parser'
}

{ #category : #generated }
GtWMFileNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitFile: self
]

{ #category : #generated }
GtWMFileNode >> anchors [
	^ anchors
]

{ #category : #generated }
GtWMFileNode >> anchors: anOrderedCollection [
	self setParents: self anchors to: nil.
	anchors := anOrderedCollection.
	self setParents: self anchors to: self
]

{ #category : #generated }
GtWMFileNode >> annotations [
	^ annotations
]

{ #category : #generated }
GtWMFileNode >> annotations: anOrderedCollection [
	self setParents: self annotations to: nil.
	annotations := anOrderedCollection.
	self setParents: self annotations to: self
]

{ #category : #converting }
GtWMFileNode >> asWardleyMapModel [
	| model nodes |
	nodes := Dictionary new.
	model := GtWardleyMapModel new.
	elements do: [ :each | each asWardleyMapNode ifNotNil: [ :node | nodes at: node label put: node ] ].
	markets do: [ :each | each asWardleyMapNode ifNotNil: [ :node | nodes at: node label put: node ] ].
	ecosystems do: [ :each | each asWardleyMapNode ifNotNil: [ :node | nodes at: node label put: node ] ].
	nodes do: [ :each | model addNode: each ].
	links
		do:
			[ :each | 
			nodes
				at: each start source
				ifPresent:
					[ :from | 
					nodes
						at: each end source
						ifPresent:
							[ :to | 
							model
								addEdge:
									((GtWardleyMapEdgeModel new)
										fromNode: from;
										toNode: to;
										yourself) ] ] ].
	^ model
]

{ #category : #generated }
GtWMFileNode >> attitudes [
	^ attitudes
]

{ #category : #generated }
GtWMFileNode >> attitudes: anOrderedCollection [
	self setParents: self attitudes to: nil.
	attitudes := anOrderedCollection.
	self setParents: self attitudes to: self
]

{ #category : #generated }
GtWMFileNode >> compositeNodeVariables [
	^ #(#titles #evolutions #anchors #elements #evolves #links #annotations #presentationAnnotations #styles #notes #pipelines #yAxises #methods #submaps #urls #attitudes #markets #ecosystems)
]

{ #category : #generated }
GtWMFileNode >> ecosystems [
	^ ecosystems
]

{ #category : #generated }
GtWMFileNode >> ecosystems: anOrderedCollection [
	self setParents: self ecosystems to: nil.
	ecosystems := anOrderedCollection.
	self setParents: self ecosystems to: self
]

{ #category : #generated }
GtWMFileNode >> elements [
	^ elements
]

{ #category : #generated }
GtWMFileNode >> elements: anOrderedCollection [
	self setParents: self elements to: nil.
	elements := anOrderedCollection.
	self setParents: self elements to: self
]

{ #category : #generated }
GtWMFileNode >> evolutions [
	^ evolutions
]

{ #category : #generated }
GtWMFileNode >> evolutions: anOrderedCollection [
	self setParents: self evolutions to: nil.
	evolutions := anOrderedCollection.
	self setParents: self evolutions to: self
]

{ #category : #generated }
GtWMFileNode >> evolves [
	^ evolves
]

{ #category : #generated }
GtWMFileNode >> evolves: anOrderedCollection [
	self setParents: self evolves to: nil.
	evolves := anOrderedCollection.
	self setParents: self evolves to: self
]

{ #category : #converting }
GtWMFileNode >> gtLiveFor: aView [
	<gtView>
	
	^ (aView forward)
		title: 'Live';
		priority: 30;
		object: [ self asWardleyMapModel ];
		view: #gtLiveFor:
]

{ #category : #'gt - extensions' }
GtWMFileNode >> gtMapFor: aView [
	<gtView>
	^ aView forward
		title: 'Map';
		object: [ GtWardleyMapScriptImporter forString: self source ];
		view: #gtLiveFor:
]

{ #category : #'generated-initialize-release' }
GtWMFileNode >> initialize [
	super initialize.
	titles := OrderedCollection new: 2.
	evolutions := OrderedCollection new: 2.
	anchors := OrderedCollection new: 2.
	elements := OrderedCollection new: 2.
	evolves := OrderedCollection new: 2.
	links := OrderedCollection new: 2.
	annotations := OrderedCollection new: 2.
	presentationAnnotations := OrderedCollection new: 2.
	styles := OrderedCollection new: 2.
	notes := OrderedCollection new: 2.
	pipelines := OrderedCollection new: 2.
	yAxises := OrderedCollection new: 2.
	methods := OrderedCollection new: 2.
	submaps := OrderedCollection new: 2.
	urls := OrderedCollection new: 2.
	attitudes := OrderedCollection new: 2.
	markets := OrderedCollection new: 2.
	ecosystems := OrderedCollection new: 2.
]

{ #category : #generated }
GtWMFileNode >> links [
	^ links
]

{ #category : #generated }
GtWMFileNode >> links: anOrderedCollection [
	self setParents: self links to: nil.
	links := anOrderedCollection.
	self setParents: self links to: self
]

{ #category : #generated }
GtWMFileNode >> markets [
	^ markets
]

{ #category : #generated }
GtWMFileNode >> markets: anOrderedCollection [
	self setParents: self markets to: nil.
	markets := anOrderedCollection.
	self setParents: self markets to: self
]

{ #category : #generated }
GtWMFileNode >> methods [
	^ methods
]

{ #category : #generated }
GtWMFileNode >> methods: anOrderedCollection [
	self setParents: self methods to: nil.
	methods := anOrderedCollection.
	self setParents: self methods to: self
]

{ #category : #generated }
GtWMFileNode >> notes [
	^ notes
]

{ #category : #generated }
GtWMFileNode >> notes: anOrderedCollection [
	self setParents: self notes to: nil.
	notes := anOrderedCollection.
	self setParents: self notes to: self
]

{ #category : #generated }
GtWMFileNode >> pipelines [
	^ pipelines
]

{ #category : #generated }
GtWMFileNode >> pipelines: anOrderedCollection [
	self setParents: self pipelines to: nil.
	pipelines := anOrderedCollection.
	self setParents: self pipelines to: self
]

{ #category : #generated }
GtWMFileNode >> presentationAnnotations [
	^ presentationAnnotations
]

{ #category : #generated }
GtWMFileNode >> presentationAnnotations: anOrderedCollection [
	self setParents: self presentationAnnotations to: nil.
	presentationAnnotations := anOrderedCollection.
	self setParents: self presentationAnnotations to: self
]

{ #category : #generated }
GtWMFileNode >> styles [
	^ styles
]

{ #category : #generated }
GtWMFileNode >> styles: anOrderedCollection [
	self setParents: self styles to: nil.
	styles := anOrderedCollection.
	self setParents: self styles to: self
]

{ #category : #generated }
GtWMFileNode >> submaps [
	^ submaps
]

{ #category : #generated }
GtWMFileNode >> submaps: anOrderedCollection [
	self setParents: self submaps to: nil.
	submaps := anOrderedCollection.
	self setParents: self submaps to: self
]

{ #category : #generated }
GtWMFileNode >> titles [
	^ titles
]

{ #category : #generated }
GtWMFileNode >> titles: anOrderedCollection [
	self setParents: self titles to: nil.
	titles := anOrderedCollection.
	self setParents: self titles to: self
]

{ #category : #generated }
GtWMFileNode >> urls [
	^ urls
]

{ #category : #generated }
GtWMFileNode >> urls: anOrderedCollection [
	self setParents: self urls to: nil.
	urls := anOrderedCollection.
	self setParents: self urls to: self
]

{ #category : #generated }
GtWMFileNode >> yAxises [
	^ yAxises
]

{ #category : #generated }
GtWMFileNode >> yAxises: anOrderedCollection [
	self setParents: self yAxises to: nil.
	yAxises := anOrderedCollection.
	self setParents: self yAxises to: self
]
