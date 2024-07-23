Class {
	#name : #GtWardleyMapEdgePropositionElement,
	#superclass : #BlLineElement,
	#traits : 'TGtWithWardleyMapEdgeViewModel + TGtWithWardleyMapDecoratorViewModel',
	#classTraits : 'TGtWithWardleyMapEdgeViewModel classTrait + TGtWithWardleyMapDecoratorViewModel classTrait',
	#instVars : [
		'edgeElement',
		'highlightColor'
	],
	#category : #'GToolkit-WardleyMap-! Views'
}

{ #category : #'private - updating' }
GtWardleyMapEdgePropositionElement >> addLabelDecoration [
	edgeElement
		labelElementDo: [ :aContainer | 
			aContainer
				geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
				background: highlightColor ]
]

{ #category : #initialization }
GtWardleyMapEdgePropositionElement >> beAddProposition [
	self highlightColor: BrGlamorousColors successBackgroundColor.
]

{ #category : #initialization }
GtWardleyMapEdgePropositionElement >> beHighlight [
	self highlightColor: BrGlamorousColors failureBackgroundColor.
]

{ #category : #initialization }
GtWardleyMapEdgePropositionElement >> beRemoveProposition [
	self highlightColor: BrGlamorousColors errorBackgroundColor.
]

{ #category : #'api - edge' }
GtWardleyMapEdgePropositionElement >> edgeElement [
	^ edgeElement
]

{ #category : #'api - edge' }
GtWardleyMapEdgePropositionElement >> edgeElement: anEdgeElement [
	self
		assert: [ anEdgeElement isNotNil ]
		description: [ 'Edge element be non-nil' ].
	self
		assert: [ edgeElement isNil ]
		description: [ 'Edge element can be initialized only once' ].

	edgeElement := anEdgeElement.

	self onEdgeElementChanged
]

{ #category : #initialization }
GtWardleyMapEdgePropositionElement >> highlightColor: aColor [
	highlightColor := aColor.
	self
		border: (BlBorder
				paint: highlightColor
				width: GtWardleyMapConstants edgePropositionWidth)
]

{ #category : #initialization }
GtWardleyMapEdgePropositionElement >> initialize [
	super initialize.
	self beAddProposition.
	self zIndex: GtWardleyMapConstants edgePropositionElevationIndex.
	self wardley beDecorator
]

{ #category : #'event handling' }
GtWardleyMapEdgePropositionElement >> onDecoratorRemoved [
	self removeLabelDecoration.
	self removeFromParent
]

{ #category : #'event handling' }
GtWardleyMapEdgePropositionElement >> onDecoratorRemoved: anAnnouncement [
	BlTaskAction enqueueElement: self action: [ self onDecoratorRemoved ]
]

{ #category : #'event handling' }
GtWardleyMapEdgePropositionElement >> onEdgeArrowChanged [
	self
		toHead: (self wardleyMapEdgeViewModel hasLineArrow
				ifTrue: [ BlArrowheadSimpleArrow new
						arrowLengthFraction: 4;
						arrowNoseAngle: 50;
						background: highlightColor ]
				ifFalse: [ BlArrowheadNone new ])
]

{ #category : #'event handling' }
GtWardleyMapEdgePropositionElement >> onEdgeArrowChanged: anAnnouncement [
	BlTaskAction enqueueElement: self action: [ self onEdgeArrowChanged ]
]

{ #category : #'api - edge' }
GtWardleyMapEdgePropositionElement >> onEdgeElementChanged [
	self addLabelDecoration
]

{ #category : #'event handling' }
GtWardleyMapEdgePropositionElement >> onEdgeRemoved [
	self removeLabelDecoration.
	self removeFromParent
]

{ #category : #'event handling' }
GtWardleyMapEdgePropositionElement >> onEdgeRemoved: anAnnouncement [
	BlTaskAction enqueueElement: self action: [ self onEdgeRemoved ]
]

{ #category : #'event handling' }
GtWardleyMapEdgePropositionElement >> onEdgeResized [
	self
		border: (BlBorder
				paint: highlightColor
				width: self wardleyMapEdgeViewModel lineWidth
						+ GtWardleyMapConstants edgePropositionExtraWidth)
]

{ #category : #'event handling' }
GtWardleyMapEdgePropositionElement >> onEdgeResized: anAnnouncement [
	BlTaskAction enqueueElement: self action: [ self onEdgeResized ]
]

{ #category : #'api - wardley map decorator model' }
GtWardleyMapEdgePropositionElement >> onWardleyMapDecoratorViewModelChanged [
	"Is sent when a new wardleyMapDecorator view model is assigned to the element"

	
]

{ #category : #'api - wardley map edge view model' }
GtWardleyMapEdgePropositionElement >> onWardleyMapEdgeViewModelChanged [
	"Is sent when a new wardleyMapEdge view model is assigned to the element"
	
	self onEdgeResized.
	self onEdgeArrowChanged
]

{ #category : #'private - updating' }
GtWardleyMapEdgePropositionElement >> removeLabelDecoration [
	edgeElement
		labelElementDo: [ :aContainer | 
			aContainer
				geometry: BlRectangleGeometry new;
				background: BlBackground transparent ]
]

{ #category : #'api - wardley map decorator model' }
GtWardleyMapEdgePropositionElement >> subscribeToWardleyMapDecoratorViewModel [
	"Is sent after a new wardleyMapDecorator view model is assigned to the element.
	It is required to unsubscribe from the view model by implementing
	#unsubscribeFromWardleyMapDecoratorViewModel if element subscribes to them"

	self wardleyMapDecoratorViewModel weak
		when: GtWardleyMapEdgeDecoratorViewModelRemoved
		send: #onDecoratorRemoved:
		to: self
]

{ #category : #'api - wardley map edge view model' }
GtWardleyMapEdgePropositionElement >> subscribeToWardleyMapEdgeViewModel [
	"Is sent after a new wardleyMapEdge view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromWardleyMapEdgeViewModel if elements subscribe to them"
	
	self wardleyMapEdgeViewModel weak
		when: GtWardleyMapEdgeViewModelRemoved send: #onEdgeRemoved: to: self;
		when: GtWardleyMapEdgeViewModelResized send: #onEdgeResized: to: self;
		when: GtWardleyMapEdgeViewModelArrowChanged send: #onEdgeArrowChanged: to: self.
]

{ #category : #'api - wardley map decorator model' }
GtWardleyMapEdgePropositionElement >> unsubscribeFromWardleyMapDecoratorViewModel [
	"Is sent before a new wardleyMapDecorator view model is assigned to the element.
	Elements that subscribe to wardleyMapDecorator view model are required to implement this methods"

	self wardleyMapDecoratorViewModel unsubscribe: self
]

{ #category : #'api - wardley map edge view model' }
GtWardleyMapEdgePropositionElement >> unsubscribeFromWardleyMapEdgeViewModel [
	"Is sent before a new wardleyMapEdge view model is assigned to the element.
	Elements that subscribe to wardleyMapEdge view model in domain model are required to implement this methods"
	
	self wardleyMapEdgeViewModel unsubscribe: self
]
