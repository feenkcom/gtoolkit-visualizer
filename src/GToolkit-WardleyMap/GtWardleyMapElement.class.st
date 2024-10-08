"
#Wardley map
This is a renderer, visual editor adn exporter of Wardley Maps.
See [](https://en.wikipedia.org/wiki/Wardley_map) to learn more.
#Example
{{gtExample: GtWardleyMapModelExamples >> #newMapWithPipelineInnerNodes | noCode=true | previewHeight=500}}
"
Class {
	#name : #GtWardleyMapElement,
	#superclass : #BlElement,
	#traits : 'TGtWithWardleyMapViewModel + TBrLayoutResizable',
	#classTraits : 'TGtWithWardleyMapViewModel classTrait + TBrLayoutResizable classTrait',
	#instVars : [
		'canvasElement',
		'canvasContainer',
		'titleElement',
		'evolutionAxisElement'
	],
	#category : #'GToolkit-WardleyMap-! Views'
}

{ #category : #accessing }
GtWardleyMapElement class >> withDefaultSections [
	| aWardleyMapElement |
	aWardleyMapElement := self withoutSections.
	aWardleyMapElement wardleyMapViewModel isEvolutionAxisVisible: true.
	^ aWardleyMapElement
]

{ #category : #accessing }
GtWardleyMapElement class >> withoutSections [
	| aWardleyMapElement aWardleyMap aWardleyMapViewModel |
	aWardleyMap := GtWardleyMapModel new.
	aWardleyMap isEvolutionAxisVisible: false.
	aWardleyMapViewModel := GtWardleyMapViewModel new.
	aWardleyMapViewModel wardleyMapModel: aWardleyMap.
	aWardleyMapElement := self new.
	aWardleyMapElement wardleyMapViewModel: aWardleyMapViewModel.
	^ aWardleyMapElement
]

{ #category : #accessing }
GtWardleyMapElement >> canvasElement [
	^ canvasElement
]

{ #category : #initialization }
GtWardleyMapElement >> createCanvasContainer [
	^ BrFrame new matchParent
]

{ #category : #initialization }
GtWardleyMapElement >> createCanvasElement [
	^ GtWardleyMapCanvasElement new
]

{ #category : #initialization }
GtWardleyMapElement >> createEvolutionAxisElement [
	^ GtWardleyMapEvolutionAxisLayer new visibility: BlVisibility gone
]

{ #category : #initialization }
GtWardleyMapElement >> createTitleElement [
	^ BrEditableLabel new
		hFitContentLimited;
		vFitContent;
		aptitude: BrGlamorousRegularEditorAptitude new;
		visibility: BlVisibility hidden;
		constraintsDo: [ :c | c linear horizontal alignCenter ];
		when: BrEditorAcceptWish do: [ :aWish | self onAcceptNewTitleWish: aWish ];
		text: 'Title'
]

{ #category : #'private - updating' }
GtWardleyMapElement >> decorateEdgeViewModel: anEdgeViewModel withDecoratorViewModel: aDecoratorViewModel [
	| aDecoratorContext aEdgeElement aFromNodeElement aToNodeElement |
	aEdgeElement := canvasElement
			edgeViewFor: anEdgeViewModel
			ifFound: [ :anElement | anElement ]
			ifNone: [ ^ self ].
			
	aFromNodeElement := canvasElement
			nodeViewFor: anEdgeViewModel fromNodeViewModel
			ifFound: [ :anElement | anElement ]
			ifNone: [ ^ self ].

	aToNodeElement := canvasElement
			nodeViewFor: anEdgeViewModel toNodeViewModel
			ifFound: [ :anElement | anElement ]
			ifNone: [ ^ self ].

	aDecoratorContext := GtWardleyMapEdgeDecoratorContext new
			mapElement: self;
			mapViewModel: self wardleyMapViewModel;
			canvasContainer: canvasContainer;
			canvasElement: canvasElement;
			edgeViewModel: anEdgeViewModel;
			edgeElement: aEdgeElement;
			fromNodeElement: aFromNodeElement;
			toNodeElement: aToNodeElement;
			decoratorViewModel: aDecoratorViewModel.
			
	aDecoratorViewModel decorateEdgeElementInContext: aDecoratorContext
]

{ #category : #'private - updating' }
GtWardleyMapElement >> decorateMapViewModel: aMapViewModel withDecoratorViewModel: aDecoratorViewModel [
	| aDecoratorContext |
	aDecoratorContext := GtWardleyMapDecoratorContext new
			mapElement: self;
			mapViewModel: self wardleyMapViewModel;
			canvasContainer: canvasContainer;
			canvasElement: canvasElement;
			decoratorViewModel: aDecoratorViewModel.
	
	aDecoratorViewModel decorateMapElementInContext: aDecoratorContext
]

{ #category : #'private - updating' }
GtWardleyMapElement >> decorateNodeViewModel: aNodeViewModel withDecoratorViewModel: aDecoratorViewModel [
	| aDecoratorContext aNodeElement |
	aNodeElement := canvasElement
			nodeViewFor: aNodeViewModel
			ifFound: [ :anElement | anElement ]
			ifNone: [ ^ self ].

	aDecoratorContext := GtWardleyMapNodeDecoratorContext new
			mapElement: self;
			mapViewModel: self wardleyMapViewModel;
			canvasContainer: canvasContainer;
			canvasElement: canvasElement;
			nodeViewModel: aNodeViewModel;
			nodeElement: aNodeElement;
			decoratorViewModel: aDecoratorViewModel.
			
	aDecoratorViewModel decorateNodeElementInContext: aDecoratorContext
]

{ #category : #initialization }
GtWardleyMapElement >> defaultLayout [
	^ BlLinearLayout vertical
]

{ #category : #accessing }
GtWardleyMapElement >> evolutionSections: aCollectionOfSections [
	self deprecated: 'Map model support evolution sections. Use rather those methods.'.

	self hasWardleyMapViewModel ifTrue: [ 
			self wardleyMapViewModel evolutionSections: aCollectionOfSections.
			self wardleyMapViewModel isEvolutionAxisVisible: true.
			^ self ].

	evolutionAxisElement
		sections: aCollectionOfSections;
		visibility: BlVisibility visible
]

{ #category : #accessing }
GtWardleyMapElement >> hasEvolutionAxisLayer [
	^(self childAt: 1) class = GtWardleyMapEvolutionAxisLayer
]

{ #category : #initialization }
GtWardleyMapElement >> initialize [
	super initialize.

	titleElement := self createTitleElement.
	evolutionAxisElement := self createEvolutionAxisElement.
	canvasElement := self createCanvasElement.
	canvasContainer := self createCanvasContainer.
	canvasContainer addChild: evolutionAxisElement.
	canvasContainer addChild: canvasElement.

	self addChildren: {titleElement. canvasContainer}.

	self
		when: GtWardleyMapNodeElementAdded
		do: [ :anEvent | self onNodeElementAdded: anEvent ].
	self
		when: GtWardleyMapEdgeElementAdded
		do: [ :anEvent | self onEdgeElementAdded: anEvent ].
		
	self matchParent
]

{ #category : #'event handling' }
GtWardleyMapElement >> onAcceptNewTitleWish: aWish [ 
	self hasWardleyMapViewModel ifFalse: [ ^ self ].
	self wardleyMapViewModel title: aWish text asString
]

{ #category : #'event handling' }
GtWardleyMapElement >> onEdgeDecoratorAdded: anAnnouncement [
	BlTaskAction
		enqueueElement: self
		action: [ self
				decorateEdgeViewModel: anAnnouncement edgeViewModel
				withDecoratorViewModel: anAnnouncement decoratorViewModel ]
]

{ #category : #'event handling' }
GtWardleyMapElement >> onEdgeElementAdded: anEvent [
	| anEdgeViewModel |
	anEdgeViewModel := anEvent edgeViewModel.
	anEdgeViewModel wardleyMapDecoratorViewModels
		do: [ :aDecoratorViewModel | 
			self
				decorateEdgeViewModel: anEdgeViewModel
				withDecoratorViewModel: aDecoratorViewModel ]
]

{ #category : #'event handling' }
GtWardleyMapElement >> onEvolutionAxisVisibilityChanged: anAnnouncement [
	BlTaskAction
		enqueueElement: self
		action: [ self onEvolutionSectionsChanged ]
]

{ #category : #'event handling' }
GtWardleyMapElement >> onEvolutionSectionsChanged [
	self wardleyMapViewModel isEvolutionAxisVisible
		ifTrue: [ self updateEvolutionSectionsElement ]
		ifFalse: [ self removeEvolutionSectionsElement ]
]

{ #category : #'event handling' }
GtWardleyMapElement >> onEvolutionSectionsChanged: anAnnouncement [
	BlTaskAction enqueueElement: self action: [ self onEvolutionSectionsChanged ]
]

{ #category : #'event handling' }
GtWardleyMapElement >> onMapDecoratorAdded: anAnnouncement [
	BlTaskAction
		enqueueElement: self
		action: [ self
				decorateMapViewModel: anAnnouncement mapViewModel
				withDecoratorViewModel: anAnnouncement decoratorViewModel ]
]

{ #category : #'event handling' }
GtWardleyMapElement >> onMapDecoratorsChanged [
	self allChildrenBreadthFirstDoWhileTrue: [ :aChild | 
		aChild wardley isDecorator 
			ifTrue: [ aChild removeFromParent. false ]
			ifFalse: [ true ] ].
	
	self wardleyMapViewModel wardleyMapDecoratorViewModels do: [ :eachDecoratorViewModel | 
		self
			decorateMapViewModel: self wardleyMapViewModel
			withDecoratorViewModel: eachDecoratorViewModel  ].
	
	self wardleyMapViewModel nodeViewModels do: [ :eachNodeViewModel | 
		eachNodeViewModel wardleyMapDecoratorViewModels do: [ :eachDecoratorViewModel | 
			self 
				decorateNodeViewModel: eachNodeViewModel 
				withDecoratorViewModel: eachDecoratorViewModel ] ].
			
	self wardleyMapViewModel edgeViewModels do: [ :eachEdgeViewModel | 
		eachEdgeViewModel wardleyMapDecoratorViewModels do: [ :eachDecoratorViewModel | 
			self 
				decorateEdgeViewModel: eachEdgeViewModel 
				withDecoratorViewModel: eachDecoratorViewModel ] ]
]

{ #category : #'event handling' }
GtWardleyMapElement >> onNodeDecoratorAdded: anAnnouncement [
	BlTaskAction
		enqueueElement: self
		action: [ self
				decorateNodeViewModel: anAnnouncement nodeViewModel
				withDecoratorViewModel: anAnnouncement decoratorViewModel ]
]

{ #category : #'event handling' }
GtWardleyMapElement >> onNodeElementAdded: anEvent [
	| aNodeViewModel |
	aNodeViewModel := anEvent nodeViewModel.
	aNodeViewModel wardleyMapDecoratorViewModels
		do: [ :aDecoratorViewModel | 
			self
				decorateNodeViewModel: aNodeViewModel
				withDecoratorViewModel: aDecoratorViewModel ]
]

{ #category : #'event handling' }
GtWardleyMapElement >> onSpawnRequest: anAnnouncement [
	BlTaskAction
		enqueueElement: self
		action: [ self phlow spawnObject: anAnnouncement object ]
]

{ #category : #'event handling' }
GtWardleyMapElement >> onTitleChanged [
	titleElement text: self wardleyMapViewModel title
]

{ #category : #'event handling' }
GtWardleyMapElement >> onTitleChanged: anAnnouncement [
	BlTaskAction enqueueElement: self action: [ self onTitleChanged ]
]

{ #category : #'event handling' }
GtWardleyMapElement >> onTitleVisibilityChanged [
	self wardleyMapViewModel isTitleVisible
		ifTrue: [ titleElement visibility: BlVisibility visible ]
		ifFalse: [ titleElement visibility: BlVisibility hidden ]
]

{ #category : #'event handling' }
GtWardleyMapElement >> onTitleVisibilityChanged: anAnnouncement [
	BlTaskAction enqueueElement: self action: [ self onTitleVisibilityChanged ]
]

{ #category : #'api - wardley map view model' }
GtWardleyMapElement >> onWardleyMapViewModelChanged [
	"Is sent when a new WardleyMap view model is assigned to the element"

	self onTitleChanged.
	self onTitleVisibilityChanged.
	self onEvolutionSectionsChanged.
	canvasElement wardleyMapViewModel: self wardleyMapViewModel.
	self onMapDecoratorsChanged
]

{ #category : #'event handling' }
GtWardleyMapElement >> removeEvolutionSectionsElement [
	evolutionAxisElement visibility: BlVisibility gone
]

{ #category : #'api - wardley map view model' }
GtWardleyMapElement >> subscribeToWardleyMapViewModel [
	"Is sent after a new WardleyMap view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromWardleyMapViewModel if elements subscribe to them"

	self wardleyMapViewModel weak
		when: GtWardleyMapViewModelEvolutionSectionsChanged
			send: #onEvolutionSectionsChanged:
			to: self;
		when: GtWardleyMapViewModelEvolutionAxisVisibilityChanged
			send: #onEvolutionAxisVisibilityChanged:
			to: self;
		when: GtWardleyMapViewModelTitleChanged
			send: #onTitleChanged:
			to: self;
		when: GtWardleyMapViewModelTitleVisibilityChanged
			send: #onTitleVisibilityChanged:
			to: self;
		when: GtWardleyMapSpawnRequest
			send: #onSpawnRequest:
			to: self;
		when: GtWardleyMapDecoratorViewModelAdded
			send: #onMapDecoratorAdded:
			to: self;
		when: GtWardleyMapNodeDecoratorViewModelAdded
			send: #onNodeDecoratorAdded:
			to: self;
		when: GtWardleyMapEdgeDecoratorViewModelAdded
			send: #onEdgeDecoratorAdded:
			to: self
]

{ #category : #'api - wardley map view model' }
GtWardleyMapElement >> unsubscribeFromWardleyMapViewModel [
	"Is sent before a new WardleyMap view model is assigned to the element.
	Elements that subscribe to WardleyMap view model in domain model are required to implement this methods"
	
	self wardleyMapViewModel unsubscribe: self
]

{ #category : #'event handling' }
GtWardleyMapElement >> updateEvolutionSectionsElement [
	evolutionAxisElement 
		sections: self wardleyMapViewModel evolutionSections;
		visibility: BlVisibility visible
]
