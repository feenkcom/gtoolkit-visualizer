Class {
	#name : #GtWardleyMapNodePropositionElement,
	#superclass : #BlElement,
	#traits : 'TGtWithWardleyMapNodeViewModel + TGtWithWardleyMapDecoratorViewModel',
	#classTraits : 'TGtWithWardleyMapNodeViewModel classTrait + TGtWithWardleyMapDecoratorViewModel classTrait',
	#instVars : [
		'nodeElement',
		'highlightColor'
	],
	#category : #'GToolkit-WardleyMap-! Views'
}

{ #category : #'private - updating' }
GtWardleyMapNodePropositionElement >> addLabelDecoration [
	nodeElement
		labelElementDo: [ :aContainer | 
			aContainer
				geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
				background: highlightColor ]
]

{ #category : #initialization }
GtWardleyMapNodePropositionElement >> beAddProposition [
	self highlightColor:  BrGlamorousColors successBackgroundColor.
]

{ #category : #initialization }
GtWardleyMapNodePropositionElement >> beChangeProposition [
	self highlightColor: BrGlamorousColors failureBackgroundColor.
]

{ #category : #initialization }
GtWardleyMapNodePropositionElement >> beEllipseGeometry [
	self geometry: BlEllipseGeometry new
]

{ #category : #initialization }
GtWardleyMapNodePropositionElement >> beRemoveProposition [
	self highlightColor: BrGlamorousColors errorBackgroundColor
]

{ #category : #initialization }
GtWardleyMapNodePropositionElement >> beSquareGeometry [
	self geometry: BlSquare new
]

{ #category : #accessing }
GtWardleyMapNodePropositionElement >> highlightColor: aColor [
	highlightColor := aColor.
	self background: highlightColor
]

{ #category : #initialization }
GtWardleyMapNodePropositionElement >> initialize [
	super initialize.
	self beEllipseGeometry.
	self beAddProposition.
	self size: GtWardleyMapConstants nodePropositionSize.
	self zIndex: GtWardleyMapConstants nodePropositionElevationIndex.
	self wardley beDecorator.
]

{ #category : #'api - node element' }
GtWardleyMapNodePropositionElement >> nodeElement [
	<return: #GtWardleyMapNodeElement>
	^ nodeElement
]

{ #category : #'api - node element' }
GtWardleyMapNodePropositionElement >> nodeElement: aNodeElement [
	self
		assert: [ nodeElement isNil ]
		description: [ 'Node element can be initialized only once' ].

	nodeElement := aNodeElement.
	
	self onNodeElementChanged.
]

{ #category : #'private - updating' }
GtWardleyMapNodePropositionElement >> onDecoratorRemoved [
	self removeLabelDecoration.
	self removeFromParent
]

{ #category : #'event handling' }
GtWardleyMapNodePropositionElement >> onDecoratorRemoved: anAnnouncement [
	BlTaskAction enqueueElement: self action: [ self onDecoratorRemoved ]
]

{ #category : #'api - node element' }
GtWardleyMapNodePropositionElement >> onNodeElementChanged [
	self addLabelDecoration
]

{ #category : #'api - node element' }
GtWardleyMapNodePropositionElement >> onNodeMoved [
	GtWardleyMapUtility
		updateNodeElement: self
		nodeViewModel: self wardleyMapNodeViewModel
]

{ #category : #'event handling' }
GtWardleyMapNodePropositionElement >> onNodeMoved: anAnnouncement [
	BlTaskAction enqueueElement: self action: [ self onNodeMoved ]
]

{ #category : #'event handling' }
GtWardleyMapNodePropositionElement >> onNodePipelineVisibilityChanged [
	self wardleyMapNodeViewModel isPipelineVisible
		ifTrue: [ self beSquareGeometry ]
		ifFalse: [ self beEllipseGeometry ]
]

{ #category : #'event handling' }
GtWardleyMapNodePropositionElement >> onNodePipelineVisibilityChanged: anAnnouncement [
	BlTaskAction enqueueElement: self action: [ self onNodePipelineVisibilityChanged ]
]

{ #category : #'event handling' }
GtWardleyMapNodePropositionElement >> onNodeRemoved [
	self removeLabelDecoration.
	self removeFromParent
]

{ #category : #'event handling' }
GtWardleyMapNodePropositionElement >> onNodeRemoved: anAnnouncement [
	BlTaskAction enqueueElement: self action: [ self onNodeRemoved ]
]

{ #category : #'event handling' }
GtWardleyMapNodePropositionElement >> onNodeResized [
	self size: self wardleyMapNodeViewModel nodeSize + GtWardleyMapConstants nodePropositionExtraSize
]

{ #category : #'event handling' }
GtWardleyMapNodePropositionElement >> onNodeResized: anAnnouncement [
	BlTaskAction enqueueElement: self action: [ self onNodeResized ]
]

{ #category : #'api - wardley map decorator model' }
GtWardleyMapNodePropositionElement >> onWardleyMapDecoratorViewModelChanged [
	"Is sent when a new wardleyMapDecorator view model is assigned to the element"

	
]

{ #category : #'api - wardley map node view model' }
GtWardleyMapNodePropositionElement >> onWardleyMapNodeViewModelChanged [
	"Is sent when a new WardleyMapNode view model is assigned to the element"
	
	self onNodeMoved.
	self onNodeResized.
	self onNodePipelineVisibilityChanged.
	
]

{ #category : #'private - updating' }
GtWardleyMapNodePropositionElement >> removeLabelDecoration [
	nodeElement
		labelElementDo: [ :aContainer | 
			aContainer
				geometry: BlRectangleGeometry new;
				background: BlBackground transparent ]
]

{ #category : #'api - wardley map decorator model' }
GtWardleyMapNodePropositionElement >> subscribeToWardleyMapDecoratorViewModel [
	"Is sent after a new wardleyMapDecorator view model is assigned to the element.
	It is required to unsubscribe from the view model by implementing
	#unsubscribeFromWardleyMapDecoratorViewModel if element subscribes to them"

	self wardleyMapDecoratorViewModel weak
		when: GtWardleyMapNodeDecoratorViewModelRemoved
		send: #onDecoratorRemoved: 
		to: self
]

{ #category : #'api - wardley map node view model' }
GtWardleyMapNodePropositionElement >> subscribeToWardleyMapNodeViewModel [
	"Is sent after a new WardleyMapNode view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromWardleyMapNodeViewModel if elements subscribe to them"
	
	self wardleyMapNodeViewModel weak
		when: GtWardleyMapNodeViewModelMoved send: #onNodeMoved: to: self;
		when: GtWardleyMapNodeViewModelResized send: #onNodeResized: to: self;
		when: GtWardleyMapNodeViewModelPipelineVisibilityChanged send: #onNodePipelineVisibilityChanged: to: self;
		when: GtWardleyMapNodeViewModelRemoved send: #onNodeRemoved: to: self
]

{ #category : #'api - wardley map decorator model' }
GtWardleyMapNodePropositionElement >> unsubscribeFromWardleyMapDecoratorViewModel [
	"Is sent before a new wardleyMapDecorator view model is assigned to the element.
	Elements that subscribe to wardleyMapDecorator view model are required to implement this methods"
	
	self wardleyMapDecoratorViewModel unsubscribe: self
]

{ #category : #'api - wardley map node view model' }
GtWardleyMapNodePropositionElement >> unsubscribeFromWardleyMapNodeViewModel [
	"Is sent before a new WardleyMapNode view model is assigned to the element.
	Elements that subscribe to WardleyMapNode view model in domain model are required to implement this methods"
	
	self wardleyMapNodeViewModel unsubscribe: self
]
