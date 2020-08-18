Class {
	#name : #GtConnector,
	#superclass : #BlElement,
	#instVars : [
		'stencil',
		'options'
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
	aLineElement toHead: (BlArrowheadSimpleArrow new
		border: (BlBorder builder paint: (Color gray alpha: 0.04); width: 10; build)).
	aLineElement constraints ignoreByLayout.
	aLineElement
		border: (BlBorder paint: (Color gray alpha: 0.04) width: 20);
		fromAnchor: (BlNearestPositionLooseCircleAnchor nearestTo:aTargetElement from: aSourceElement);
		toAnchor: (BlNearestPositionLooseCircleAnchor nearestTo: aSourceElement from: aTargetElement).
	
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
	
	self ensureRemoveVisualSourceHandlerFor: aSourceElement.
	self ensureRemoveVisualTargetHandlerFor: aTargetElement.
	
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

{ #category : #search }
GtConnector >> elementsVisualWithSource: aSource [
	"Return a collection of source elements whose source is a given object"
	<return: #SequenceableCollection of: #BlElement>

	^ Array streamContents: [ :aStream |
		self allChildrenBreadthFirstDo: [ :aChildElement |
			(aChildElement connector isVisualSource
				and: [ aChildElement connector modelContains: aSource ])
					ifTrue: [ aStream nextPut: aChildElement ] ] ]
]

{ #category : #search }
GtConnector >> elementsVisualWithTarget: aSource [
	"Return a collection of source elements whose source is a given object"
	<return: #SequenceableCollection of: #BlElement>

	^ Array streamContents: [ :aStream |
		self allChildrenBreadthFirstDo: [ :aChildElement |
			(aChildElement connector isVisualTarget
				and: [ aChildElement connector modelContains: aSource ])
					ifTrue: [ aStream nextPut: aChildElement ] ] ]
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

{ #category : #'private - adding / removing' }
GtConnector >> ensureLayoutLinkFrom: aSourceElement to: aTargetElement [	
	self
		assert: [ aSourceElement isNotNil ]
		description: [ 'Source element must not be nil' ].
	self
		assert: [ aTargetElement isNotNil ]
		description: [ 'Target element must not be nil' ].

	self ensureEdgeConstraitFrom: aSourceElement to: aTargetElement.
	
	self ensureRemoveLayoutSourceHandlerFor: aSourceElement.
	self ensureRemoveLayoutTargetHandlerFor: aTargetElement.
	
	(aSourceElement isConnectedTo: aTargetElement) ifFalse: [ 
		self addEdgeLineFrom: aSourceElement to: aTargetElement ].

	self requestLayout
]

{ #category : #'private - event handling' }
GtConnector >> ensureRemoveLayoutSourceHandlerFor: anElement [ 
	| eventHandler |
	self assert: [ anElement connector isLayoutSource ].

	(self 
		hasElement: anElement 
		eventHandlerWithId: #removeLayoutSource) ifTrue: [ ^ self ].
	
	eventHandler := GtConnectorEventHandler 
		on: GtConnectorLayoutSourceElementRemovedEvent 
		do: [ :anEvent | 
			self emitSignalForEvent: anEvent.
			self removeEdgeConstraintsFrom: anEvent element.
			self removeLinesFrom: anEvent element.
			self requestLayout ].
	eventHandler id: #removeLayoutSource.
	
	anElement addEventHandler: eventHandler.
]

{ #category : #'private - event handling' }
GtConnector >> ensureRemoveLayoutTargetHandlerFor: anElement [
	| eventHandler |
	self assert: [ anElement connector isLayoutTarget ].

	(self 
		hasElement: anElement 
		eventHandlerWithId: #removeLayoutTarget) ifTrue: [ ^ self ].
		
	eventHandler := GtConnectorEventHandler 
		on: GtConnectorLayoutTargetElementRemovedEvent 
		do: [ :anEvent | 
			self emitSignalForEvent: anEvent.
			self removeEdgeConstraintsTo: anEvent element.
			self removeLinesTo: anEvent element.
			self requestLayout ].
	eventHandler id: #removeLayoutTarget.
	
	anElement addEventHandler: eventHandler.
]

{ #category : #'private - event handling' }
GtConnector >> ensureRemoveVisualSourceHandlerFor: anElement [
	| eventHandler |
	self assert: [ anElement connector isVisualSource ].

	(self 
		hasElement: anElement 
		eventHandlerWithId: #removeVisualSource) ifTrue: [ ^ self ].
		
	eventHandler := GtConnectorEventHandler 
		on: GtConnectorVisualSourceElementRemovedEvent 
		do: [ :anEvent | 
			self emitSignalForEvent: anEvent.
			self removeLinesFrom: anEvent element ].
	eventHandler id: #removeVisualSource.
	
	anElement addEventHandler: eventHandler.
]

{ #category : #'private - event handling' }
GtConnector >> ensureRemoveVisualTargetHandlerFor: anElement [
	| eventHandler |
	self assert: [ anElement connector isVisualTarget ].

	(self 
		hasElement: anElement 
		eventHandlerWithId: #removeVisualTarget) ifTrue: [ ^ self ].
	
	eventHandler := GtConnectorEventHandler 
		on: GtConnectorVisualTargetElementRemovedEvent 
		do: [ :anEvent | 
			self emitSignalForEvent: anEvent.
			self removeLinesTo: anEvent element ].
	eventHandler id: #removeVisualTarget.
	
	anElement addEventHandler: eventHandler.
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
	^ (super gtLiveFor: aView) 
		stencil: [ 
			self space
				ifNotNil: [ BrEditorElement new 
					editor: (BrTextEditor new
						text: (self printString, ' element cannot be currently displayed here as it is already displayed in another view') asRopedText readonly);
					constraintsDo: [ :c | 
						c horizontal matchParent.
						c vertical matchParent ]  ]
				ifNil: [ self asScalableElement ] ]
]

{ #category : #utils }
GtConnector >> hasElement: anElement eventHandlerWithId: anId [
	^ anElement eventDispatcher handlers anySatisfy: [ :each |
		(each isKindOf: GtConnectorEventHandler) and: [ 
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

	self layout: (GtGradHorizontalTreeLayout new levelDistance: 200; nodeDistance: 40).
	self options: GtConnectorOptions new.
	self initializeListeners
]

{ #category : #initialization }
GtConnector >> initializeListeners [
	self when: GtConnectorVisualSourceElementAddedEvent do: [ :anEvent | 
		self emitSignalForEvent: anEvent.
		self drawLinesFromVisualSource: anEvent element.
		self linkLayoutSource: anEvent element ].
	
	self when: GtConnectorVisualTargetElementAddedEvent do: [ :anEvent | 
		self emitSignalForEvent: anEvent.
		self drawLinesToVisualTarget: anEvent element.
		self linkLayoutTarget: anEvent element ]
]

{ #category : #accessing }
GtConnector >> lineElements [
	"Return a collection of existing line element from the connector"
	<return: #SequenceableCollection of: #BlElement>

	^ self children select: [ :anElement | 
		anElement isKindOf: BlCurveElement ]
]

{ #category : #private }
GtConnector >> linkLayoutSource: anElement [
	"I create a logical edge between elements (not visible)"
	| sourceLayoutElement |
	self
		assert: [ anElement userData includesKey: #connector  ]
		description: [ 'The element must have a connector' ].
	self assert: [ anElement connector isVisualSource ].
	
	sourceLayoutElement := self goUpToSourceLayoutElement: anElement.
	anElement connector modelDo: [ :modelObject |
		(self elementsVisualWithTarget: modelObject) do: [ :layoutTarget |
			| targetLayoutElement |
			targetLayoutElement := self goUpToTargetLayoutElement: layoutTarget.
			self ensureLayoutLinkFrom: sourceLayoutElement to: targetLayoutElement ] ]
]

{ #category : #private }
GtConnector >> linkLayoutTarget: anElement [
	"I create a logical edge between elements (not visible)"
	| targetLayoutElement |
	self
		assert: [ anElement userData includesKey: #connector  ]
		description: [ 'The element must have a connector' ].
	self assert: [ anElement connector isVisualTarget ].
	
	targetLayoutElement := self goUpToTargetLayoutElement: anElement.
	anElement connector modelDo: [ :modelObject | 
		(self elementsVisualWithSource: modelObject) do: [ :layoutSource |
			| sourceLayoutElement |
			sourceLayoutElement := self goUpToSourceLayoutElement: layoutSource.
			self ensureLayoutLinkFrom: sourceLayoutElement to: targetLayoutElement ] ]
]

{ #category : #accessing }
GtConnector >> options [ 
	^ options 
]

{ #category : #accessing }
GtConnector >> options: anOptionsObject [
	options := anOptionsObject.
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
GtConnector >> sourceElementsWith: aTarget [
	"Return a collection of target elements whose source is a given object"
	<return: #SequenceableCollection of: #BlElement>

	^ Array streamContents: [ :aStream |
		self allChildrenBreadthFirstDo: [ :aChildElement |
			(aChildElement connector isVisualSource
				and: [ aChildElement connector modelContains: aTarget ])
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
GtConnector >> targetElementsWith: aTarget [
	"Return a collection of target elements whose target is a given object"
	<return: #SequenceableCollection of: #BlElement>

	^ Array streamContents: [ :aStream |
		self allChildrenBreadthFirstDo: [ :aChildElement |
			(aChildElement connector isVisualTarget
				and: [ aChildElement connector modelContains: aTarget ])
					ifTrue: [ aStream nextPut: aChildElement ]]]
]
