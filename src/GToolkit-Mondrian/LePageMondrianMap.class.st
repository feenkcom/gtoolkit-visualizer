"
I am a mondrian map of Lepiter pages, possibly with explicit positions.
Clicking on a node will open that page.

See {{gtClass:name=LePageMondrianMapExamples}}.

Note that missing pages resolve to a String, not a page.
They show as pink instead of blue when hovering over them.
"
Class {
	#name : #LePageMondrianMap,
	#superclass : #Object,
	#instVars : [
		'database',
		'explicitPositions',
		'connections',
		'pageCategoriesAndTitles'
	],
	#category : #'GToolkit-Mondrian-Lepiter'
}

{ #category : #accessing }
LePageMondrianMap class >> forPages: pageTitles inDatabase: aDatabase withConnections: pageConnectionAssociations [
	^ self new
		pageTitles: pageTitles;
		database: aDatabase;
		connections: pageConnectionAssociations;
		yourself
]

{ #category : #example }
LePageMondrianMap >> connections [
	"Dictionary of connections by category and page title."
	^ connections
]

{ #category : #accessing }
LePageMondrianMap >> connections: pageConnectionAssociations [
	"connections := pageConnectionAssociations asDictionary"
	
	"Inject the missing categories when only the titles are supplied."

	connections := (pageConnectionAssociations
			collect: [ :assoc | 
				{''.
					assoc key}
					-> (assoc value
							collect: [ :each | 
								{''.
									each} ]) ]) asDictionary
]

{ #category : #accessing }
LePageMondrianMap >> connectionsWithCategories: pageConnectionAssociations [
	"Categories are supplied, so don't need to inject them."

	connections := pageConnectionAssociations asDictionary
]

{ #category : #accessing }
LePageMondrianMap >> database [
	^ database
]

{ #category : #accessing }
LePageMondrianMap >> database: aLeDatabase [
	database := aLeDatabase
]

{ #category : #example }
LePageMondrianMap >> explicitPositions [
	^ explicitPositions
]

{ #category : #accessing }
LePageMondrianMap >> explicitPositions: aPointArray [
	"Explicit positions can be saved after manually laying out the map.
	(self root children collect: #position)"
	explicitPositions := aPointArray
]

{ #category : #accessing }
LePageMondrianMap >> gtExplicitMapFor: aView [
	<gtView>
	self explicitPositions ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Explicit map';
		priority: 10;
		object: self pageMapWithExplicitPositions;
		view: #gtLiveFor:
]

{ #category : #accessing }
LePageMondrianMap >> gtMapFor: aView [
	<gtView>
	^ aView forward
		title: 'Default map';
		priority: 20;
		object: self pageMap;
		view: #gtLiveFor:
]

{ #category : #example }
LePageMondrianMap >> pageCategoriesAndTitles [
	^ pageCategoriesAndTitles
]

{ #category : #accessing }
LePageMondrianMap >> pageCategoriesAndTitles: aCategoryAndTitleCollection [
	"eg {{'(M) '.'Moldable Object'} ...}"
	pageCategoriesAndTitles := aCategoryAndTitleCollection
]

{ #category : #example }
LePageMondrianMap >> pageMap [
	| m |
	m := GtMondrian new.
	
	m nodes
		stencil: [ :categoryAndTitle | (LePageTitleLabelBuilder forCategory: categoryAndTitle first andTitle: categoryAndTitle second andDatabase: self database) build ];
		with: self pageCategoriesAndTitles.
		"
	m nodes
		stencil: [ :title | (LePageTitleLabelBuilder forTitle: title andDatabase: self database) build ];
		with: self pageTitles."
		
	m edges
		fromNearestBounds;
		toNearestBounds;
		stencil: [ :page | 
			BlLineElement new
				border: (BlBorder paint: Color gray);
				toHead: (BlArrowheadSimpleArrow new border: (BlBorder paint: Color gray)) ];
		connectToAll: [ :each | self connections at: each ifAbsent: [ {} ] ].
	m layout tree levelDistance: 20.
	^ m
]

{ #category : #example }
LePageMondrianMap >> pageMapWithExplicitPositions [
	"Redraw the pattern map with the explicitly saved positions."
	| m |
	m := self pageMap.
	m layout custom: BlBasicLayout new.
	m root children
		withIndexDo: [ :child :n | child relocate: (self explicitPositions at: n) ].
	^ m
]

{ #category : #example }
LePageMondrianMap >> pageTitles [
	^ pageCategoriesAndTitles collect: #second
]

{ #category : #accessing }
LePageMondrianMap >> pageTitles: aStringCollection [
	"Fill in empty categories"
	pageCategoriesAndTitles := aStringCollection
			collect: [ :title | 
				{''.
					title} ]
]
