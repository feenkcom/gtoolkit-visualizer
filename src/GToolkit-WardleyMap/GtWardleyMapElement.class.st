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
		'titleElement'
	],
	#category : #'GToolkit-WardleyMap-! Views'
}

{ #category : #accessing }
GtWardleyMapElement class >> withDefaultSections [
	| aWardleyMapElement |
	aWardleyMapElement := self withoutSections.
	aWardleyMapElement
		evolutionSections: {'genesis' . 'custom built' . 'product (+rental)' . 'commodity'}.
	^ aWardleyMapElement
]

{ #category : #accessing }
GtWardleyMapElement class >> withoutSections [
	| aWardleyMapElement aWardleyMap aWardleyMapViewModel |
	aWardleyMap := GtWardleyMapModel new.
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
	canvasContainer addChildFirst: (GtWardleyMapEvolutionAxisLayer new sections: aCollectionOfSections)
]

{ #category : #accessing }
GtWardleyMapElement >> hasEvolutionAxisLayer [
	^(self childAt: 1) class = GtWardleyMapEvolutionAxisLayer
]

{ #category : #initialization }
GtWardleyMapElement >> initialize [
	super initialize.

	titleElement := self createTitleElement.
	canvasContainer := self createCanvasContainer.
	canvasContainer addChild: (canvasElement := self createCanvasElement).

	self addChildren: { titleElement. canvasContainer }.

	self matchParent
]

{ #category : #'event handling' }
GtWardleyMapElement >> onAcceptNewTitleWish: aWish [ 
	self hasWardleyMapViewModel ifFalse: [ ^ self ].
	self wardleyMapViewModel title: aWish text asString
]

{ #category : #'event handling' }
GtWardleyMapElement >> onTitleChanged [
	titleElement text: self wardleyMapViewModel title
]

{ #category : #'event handling' }
GtWardleyMapElement >> onTitleVisibilityChanged [
	self wardleyMapViewModel isTitleVisible
		ifTrue: [ titleElement visibility: BlVisibility visible ]
		ifFalse: [ titleElement visibility: BlVisibility hidden ]
]

{ #category : #'api - wardley map view model' }
GtWardleyMapElement >> onWardleyMapViewModelChanged [
	"Is sent when a new WardleyMap view model is assigned to the element"
	
	self onTitleChanged.
	self onTitleVisibilityChanged.
	canvasElement wardleyMapViewModel: self wardleyMapViewModel.
]

{ #category : #'api - wardley map view model' }
GtWardleyMapElement >> subscribeToWardleyMapViewModel [
	"Is sent after a new WardleyMap view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromWardleyMapViewModel if elements subscribe to them"
	
	self wardleyMapViewModel weak
		when: GtWardleyMapViewModelTitleChanged send: #onTitleChanged to: self;
		when: GtWardleyMapViewModelTitleVisibilityChanged send: #onTitleVisibilityChanged to: self
]

{ #category : #'api - wardley map view model' }
GtWardleyMapElement >> unsubscribeFromWardleyMapViewModel [
	"Is sent before a new WardleyMap view model is assigned to the element.
	Elements that subscribe to WardleyMap view model in domain model are required to implement this methods"
	
	self wardleyMapViewModel unsubscribe: self
]
