Class {
	#name : #GtConnector,
	#superclass : #BlElement,
	#instVars : [
		'stencil',
		'referencedEntitiesBlock',
		'options',
		'entityEventHandler',
		'connectorEventHandler'
	],
	#category : #'GToolkit-Connector-Core'
}

{ #category : #'private - adding / removing' }
GtConnector >> addEdgeLineFrom: aSourceElement to: aTargetElement [
	"Add a line connecting two given elements."
	| aLineElement |
	
	self
		assert: [ aSourceElement isNotNil ]
		description: [ 'Source element must not be nil' ].
	self
		assert: [ aTargetElement isNotNil ]
		description: [ 'Target element must not be nil' ].
	self
		assert: [ (aSourceElement isConnectedTo: aTargetElement) not ]
		description: [ 'Source must not be connected to the target' ].
	self
		assert: [ (aTargetElement isConnectedTo: aSourceElement) not ]
		description: [ 'Target must not be connected to the source' ].
	self
		assert: [ aSourceElement ~~ aTargetElement ]
		description: [ 'Can not connect element with itself' ].
	self
		assert: [ self doesExist: aSourceElement ]
		description: [ 'Source element must be in the scene graph' ].
	self
		assert: [ self doesExist: aTargetElement ]
		description: [ 'Target element must be in the scene graph' ].

	aLineElement := BlParabollaArcElement new.
	aLineElement curvatureFraction: 0.01.
	aLineElement zIndex: -10.
	aLineElement constraints ignoreByLayout.
	aLineElement
		border: (BlBorder paint: (Color lightGray alpha: 0.08) width: 10);
		fromAnchor: (BlNearestPositionBoundsAnchor nearestTo:aTargetElement from: aSourceElement);
		toAnchor: (BlNearestPositionBoundsAnchor nearestTo: aSourceElement from: aTargetElement).
	aLineElement toHead: (BlArrowheadSimpleArrow new
		border: (BlBorder paint: (Color lightGray alpha: 0.08) width: 10)).
	
	aLineElement connectorEdge 
		fromElement: aSourceElement;
		toElement: aTargetElement.
	aSourceElement beConnectedTo: aTargetElement.
	aTargetElement beConnectedTo: aSourceElement.

	self addChild: aLineElement.
	
]

{ #category : #public }
GtConnector >> addEntity: anEntity [
	"Create a new element for the given entity, add it to the scene. 
	Conector also accepts nil as an entity."
	(self hasOpenedEntity: anEntity)
		ifTrue: [ ^ self ].

	self createAndAddElementForEntity: anEntity.
]

{ #category : #'private - adding / removing' }
GtConnector >> addVisualLineFrom: aSourceElement to: aTargetElement [
	"Add a line connecting two given elements."
	| aLineElement |
	
	self
		assert: [ aSourceElement isNotNil ]
		description: [ 'Source element must not be nil' ].
	self
		assert: [ aTargetElement isNotNil ]
		description: [ 'Target element must not be nil' ].
	self
		assert: [ (aSourceElement isConnectedTo: aTargetElement) not ]
		description: [ 'Source must not be connected to the target' ].
	self
		assert: [ (aTargetElement isConnectedTo: aSourceElement) not ]
		description: [ 'Target must not be connected to the source' ].
	self
		assert: [ aSourceElement ~~ aTargetElement ]
		description: [ 'Can not connect element with itself' ].

	self
		assert: [ self doesExist: aSourceElement ]
		description: [ 'Source element must be in the scene graph' ].
		
	self
		assert: [ self doesExist: aTargetElement ]
		description: [ 'Target element must be in the scene graph' ].

	aLineElement := BlParabollaArcElement new.
	aLineElement curvatureFraction: 0.2.
	aLineElement zIndex: 10.
	aLineElement toHead: (BlArrowheadSimpleArrow new
					border: (BlBorder builder paint: (Color gray alpha: 0.2); width: 5; build)).
	aLineElement constraints ignoreByLayout.
	aLineElement
		border: (BlBorder paint: (Color gray alpha: 0.2) width: 5);
		fromAnchor: (BlElementCenterRightAnchor element: aSourceElement);
		toAnchor: (BlElementCenterLeftAnchor element: aTargetElement).
	
	aLineElement connectorEdge 
		fromElement: aSourceElement;
		toElement: aTargetElement.
	aSourceElement connector beConnectedTo: aTargetElement.
	aTargetElement connector beConnectedTo: aSourceElement.
	
	self ensureEntityHandlerFor: aSourceElement.
	self ensureEntityHandlerFor: aTargetElement.
	
	self addChild: aLineElement
	"self options drawLines ifTrue: [ self addChild: aLineElement ]"
	
	
]

{ #category : #converting }
GtConnector >> asScalableElement [
	| scalable |
	scalable := BlScalableElement new.
	scalable
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
	scalable contentElement: self.
	^ scalable
]

{ #category : #private }
GtConnector >> createAndAddElementForEntity: anEntity [
	"Open a given entity without connecting it to other"	
	| entityElement |	
	
	self
		assert: [ self stencil isNotNil ]
		description: [ 'Stencil describing each entity can not be nil' ].
	self
		assert: [ (self hasOpenedEntity: anEntity) not ]
		description: [ 'Can not open already opened enity' ].
	
	entityElement := self stencil value: anEntity.
	entityElement graph beNode.
	
	self
		assert: [ entityElement userData includesKey: #connector  ]
		description: [ 'The element must have a connector' ].
	self 
		assert: [ entityElement connector hasModel  ] 
		description: 'Elements placed within connector should have an explicit model'.
	self 
		assert: [ entityElement connector modelContains: anEntity ] 
		description: 'Elements placed within connector should the given entity as a model'.
	self addChild: entityElement.

	^ entityElement
]

{ #category : #testing }
GtConnector >> doesExist: anElement [
	^ (anElement hasParent: self) or: [ anElement isAttachedToSceneGraph ]
]

{ #category : #private }
GtConnector >> drawLinesFromVisualSource: anElement [
	self assert: [ anElement connector isVisualSource ].
	
	(self targetElementsWith: anElement connector model)
		select: [ :aTargetElement |  (anElement isConnectedTo: aTargetElement) not 
			and: [ (self doesExist: aTargetElement)
				and: [ (self doesExist: anElement) ] ] ]
		thenDo: [ :aTargetElement | self addVisualLineFrom: anElement to: aTargetElement ]
]

{ #category : #private }
GtConnector >> drawLinesToVisualTarget: anElement [
	self assert: [ anElement connector isVisualTarget ].
	
	(self sourceElementsWith: anElement connector model)
		select: [ :aSourceElement |  (aSourceElement isConnectedTo: anElement) not 
			and: [ (self doesExist: aSourceElement)
				and: [ (self doesExist: anElement) ] ] ]
		thenDo: [ :aSourceElement | self addVisualLineFrom: aSourceElement to: anElement ] 
]

{ #category : #search }
GtConnector >> elementWithEntity: anEntity ifPresent: aBlock [
	"Search for an element containg a given entity
	and evaluate aBlock with it as argument if such an element is found.
	Note: we don't make any assumptions on the type of anEntity object,
	it might be any custom domain object that implements a `=` comparison method"

	self entityElements 
		detect: [ :anEntityElement | 
			anEntityElement connector modelContains: anEntity ]
		ifFound: [ :anEditorElement | 
			aBlock cull: anEditorElement ]
]

{ #category : #logging }
GtConnector >> emitSignalForEvent: anEvent [
	GtConnectorEventSignal new 
		event: anEvent;
		emit
]

{ #category : #'private - adding / removing' }
GtConnector >> ensureEdgeConstraitFrom: aSourceElement to: aTargetElement [
	"Ensure there is a graph edge between the two given elements."
	| hasEdge newEdge |
	
	self assert: [ aSourceElement isNotNil ].
	self assert: [ aTargetElement isNotNil ].
		
	hasEdge := aSourceElement constraints graph connectedEdges 
		anySatisfy: [ :currentEdge | 
			currentEdge fromElement = aSourceElement and: [ 
				currentEdge toElement = aTargetElement ] ].
	hasEdge ifTrue: [ ^ self ].
	
	newEdge := GtGraphEdge new
		from: aSourceElement
		to: aTargetElement.
	aSourceElement constraints graph addConnectedEdge: newEdge.
	aTargetElement constraints graph addConnectedEdge: newEdge.
]

{ #category : #'private - event handling' }
GtConnector >> ensureEntityHandlerFor: anElement [
	
	anElement removeEventHandler: entityEventHandler.
	anElement addEventHandler: entityEventHandler
]

{ #category : #'private - adding / removing' }
GtConnector >> ensureLayoutLinkFrom: aSourceElement to: aTargetElement [	
	self
		assert: [ aSourceElement isNotNil ]
		description: [ 'Source element must not be nil' ].
	self
		assert: [ aTargetElement isNotNil ]
		description: [ 'Target element must not be nil' ].
	
	self ensureEdgeConstraitFrom: aSourceElement to: aTargetElement.
	
	self ensureEntityHandlerFor: aSourceElement.
	self ensureEntityHandlerFor: aTargetElement.
	
	(aSourceElement isConnectedTo: aTargetElement) ifFalse: [ 
		self addEdgeLineFrom: aSourceElement to: aTargetElement ].

	self requestLayout
]

{ #category : #accessing }
GtConnector >> entityElements [
	"Return a collection of existing elements that are already added to the tree"
	<return: #SequenceableCollection of: #BlElement>

	^ self children reject: [ :anElement | 
		anElement isKindOf: BlCurveElement ]
]

{ #category : #search }
GtConnector >> goUpToSourceLayoutElement: anElement [
	"I go up the BlElement containment heirarchy to find the first parent that is a layout target"
	| result |
	result := anElement.
	[result isNotNil and: [
		result connector isLayoutSource]
	] whileFalse: [ result := result parent ].
	^ result
]

{ #category : #search }
GtConnector >> goUpToTargetLayoutElement: anElement [
	"I go up the BlElement containment heirarchy to find the first parent that is a layout target"
	| result |
	result := anElement.
	[result isNotNil and: [
		result connector isLayoutTarget]
	] whileFalse: [ result := result parent ].
	^ result
]

{ #category : #'gt-extension' }
GtConnector >> gtLiveFor: aView [
	<gtView>
	^ (super gtLiveFor: aView) 
		stencil: [ 
			self space
				ifNotNil: [ BrEditorElement new 
					editor: (BrTextEditorModel new
						text: (self printString, ' element cannot be currently displayed here as it is already displayed in another view') asRopedText readonly);
					constraintsDo: [ :c | 
						c horizontal matchParent.
						c vertical matchParent ]  ]
				ifNil: [ self asScalableElement ] ]
]

{ #category : #'gt-extension' }
GtConnector >> gtOptionsFor: aView [
	<gtView>
	
	^ aView forward
		title: 'Options';
		priority: 0.5;
		object: [ self options ];
		view: #gtOptionsFor:
]

{ #category : #utils }
GtConnector >> hasElement: anElement eventHandlerWithId: anId [
	^ anElement eventDispatcher handlers anySatisfy: [ :each |
		(each isKindOf: GtConnectorEntityEventHandler) and: [ 
			each id = anId ] ]
	
]

{ #category : #testing }
GtConnector >> hasOpenedEntity: anEntity [
	"Return true if there already exists a connector element for the given entity, false otheriwse"
	<return: #Boolean>
	
	self elementWithEntity: anEntity ifPresent: [ ^ true ].
	^ false
]

{ #category : #initialization }
GtConnector >> initialize [
	super initialize.

	self constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent.
		c padding: (BlInsets all: 40) ].

	self layout: (GtGradHorizontalTreeLayout new levelDistance: 100; nodeDistance: 40).
	self options: GtConnectorOptions new.
	
	entityEventHandler := GtConnectorEntityEventHandler new connector: self.
	connectorEventHandler := GtConnectorEventHandler new connector: self.
	self addEventHandler: connectorEventHandler.
	
	referencedEntitiesBlock := [ :anEntity | #() ]
]

{ #category : #search }
GtConnector >> layoutSourceElementsConnectedTo: aTargetEntity [
	"Return a collection of layout source elements that could be connected to
	the given target entity for a visual target. There should be a connection:
	- there is a visible visual source with the same model;
	- there is no visible visual source but a layout source has a reference to the entity"
	<return: #SequenceableCollection of: #BlElement>

	^ (self layoutSourcesVisuallyConnectedTo: aTargetEntity),
	  (self layoutSourcesWithReferencesTo: aTargetEntity)
]

{ #category : #search }
GtConnector >> layoutSourcesVisuallyConnectedTo: aTargetEntity [
	"Return a collection of layout source elements connected with the given target entity. 
	They are connected if the layout source contains a visual source that has the given entity as a model."
	<return: #SequenceableCollection of: #BlElement>

	^ (self sourceElementsWith: aTargetEntity) collect: [ :aVisualSourceElement | 
			self goUpToSourceLayoutElement: aVisualSourceElement ] 
]

{ #category : #search }
GtConnector >> layoutSourcesWithReferencesTo: aTargetEntity [
	"Return a collection of layout source elements that reference the given entity."
	<return: #SequenceableCollection of: #BlElement>
	 
	^ self entityElements select: [ :anElement |
		| isReferenced |
		isReferenced := false.
		anElement connector modelDo: [ :aModel | 
			| referencedEntities |
			referencedEntities := self referencedEntitiesBlock value: aModel.
			isReferenced := referencedEntities includes: aTargetEntity ].
		isReferenced ]	
]

{ #category : #search }
GtConnector >> layoutTargetElementsConnectedTo: aSourceEntity [
	"Return a collection of layout target elements that could be connected to
	the given source entity for a visual source. There should be a connection:
	- there is a visible visual target with the same model"
	<return: #SequenceableCollection of: #BlElement>

	^ self layoutTargetsVisuallyConnectedTo: aSourceEntity
]

{ #category : #search }
GtConnector >> layoutTargetsVisuallyConnectedTo: aSourceEntity [
	"Return a collection of layout targets elements connected with the given source entity. 
	They are connected if the layout target contains a visual target that has the given entity as a model."
	<return: #SequenceableCollection of: #BlElement>

	^ (self targetElementsWith: aSourceEntity) collect: [ :aVisualTargetElement | 
			self goUpToTargetLayoutElement: aVisualTargetElement ]
]

{ #category : #accessing }
GtConnector >> lineElements [
	"Return a collection of existing line element from the connector"
	<return: #SequenceableCollection of: #BlElement>

	^ self children select: [ :anElement | 
		anElement isKindOf: BlCurveElement ]
]

{ #category : #private }
GtConnector >> linkLayoutSourcesFor: anElement [
	"I create a logical edge between elements at the level of the layout"
	| layoutSourceElement |
	self
		assert: [ anElement userData includesKey: #connector  ]
		description: [ 'The element must have a connector' ].
	self assert: [ anElement connector isVisualSource ].
	
	layoutSourceElement := self goUpToSourceLayoutElement: anElement.
	anElement connector modelDo: [ :modelObject |
		(self layoutTargetElementsConnectedTo: modelObject) do: [ :layoutTargetElement |
			layoutSourceElement ~~ layoutTargetElement ifTrue: [
				self ensureLayoutLinkFrom: layoutSourceElement to: layoutTargetElement ] ] ]
]

{ #category : #private }
GtConnector >> linkLayoutTargetsFor: aVisualTarget [
	"I create a logical edge between elements at the level of the layout."
	| layoutTargetElement |
	self
		assert: [ aVisualTarget userData includesKey: #connector  ]
		description: [ 'The element must have a connector' ].
	self assert: [ aVisualTarget connector isVisualTarget ].
	
	layoutTargetElement := self goUpToTargetLayoutElement: aVisualTarget.
	aVisualTarget connector modelDo: [ :modelObject | 
		(self layoutSourceElementsConnectedTo: modelObject) do: [ :layoutSourceElement |
			layoutSourceElement ~~ layoutTargetElement ifTrue: [
				self ensureLayoutLinkFrom: layoutSourceElement to: layoutTargetElement ] ] ]
]

{ #category : #accessing }
GtConnector >> options [
	<return: #GtConnectorOptions>

	^ options 
]

{ #category : #accessing }
GtConnector >> options: anOptionsObject [
	options := anOptionsObject
]

{ #category : #public }
GtConnector >> referencedEntities: aBlock [ 
	referencedEntitiesBlock := aBlock
]

{ #category : #accessing }
GtConnector >> referencedEntitiesBlock [
	^ referencedEntitiesBlock
]

{ #category : #'private - adding / removing' }
GtConnector >> removeAndDisconnectEdge: anEdge [
	self assert: [ anEdge isNotNil ].
	
	anEdge fromElement constraints graph removeConnectedEdge: anEdge.
	anEdge toElement constraints graph removeConnectedEdge: anEdge.
]

{ #category : #'private - adding / removing' }
GtConnector >> removeAndDisconnectLineElement: aLineElement [
	| sourceElement targetElement |
	self assert: [ aLineElement isNotNil ].

	sourceElement := aLineElement connectorEdge fromElement.
	targetElement := aLineElement connectorEdge toElement.
	sourceElement beNotConnectedTo: targetElement.
	targetElement beNotConnectedTo: sourceElement.
	aLineElement removeFromParent.
]

{ #category : #'private - adding / removing' }
GtConnector >> removeEdgeConstraintsFrom: sourceElement [
	self assert: [ sourceElement isNotNil ].
	self assert: [ sourceElement connector isLayoutSource ].
	
	sourceElement constraints graph outgoingEdges do: [ :anEdge |
		self removeAndDisconnectEdge: anEdge ]
]

{ #category : #'private - adding / removing' }
GtConnector >> removeEdgeConstraintsTo: targetElement [
	self assert: [ targetElement isNotNil ].
	self assert: [ targetElement connector isLayoutTarget ].
	
	targetElement constraints graph incomingEdges do: [ :anEdge |
		self removeAndDisconnectEdge: anEdge ]
]

{ #category : #'private - adding / removing' }
GtConnector >> removeLinesFrom: sourceElement [
	self assert: [ sourceElement isNotNil ].
	self assert: [ sourceElement connector isVisualSource or: [
		sourceElement connector isLayoutSource ] ].

	self lineElements
		select: [ :aLineElement |
			aLineElement connectorEdge fromElement = sourceElement ]
		thenDo: [ :aLineElement |
			self removeAndDisconnectLineElement: aLineElement ]
]

{ #category : #'private - adding / removing' }
GtConnector >> removeLinesTo: targetElement [
	self assert: [ targetElement isNotNil ].
	self assert: [ targetElement connector isVisualTarget or: [
		targetElement connector isLayoutTarget ] ].
	
	self lineElements
		select: [ :aLineElement |
			aLineElement connectorEdge toElement = targetElement ]
		thenDo: [ :aLineElement |
			self removeAndDisconnectLineElement: aLineElement ]
]

{ #category : #search }
GtConnector >> sourceElementsWith: anEntity [
	"Return a collection of visual source elements whose model is a given object."
	<return: #SequenceableCollection of: #BlElement>

	^ Array streamContents: [ :aStream |
		self allChildrenBreadthFirstDo: [ :aChildElement |
			(aChildElement connector isVisualSource
				and: [ aChildElement connector modelContains: anEntity ])
					ifTrue: [ aStream nextPut: aChildElement ] ] ]
]

{ #category : #accessing }
GtConnector >> stencil [ 
	^ stencil
]

{ #category : #public }
GtConnector >> stencil: aStencil [
	stencil := aStencil
]

{ #category : #search }
GtConnector >> targetElementsWith: anEntity [
	"Return a collection of visual target elements whose model is a given object"
	<return: #SequenceableCollection of: #BlElement>

	^ Array streamContents: [ :aStream |
		self allChildrenBreadthFirstDo: [ :aChildElement |
			(aChildElement connector isVisualTarget
				and: [ aChildElement connector modelContains: anEntity ])
					ifTrue: [ aStream nextPut: aChildElement ] ] ]
]

{ #category : #search }
GtConnector >> visualSourceElementsWithModel: aSourceEntity [
	"Return a collection of source elements whose model is a given object"
	<return: #SequenceableCollection of: #BlElement>

	^ Array streamContents: [ :aStream |
		self allChildrenBreadthFirstDo: [ :aChildElement |
			(aChildElement connector isVisualSource
				and: [ aChildElement connector modelContains: aSourceEntity ])
					ifTrue: [ aStream nextPut: aChildElement ] ] ]
]

{ #category : #search }
GtConnector >> visualTargetElementsWithModel: aSource [
	"Return a collection of target elements whose model is a given object"
	<return: #SequenceableCollection of: #BlElement>

	^ Array streamContents: [ :aStream |
		self allChildrenBreadthFirstDo: [ :aChildElement |
			(aChildElement connector isVisualTarget
				and: [ aChildElement connector modelContains: aSource ])
					ifTrue: [ aStream nextPut: aChildElement ] ] ]
]
