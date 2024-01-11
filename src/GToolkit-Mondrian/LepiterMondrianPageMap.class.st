"
I am a mondrian map of Lepiter pages, possibly with explicit positions.
Clicking on a node will open that page.

See {{gtClass:name=LepiterMondrianPageMapExamples}}.

Note that missing pages resolve to a String, not a page.
They show as pink instead of blue when hovering over them.
"
Class {
	#name : #LepiterMondrianPageMap,
	#superclass : #Object,
	#instVars : [
		'patternPageDict',
		'pageTitles',
		'database',
		'explicitPositions',
		'connections'
	],
	#category : #'GToolkit-Mondrian-Lepiter'
}

{ #category : #accessing }
LepiterMondrianPageMap class >> forPages: pageTitles inDatabase: aDatabase withConnections: pageConnections [
	^ self new
		pageTitles: pageTitles;
		database: aDatabase;
		connections: pageConnections;
		yourself
]

{ #category : #example }
LepiterMondrianPageMap >> connections [
	"Just the raw connections by page title."
	^ connections
]

{ #category : #accessing }
LepiterMondrianPageMap >> connections: pageConnections [
	connections := pageConnections
]

{ #category : #accessing }
LepiterMondrianPageMap >> database [
	^ database
]

{ #category : #accessing }
LepiterMondrianPageMap >> database: aLeDatabase [
	database := aLeDatabase
]

{ #category : #example }
LepiterMondrianPageMap >> explicitPositions [
	^ explicitPositions
]

{ #category : #accessing }
LepiterMondrianPageMap >> explicitPositions: aPointArray [
	"Explicit positions can be saved after manually laying out the map.
	(self root children collect: #position)"
	explicitPositions := aPointArray
]

{ #category : #accessing }
LepiterMondrianPageMap >> gtExplicitMapFor: aView [
	<gtView>
	self explicitPositions ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Explicit map';
		priority: 10;
		object: self pageMapWithExplicitPositions;
		view: #gtLiveFor:
]

{ #category : #accessing }
LepiterMondrianPageMap >> gtMapFor: aView [
	<gtView>
	^ aView forward
		title: 'Default map';
		priority: 20;
		object: self pageMap;
		view: #gtLiveFor:
]

{ #category : #accessing }
LepiterMondrianPageMap >> labelFor: aString [
	"Label for pages not found."

	^ BrLabel new
		text: aString;
		aptitude: BrGlamorousLabelAptitude new bold
				+ (BrStyleCommonAptitude new hovered: [ :aStyle | aStyle background: Color pink ]);
		padding: (BlInsets all: 5)
]

{ #category : #example }
LepiterMondrianPageMap >> pageDict [
	"If the page is missing, just return the string."
	^ patternPageDict
		ifNil: [ patternPageDict := (self pageTitles
					collect: [ :title | title -> (self database pageNamed: title ifAbsent: title) ])
					asOrderedDictionary ]
]

{ #category : #accessing }
LepiterMondrianPageMap >> pageFor: aTitle [
	^ self pageDict at: aTitle
]

{ #category : #example }
LepiterMondrianPageMap >> pageMap [
	| m |
	m := GtMondrian new.
	m nodes
		stencil: [ :page | 
			(page isKindOf: LePage)
				ifTrue: [ page asClickableLabel asStencil ]
				ifFalse: [ (self labelFor: page) asStencil ] ];
		with: self pages.
	m edges
		fromNearestBounds;
		toNearestBounds;
		stencil: [ :page | 
			BlLineElement new
				border: (BlBorder paint: Color gray);
				toHead: (BlArrowheadSimpleArrow new border: (BlBorder paint: Color gray)) ];
		connectToAll: [ :each | self pageMapEdges at: each ifAbsent: [ {} ] ].
	m layout tree levelDistance: 20.
	^ m
]

{ #category : #example }
LepiterMondrianPageMap >> pageMapEdges [
	^ (self connections
		collect: [ :each | (self pageFor: each key) -> (each value collect: [ :name | self pageFor: name ]) ])
		asDictionary
]

{ #category : #example }
LepiterMondrianPageMap >> pageMapWithExplicitPositions [
	"Redraw the pattern map with the explicitly saved positions."
	| m |
	m := self pageMap.
	m layout custom: BlBasicLayout new.
	m root children
		withIndexDo: [ :child :n | child relocate: (self explicitPositions at: n) ].
	^ m
]

{ #category : #example }
LepiterMondrianPageMap >> pageTitles [
	^ pageTitles
]

{ #category : #accessing }
LepiterMondrianPageMap >> pageTitles: aStringCollection [
	pageTitles := aStringCollection
]

{ #category : #example }
LepiterMondrianPageMap >> pages [
	"If the page is missing, just return the string."
	^ self pageDict values
]
