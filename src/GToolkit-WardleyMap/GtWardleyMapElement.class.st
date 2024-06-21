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

	self addChildren: { titleElement. canvasContainer }.

	self matchParent
]

{ #category : #'event handling' }
GtWardleyMapElement >> onAcceptNewTitleWish: aWish [ 
	self hasWardleyMapViewModel ifFalse: [ ^ self ].
	self wardleyMapViewModel title: aWish text asString
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

{ #category : #accessing }
GtWardleyMapElement >> onMapDecoratorAdded: anAnnouncement [
	BlTaskAction
		enqueueElement: self
		action: [ anAnnouncement decoratorViewModel decorateMapElement: self ]
]

{ #category : #accessing }
GtWardleyMapElement >> onMapDecoratorsChanged [
	"For now we assume that decorator elements are added 
	either to this element, canvasContainer, or canvasElement.
	We cannot iterate over all elements, since we do not distinguish
	between map, edge, and node decorator elements."
	
	self childrenDo: [ :aChild |
		aChild wardley isDecorator ifTrue: [ aChild removeFromParent ] ].
	canvasContainer childrenDo: [ :aChild |
		aChild wardley isDecorator ifTrue: [ aChild removeFromParent ] ].
	canvasElement childrenDo: [ :aChild |
		aChild wardley isDecorator ifTrue: [ aChild removeFromParent ] ].
	
	self wardleyMapViewModel wardleyMapDecoratorViewModels do: [ :eachDecoratorViewModel | 
		eachDecoratorViewModel decorateMapElement: self ].
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
