Class {
	#name : #GtGenericConnector,
	#superclass : #BlElement,
	#instVars : [
		'stylerDoneListener',
		'stylerListener',
		'stencil'
	],
	#category : #'GToolkit-Connector'
}

{ #category : #'private - adding / removing' }
GtGenericConnector >> addEdgeFrom: aSourceElement to: aTargetElement [
	"Add a graph edge between two given elements.
	Both elements must not be nil"
	| anEdge |
	self
		assert: [ aSourceElement isNotNil ]
		description: [ 'Source element must not be nil' ].

	self
		assert: [ aTargetElement isNotNil ]
		description: [ 'Target element must not be nil' ].

	anEdge := GtGraphEdge new
		from: aSourceElement
		to: aTargetElement.

	aSourceElement constraints graph addConnectedEdge: anEdge.
	aTargetElement constraints graph addConnectedEdge: anEdge.

	self requestLayout
]

{ #category : #public }
GtGenericConnector >> addEntity: anEntity [
	"Create a new editor on a given method, add it to the scene"
	
	(self hasOpenedEntity: anEntity)
		ifTrue: [ ^ self ].

	self openEntity: anEntity.
]

{ #category : #'private - adding / removing' }
GtGenericConnector >> addLineFrom: aSourceElement to: aTargetElement [
	"Add a line connecting two given elements.
	Both elements must not be nil"
	| aLineElement aDeleteListener |
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

	aLineElement := BlLineElement new.
	aLineElement constraints ignoreByLayout.
	aLineElement
		border: (BlBorder paint: (Color gray alpha: 0.2) width: 5);
		fromAnchor: (BlElementCenterAnchor element: aSourceElement);
		toAnchor: (BlElementCenterLeftAnchor element: aTargetElement).

	"Line should disappear when any of source or target elements is deleted"
	aDeleteListener := nil.
	"we should not forget to remove event handlers before removing a line"
	aDeleteListener := BlEventHandler on: BlElementRemovedEvent do: [ :anEvent |
		aSourceElement removeEventHandler: aDeleteListener.
		aTargetElement removeEventHandler: aDeleteListener.
		aSourceElement beNotConnectedTo: aTargetElement.
		aTargetElement beNotConnectedTo: aSourceElement.
		aLineElement removeFromParent ].
	
	aSourceElement addEventHandler: aDeleteListener.
	aTargetElement addEventHandler: aDeleteListener.
	
	aSourceElement beConnectedTo: aTargetElement.
	aTargetElement beConnectedTo: aSourceElement.

	self addChild: aLineElement
]

{ #category : #'private - adding / removing' }
GtGenericConnector >> addLink: aLink [
	| aSourceElement aTargetElement |
	
	aSourceElement := self
		elementWithEntity: aLink source
		ifAbsent: [ ^ self ].
		
	aTargetElement := self
		elementWithEntity: aLink target
		ifAbsent: [ ^ self ].

	self addEdgeFrom: aSourceElement to: aTargetElement
]

{ #category : #converting }
GtGenericConnector >> asScalableElement [
	| scalable |
	scalable := BlScalableElement new.
	scalable
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
	scalable contentElement: self.
	^ scalable
]

{ #category : #'private - adding / removing' }
GtGenericConnector >> connect: anElement [
	"I create a visual edge between elements (not used by layouts)"

	"self
		assert: [ anElement isConnectorSource or: [ anElement isConnectorTarget ] ]
		description: [ 'An element must be either a source or a target' ]."

	"Element is a source, connect it to all targets"
	
	anElement connector isVisualSource ifTrue: [
		(self elementsWithTarget: anElement connector model)
			select: [ :aTargetElement | (anElement isConnectedTo: aTargetElement) not
				and: [ (self doesExist: aTargetElement)
					and: [ (self doesExist: anElement) ] ] ]
			thenDo: [ :aTargetElement | self addLineFrom: anElement to: aTargetElement ] ].

	"Element is a target, connect it to all sources"
	anElement isConnectorTarget ifTrue: [
		(self sourcesWithTarget: anElement connector target)
			select: [ :aSourceElement | (aSourceElement isConnectedTo: anElement) not
				and: [ (self doesExist: aSourceElement)
					and: [ (self doesExist: anElement) ] ]  ]
			thenDo: [ :aSourceElement | self addLineFrom: aSourceElement to: anElement ] ].
		
	self requestLayout.
]

{ #category : #private }
GtGenericConnector >> createAndAddElementForEntity: anEntity [
	| entityElement |	
		
	self
		assert: [ self stencil isNotNil ]
		description: [ 'Stencil describing each entity can not be nil' ].
	"build the entity itself"
	entityElement := self stencil value: anEntity.

	self addChild: entityElement.

	^ entityElement
]

{ #category : #testing }
GtGenericConnector >> doesExist: anElement [
	^ (anElement hasParent: self) or: [ anElement isAttachedToSceneGraph ]
]

{ #category : #accessing }
GtGenericConnector >> drawLines: anElement [
	
	anElement connector isVisualSource ifTrue: [
		(self targetElementsWith: anElement connector model)
			select: [ :aTargetElement |  (anElement isConnectedTo: aTargetElement) not 
				and: [(self doesExist: aTargetElement)
					and: [ (self doesExist: anElement) ] ] ]
			thenDo: [ :aTargetElement | self addLineFrom: anElement to: aTargetElement ] ].
		
	"Element is a target, connect it to all sources"
	anElement connector isVisualTarget ifTrue: [
		(self sourceElementsWith: anElement connector model)
			select: [ :aSourceElement |  (aSourceElement isConnectedTo: anElement) not 
				and: [(self doesExist: aSourceElement)
					and: [ (self doesExist: anElement) ] ] ]
			thenDo: [ :aSourceElement | self addLineFrom: aSourceElement to: anElement ] ].
		
"	self requestParentLayout."
]

{ #category : #accessing }
GtGenericConnector >> elementAddedToScene: anElement [
	"I create a logical edge between elements (not visible)"
	self link: anElement.
	self drawLines: anElement.
	
]

{ #category : #search }
GtGenericConnector >> elementWithEntity: aMethod ifAbsent: aBlock [
	
	self
		elementWithEntity: aMethod
		ifPresent: [ :anElement | ^ anElement ].
		
	^ aBlock value
]

{ #category : #search }
GtGenericConnector >> elementWithEntity: anEntity ifPresent: aBlock [
	"Search for an element containg a given entity
	and evaluate aBlock with it as argument if such an element is found.
	Note: we don't make any assumptions on the type of anEntity object,
	it might be any custom domain object that implements a `=` comparison method"

	self
		assert: [ anEntity isNotNil ]
		description: [ 'Entity must not be nil' ].

	self entityElements 
		detect: [ :anEntityElement | 
			anEntityElement connector model = anEntity 
				"at: #editedMethod
				ifPresent: [ :anEditedMethod | anEntity = anEditedMethod ]
				ifAbsent: [ false ]" ]
		ifFound: [ :anEditorElement | aBlock cull: anEditorElement ]
]

{ #category : #search }
GtGenericConnector >> elementsVisualWithSource: aSource [
	"Return a collection of source elements whose source is a given object"
	<return: #SequenceableCollection of: #BlElement>

	^ Array streamContents: [ :aStream |
		self allChildrenBreadthFirstDo: [ :aChildElement |
			(aChildElement connector isVisualSource
				and: [ aChildElement connector model = aSource ])
					ifTrue: [ aStream nextPut: aChildElement ] ] ]
]

{ #category : #search }
GtGenericConnector >> elementsVisualWithTarget: aSource [
	"Return a collection of source elements whose source is a given object"
	<return: #SequenceableCollection of: #BlElement>

	^ Array streamContents: [ :aStream |
		self allChildrenBreadthFirstDo: [ :aChildElement |
			
			(aChildElement connector isVisualTarget
				and: [ aChildElement connector model = aSource ])
					ifTrue: [ aStream nextPut: aChildElement ] ] ]
]

{ #category : #search }
GtGenericConnector >> elementsWithSource: aSource [
	"Return a collection of source elements whose source is a given object"
	<return: #SequenceableCollection of: #BlElement>

	^ Array streamContents: [ :aStream |
		self allChildrenBreadthFirstDo: [ :aChildElement |
			(aChildElement isConnectorSource
				and: [ aChildElement connector source = aSource ])
					ifTrue: [ aStream nextPut: aChildElement ] ] ]
]

{ #category : #search }
GtGenericConnector >> elementsWithTarget: aTarget [
	"Return a collection of target elements whose target is a given object"
	<return: #SequenceableCollection of: #BlElement>

	^ Array streamContents: [ :aStream |
		self allChildrenBreadthFirstDo: [ :aChildElement |
			(aChildElement connector isVisualTarget
				and: [ aChildElement connector model = aTarget ])
					ifTrue: [ aStream nextPut: aChildElement ] ] ]
]

{ #category : #accessing }
GtGenericConnector >> entityElements [
	"Return a collection of existing editor elements that are already added to the tree"
	<return: #SequenceableCollection of: #BlElement>

	^ self children reject: [ :anElement | anElement isKindOf: BlLineElement ]
]

{ #category : #accessing }
GtGenericConnector >> goUpToSourceLayoutElement: anElement [
	"I go up the BlElement containment heirarchy to find the first parent that is a layout target"
	| result |
	result := anElement.
	[result isNotNil and: [result connector isLayoutSource]] whileFalse: [ result := result parent ].
	^ result
]

{ #category : #accessing }
GtGenericConnector >> goUpToTargetLayoutElement: anElement [
	"I go up the BlElement containment heirarchy to find the first parent that is a layout target"
	| result |
	result := anElement.
	[result isNotNil and: [result connector isLayoutTarget]] whileFalse: [ result := result parent ].
	^ result
]

{ #category : #'gt-extension' }
GtGenericConnector >> gtLiveFor: aView [
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

{ #category : #testing }
GtGenericConnector >> hasOpenedEntity: anEntity [
	"Return true if there already exists an editor opened on a given method, false otheriwse.
	aMethod must not be nil"
	<return: #Boolean>

	self elementWithEntity: anEntity ifPresent: [ ^ true ].
	^ false
]

{ #category : #testing }
GtGenericConnector >> hasOpenedMethod: aMethod [
	"Return true if there already exists an editor opened on a given method, false otheriwse.
	aMethod must not be nil"
	<return: #Boolean>

	self elementWithMethod: aMethod ifPresent: [ ^ true ].
	^ false
]

{ #category : #initialization }
GtGenericConnector >> initialize [
	super initialize.

	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent.
		c padding: (BlInsets all: 40) ].

	self layout: (GtGraphHorizontalDominanceTreeLayout new horizontalGap: 100; verticalGap: 40).
	
	self initializeListeners
]

{ #category : #initialization }
GtGenericConnector >> initializeListeners [
	
	self when: GtConnectorTargetElement do: [ :event | 
		self drawLines: event element.
		self link: event element ].
	self when: GtConnectorSourceElement do: [ :event | 
		self drawLines: event element.
		self link: event element ].
]

{ #category : #accessing }
GtGenericConnector >> link: anElement [
	"I create a logical edge between elements (not visible)"
	| sourceLayoutElement targetLayoutElement |
	self
		assert: [ anElement connector isNotNil ]
		description: [ 'An element connector must not be nil' ].
	
	anElement connector isVisualTarget ifTrue: [ 
		
		targetLayoutElement := self goUpToTargetLayoutElement: anElement.
		
		(self elementsVisualWithSource: anElement connector model) do: [ :layoutSource |
			
			sourceLayoutElement := self goUpToSourceLayoutElement: layoutSource.
			self addEdgeFrom: sourceLayoutElement to: targetLayoutElement 
		].
	].
	
	anElement connector isVisualSource ifTrue: [
		
		sourceLayoutElement := self goUpToSourceLayoutElement: anElement.
		
		(self elementsVisualWithTarget: anElement connector model) do: [ :layoutTarget |
			
			targetLayoutElement := self goUpToTargetLayoutElement: layoutTarget.
			self addEdgeFrom: sourceLayoutElement to: targetLayoutElement 
		]
	]
]

{ #category : #private }
GtGenericConnector >> openEntity: anEntity [
	"Open a given method without connecting it to other"	
	self
		assert: [ (self hasOpenedEntity: anEntity) not ]
		description: [ 'Can not open already opened enity' ].

	self createAndAddElementForEntity: anEntity.
]

{ #category : #'private - adding / removing' }
GtGenericConnector >> removeEdgeFrom: aSourceElement to: aTargetElement [
	"I remove edges associated with the given element and edges from other elements with which it is connected"

	aSourceElement constraints graph outgoingEdges
		select: [ :anEdge | anEdge toElement == aTargetElement ]
		thenDo: [ :anEdge |
			aSourceElement constraints graph removeConnectedEdge: anEdge.
			aTargetElement constraints graph removeConnectedEdge: anEdge ].
	self requestLayout
]

{ #category : #'private - adding / removing' }
GtGenericConnector >> removeEdgesFrom: anElement [
	"I remove edges associated with the given element and edges from other elements with which it is connected"

	anElement constraints graph connectedEdges
		do: [ :anEdge |
			| aConnectedElement |
			"connected element is an element on the other side of the edge"
			aConnectedElement := (anEdge fromElement == anElement)
				ifTrue: [ anEdge toElement  ]
				ifFalse: [ anEdge fromElement ].
			
			self
				assert: [ aConnectedElement constraints graph hasConnectedEdge: anEdge ]
				description: [ 'Connected element must have the same edge, otherwise something went out of sync' ].

			aConnectedElement constraints graph removeConnectedEdge: anEdge ].
	
	"constraints changed, should update layout"
	self requestLayout
]

{ #category : #'private - adding / removing' }
GtGenericConnector >> removeLink: aLink [
	| aSourceElement aTargetElement |
	
	aSourceElement := self
		elementWithEntity: aLink source
		ifAbsent: [ ^ self ].
		
	aTargetElement := self
		elementWithEntity: aLink target
		ifAbsent: [ ^ self ].

	self removeEdgeFrom: aSourceElement to: aTargetElement
]

{ #category : #search }
GtGenericConnector >> sourceElementsWith: aTarget [
	"Return a collection of target elements whose source is a given object"
	<return: #SequenceableCollection of: #BlElement>

	^ Array streamContents: [ :aStream |
		self allChildrenBreadthFirstDo: [ :aChildElement |
			(aChildElement connector isVisualSource
				and: [ aChildElement connector model = aTarget ])
					ifTrue: [ aStream nextPut: aChildElement ] ] ]
]

{ #category : #search }
GtGenericConnector >> sourcesWithTarget: aTarget [
	"Return a collection of target elements whose source is a given object"
	<return: #SequenceableCollection of: #BlElement>

	^ Array streamContents: [ :aStream |
		self allChildrenBreadthFirstDo: [ :aChildElement |
			(aChildElement isConnectorSource
				and: [ aChildElement connector target = aTarget ])
					ifTrue: [ aStream nextPut: aChildElement ] ] ]
]

{ #category : #search }
GtGenericConnector >> stencil [ 
	^ stencil 
]

{ #category : #search }
GtGenericConnector >> stencil: aStencil [
	stencil := aStencil
]

{ #category : #search }
GtGenericConnector >> targetElementsWith: aTarget [
	"Return a collection of target elements whose target is a given object"
	<return: #SequenceableCollection of: #BlElement>

	^ Array streamContents: [ :aStream |
		self allChildrenBreadthFirstDo: [ :aChildElement |
			(aChildElement connector isVisualTarget
				and: [ aChildElement connector model = aTarget ])
					ifTrue: [ aStream nextPut: aChildElement ] ] ]
]

{ #category : #search }
GtGenericConnector >> targetsWithSource: aSource [
	"Return a collection of target elements whose source is a given object"
	<return: #SequenceableCollection of: #BlElement>

	^ Array streamContents: [ :aStream |
		self allChildrenBreadthFirstDo: [ :aChildElement |
			(aChildElement isConnectorTarget
				and: [ aChildElement connectorSource = aSource ])
					ifTrue: [ aStream nextPut: aChildElement ] ] ]
]
