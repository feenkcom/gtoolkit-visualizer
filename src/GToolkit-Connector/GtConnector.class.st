Class {
	#name : #GtConnector,
	#superclass : #BlElement,
	#instVars : [
		'stylerDoneListener',
		'stylerListener',
		'stencil',
		'options'
	],
	#category : #'GToolkit-Connector'
}

{ #category : #'private - adding / removing' }
GtConnector >> addDiscreteLineFrom: aSourceElement to: aTargetElement [
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

	aLineElement := BlParabollaArcElement new.
	aLineElement curvatureFraction: 0.
	aLineElement zIndex: 10.
	aLineElement toHead: (BlArrowheadSimpleArrow new
					border: (BlBorder builder paint: (Color gray alpha: 0.04); width: 10; build)).
	aLineElement constraints ignoreByLayout.
	aLineElement
		border: (BlBorder paint: (Color gray alpha: 0.04) width: 20);
		fromAnchor: (BlNearestPositionLooseCircleAnchor nearestTo:aTargetElement from: aSourceElement);
		toAnchor: (BlNearestPositionBoundsAnchor nearestTo: aSourceElement from: aTargetElement).

	"Line should disappear when any of source or target elements is deleted"
	aDeleteListener := nil.
	"we should not forget to remove event handlers before removing a line"
	aDeleteListener := BlEventHandler on: BlElementRemovedFromParentEvent do: [ :anEvent |
		aSourceElement removeEventHandler: aDeleteListener.
		aTargetElement removeEventHandler: aDeleteListener.
		aSourceElement beNotConnectedTo: aTargetElement.
		aTargetElement beNotConnectedTo: aSourceElement.
		aLineElement removeFromParent ].
	
	aSourceElement addEventHandler: aDeleteListener.
	aTargetElement addEventHandler: aDeleteListener.
	
	aSourceElement beConnectedTo: aTargetElement.
	aTargetElement beConnectedTo: aSourceElement.

	self addChild: aLineElement.
	
]

{ #category : #'private - adding / removing' }
GtConnector >> addEdgeFrom: aSourceElement to: aTargetElement [
	
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
	(aSourceElement isConnectedTo: aTargetElement)
		ifFalse: [ self addDiscreteLineFrom: aSourceElement to: aTargetElement].

	self requestLayout
]

{ #category : #public }
GtConnector >> addEntity: anEntity [
	"Create a new editor on a given method, add it to the scene"
	
	(self hasOpenedEntity: anEntity)
		ifTrue: [ ^ self ].

	self openEntity: anEntity.
]

{ #category : #'private - adding / removing' }
GtConnector >> addLineFrom: aSourceElement to: aTargetElement [
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

	"Line should disappear when any of source or target elements is deleted"
	aDeleteListener := nil.
	"we should not forget to remove event handlers before removing a line"
	aDeleteListener := BlEventHandler on: BlElementRemovedFromParentEvent do: [ :anEvent |
		aSourceElement removeEventHandler: aDeleteListener.
		aTargetElement removeEventHandler: aDeleteListener.
		aSourceElement beNotConnectedTo: aTargetElement.
		aTargetElement beNotConnectedTo: aSourceElement.
		aLineElement removeFromParent ].
	
	aSourceElement addEventHandler: aDeleteListener.
	aTargetElement addEventHandler: aDeleteListener.
	
	aSourceElement beConnectedTo: aTargetElement.
	aTargetElement beConnectedTo: aSourceElement.
	self options drawLines ifTrue: [ self addChild: aLineElement ]
	
	
]

{ #category : #'private - adding / removing' }
GtConnector >> addLink: aLink [
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

{ #category : #'private - adding / removing' }
GtConnector >> connect: anElement [
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
GtConnector >> createAndAddElementForEntity: anEntity [
	| entityElement |	
		
	self
		assert: [ self stencil isNotNil ]
		description: [ 'Stencil describing each entity can not be nil' ].
	"build the entity itself"
	entityElement := self stencil value: anEntity.

	self addChild: entityElement.
	entityElement graph beNode.

	^ entityElement
]

{ #category : #testing }
GtConnector >> doesExist: anElement [
	^ (anElement hasParent: self) or: [ anElement isAttachedToSceneGraph ]
]

{ #category : #accessing }
GtConnector >> drawLines: anElement [
	
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
]

{ #category : #accessing }
GtConnector >> elementAddedToScene: anElement [
	"I create a logical edge between elements (not visible)"
	self link: anElement.
	self drawLines: anElement.
	
]

{ #category : #search }
GtConnector >> elementWithEntity: aMethod ifAbsent: aBlock [
	
	self
		elementWithEntity: aMethod
		ifPresent: [ :anElement | ^ anElement ].
		
	^ aBlock value
]

{ #category : #search }
GtConnector >> elementWithEntity: anEntity ifPresent: aBlock [
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

{ #category : #search }
GtConnector >> elementsWithSource: aSource [
	"Return a collection of source elements whose source is a given object"
	<return: #SequenceableCollection of: #BlElement>

	^ Array streamContents: [ :aStream |
		self allChildrenBreadthFirstDo: [ :aChildElement |
			(aChildElement isConnectorSource
				and: [ aChildElement connector source = aSource ])
					ifTrue: [ aStream nextPut: aChildElement ] ] ]
]

{ #category : #search }
GtConnector >> elementsWithTarget: aTarget [
	"Return a collection of target elements whose target is a given object"
	<return: #SequenceableCollection of: #BlElement>

	^ Array streamContents: [ :aStream |
		self allChildrenBreadthFirstDo: [ :aChildElement |
			(aChildElement connector isVisualTarget
				and: [ aChildElement connector model = aTarget ])
					ifTrue: [ aStream nextPut: aChildElement ] ] ]
]

{ #category : #accessing }
GtConnector >> entityElements [
	"Return a collection of existing editor elements that are already added to the tree"
	<return: #SequenceableCollection of: #BlElement>

	^ self children reject: [ :anElement | anElement isKindOf: BlLineElement ]
]

{ #category : #accessing }
GtConnector >> goUpToSourceLayoutElement: anElement [
	"I go up the BlElement containment heirarchy to find the first parent that is a layout target"
	| result |
	result := anElement.
	[result isNotNil and: [result connector isLayoutSource]] whileFalse: [ result := result parent ].
	^ result
]

{ #category : #accessing }
GtConnector >> goUpToTargetLayoutElement: anElement [
	"I go up the BlElement containment heirarchy to find the first parent that is a layout target"
	| result |
	result := anElement.
	[result isNotNil and: [result connector isLayoutTarget]] whileFalse: [ result := result parent ].
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

{ #category : #testing }
GtConnector >> hasOpenedEntity: anEntity [
	"Return true if there already exists an editor opened on a given method, false otheriwse.
	aMethod must not be nil"
	<return: #Boolean>

	self elementWithEntity: anEntity ifPresent: [ ^ true ].
	^ false
]

{ #category : #testing }
GtConnector >> hasOpenedMethod: aMethod [
	"Return true if there already exists an editor opened on a given method, false otheriwse.
	aMethod must not be nil"
	<return: #Boolean>

	self elementWithMethod: aMethod ifPresent: [ ^ true ].
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
	self when: GtConnectorTargetElement do: [ :event | 
		self link: event element.
		self drawLines: event element.
		 ].
	self when: GtConnectorSourceElement do: [ :event | 
		self link: event element.
		self drawLines: event element.
		 ].
]

{ #category : #accessing }
GtConnector >> link: anElement [
	"I create a logical edge between elements (not visible)"
	| sourceLayoutElement targetLayoutElement |
	self
		assert: [ anElement connector isNotNil ]
		description: [ 'An element connector must not be nil' ].
	
	anElement connector isVisualTarget ifTrue: [
		targetLayoutElement := self goUpToTargetLayoutElement: anElement.
		anElement connector modelDo: [ :modelObject | 
			(self elementsVisualWithSource: modelObject) do: [ :layoutSource |
				sourceLayoutElement := self goUpToSourceLayoutElement: layoutSource.
				self addEdgeFrom: sourceLayoutElement to: targetLayoutElement ]]].
	
	anElement connector isVisualSource ifTrue: [
		sourceLayoutElement := self goUpToSourceLayoutElement: anElement.
		anElement connector modelDo: [ :modelObject |
			(self elementsVisualWithTarget: modelObject) do: [ :layoutTarget |
				targetLayoutElement := self goUpToTargetLayoutElement: layoutTarget.
				self addEdgeFrom: sourceLayoutElement to: targetLayoutElement ]]]
]

{ #category : #private }
GtConnector >> openEntity: anEntity [
	"Open a given method without connecting it to other"	
	self
		assert: [ (self hasOpenedEntity: anEntity) not ]
		description: [ 'Can not open already opened enity' ].

	self createAndAddElementForEntity: anEntity.
]

{ #category : #search }
GtConnector >> options [ 
	^ options 
]

{ #category : #search }
GtConnector >> options: anOptionsObject [
	options := anOptionsObject.
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

{ #category : #search }
GtConnector >> sourcesWithTarget: aTarget [
	"Return a collection of target elements whose source is a given object"
	<return: #SequenceableCollection of: #BlElement>

	^ Array streamContents: [ :aStream |
		self allChildrenBreadthFirstDo: [ :aChildElement |
			(aChildElement isConnectorSource
				and: [ aChildElement connector target = aTarget ])
					ifTrue: [ aStream nextPut: aChildElement ] ] ]
]

{ #category : #search }
GtConnector >> stencil [ 
	^ stencil 
]

{ #category : #search }
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

{ #category : #search }
GtConnector >> targetsWithSource: aSource [
	"Return a collection of target elements whose source is a given object"
	<return: #SequenceableCollection of: #BlElement>

	^ Array streamContents: [ :aStream |
		self allChildrenBreadthFirstDo: [ :aChildElement |
			(aChildElement isConnectorTarget
				and: [ aChildElement connectorSource = aSource ])
					ifTrue: [ aStream nextPut: aChildElement ] ] ]
]
