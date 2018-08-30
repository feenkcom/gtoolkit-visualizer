"
I am an element that connects connectable parts from my elements.

At the moment, I only work with text elenents. 
"
Class {
	#name : #GtConnector,
	#superclass : #BlElement,
	#instVars : [
		'stylerDoneListener',
		'stylerListener'
	],
	#category : 'GToolkit-Connector'
}

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

	self requestLayout
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
		
"	self
		assert: [ (aSourceElement isConnectedTo: aTargetElement) not ]
		description: [ 'Source must not be connected to the target' ].
		
	self
		assert: [ (aTargetElement isConnectedTo: aSourceElement) not ]
		description: [ 'Target must not be connected to the source' ]."

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
GtConnector >> addLink: aLink [
	| aSourceElement aTargetElement |
	
	aSourceElement := self
		elementWithMethod: aLink source
		ifAbsent: [ ^ self ].
		
	aTargetElement := self
		elementWithMethod: aLink target
		ifAbsent: [ ^ self ].

	self addEdgeFrom: aSourceElement to: aTargetElement
]

{ #category : #public }
GtConnector >> addMethod: aMethod [
	"Create a new editor on a given method, add it to the scene"
	
	(self hasOpenedMethod: aMethod)
		ifTrue: [ ^ self ].

	self openMethod: aMethod.
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

{ #category : #public }
GtConnector >> closeMethod: aMethod [

	self
		assert: [ self hasOpenedMethod: aMethod ]
		description: [ 'Method must be opened' ].

	self
		elementWithMethod: aMethod
		ifPresent: [ :aMethodElement |
			self removeEdgesFrom: aMethodElement.
			"as soon as method element is removed, lines will automatically disappear"
			aMethodElement removeFromParent ]
]

{ #category : #'private - adding / removing' }
GtConnector >> connect: anElement [
	"I create a visual edge between elements (not used by layouts)"

	self
		assert: [ anElement isConnectorSource or: [ anElement isConnectorTarget ] ]
		description: [ 'An element must be either a source or a target' ].

	"Element is a source, connect it to all targets"

	"we assume (?) that source knows target, because we have N:1 (many source - one target)"
	anElement isConnectorSource ifTrue: [
		(self elementsWithTarget: anElement connectorTarget)
			select: [ :aTargetElement | (anElement isConnectedTo: aTargetElement) not
				and: [ (self doesExist: aTargetElement)
					and: [ (self doesExist: anElement) ] ] ]
			thenDo: [ :aTargetElement | self addLineFrom: anElement to: aTargetElement ] ].

	"Element is a target, connect it to all sources"
	anElement isConnectorTarget ifTrue: [
		(self sourcesWithTarget: anElement connectorTarget)
			select: [ :aSourceElement | (aSourceElement isConnectedTo: anElement) not
				and: [ (self doesExist: aSourceElement)
					and: [ (self doesExist: anElement) ] ]  ]
			thenDo: [ :aSourceElement | self addLineFrom: aSourceElement to: anElement ] ]
]

{ #category : #private }
GtConnector >> createAndAddElementForMethod: method [
	| editor editorElement text styler |	
	
	editorElement := BrEditorElement new.
	editorElement
		constraintsDo: [ :c |
			c horizontal exact: 400.
			c vertical fitContent.
			c maxHeight: 200.
			c padding: (BlInsets all: 10) ].
	editorElement
		background: Color white;
		effect: (BlDropShadowEffect color: (Color gray alpha: 0.5) width: 10 offset: 5@5).

	styler := GtConnectorExampleStyler new.
	styler exampleAction: [ :anExampleMethod | self addMethod: anExampleMethod ].
	styler classOrMetaClass: method methodClass.
	styler addEventHandler: stylerListener.

	editor := BrTextEditor new.
	editor styler: styler.

	editorElement userData at: #editedMethod put: method.
	editorElement editor: editor.

	editorElement beConnectorTarget.
	editorElement connectorTarget: method.

	text := method sourceCode asRopedText.

	self addChild: editorElement.
	"because we connect editors with lines based on styler we must change text
	only after editor is added to the scene, otherwise events will be ignored"
	editor text: text.	
	
	^ editorElement
]

{ #category : #testing }
GtConnector >> doesExist: anElement [
	^ (anElement hasParent: self) or: [ anElement isAttachedToSceneGraph ]
]

{ #category : #search }
GtConnector >> edgesForLink: aLink [
	| theSourceElements theTargetElements |
	<return: #SequenceableCollection of: #GtGraphEdge>
	
	theSourceElements := self elementsWithMethod: aLink source.
	theSourceElements
		ifEmpty: [ ^ #() ].
		
	theTargetElements := self elementsWithMethod: aLink target.
	theTargetElements
		ifEmpty: [ ^ #() ].
		
	^ Array streamContents: [ :aStream |
			theSourceElements do: [ :aSourceElement |
				aStream nextPutAll: (aSourceElement constraints graph outgoingEdges
					select: [ :anEdge |
						| anEdgeLink |
						anEdgeLink := GtConnectorLink
							source: anEdge fromElement connectorSource
							target: anEdge fromElement connectorTarget.
						
						anEdge = aLink
					]) ] ]
]

{ #category : #search }
GtConnector >> editorElements [
	"Return a collection of existing editor elements that are already added to the tree"
	<return: #SequenceableCollection of: #BrEditorElement>

	^ self children select: [ :anElement | anElement isKindOf: BrEditorElement ]
]

{ #category : #search }
GtConnector >> elementWithMethod: aMethod ifAbsent: aBlock [
	
	self
		elementWithMethod: aMethod
		ifPresent: [ :anElement | ^ anElement ].
		
	^ aBlock value
]

{ #category : #search }
GtConnector >> elementWithMethod: aMethod ifPresent: aBlock [
	"Search for an editor opened on a given method
	and evaluate aBlock with it as argument if such an editor is found.
	Note: we don't make any assumptions on the type of aMethod object,
	it might be a CompiledMethod or any custom domain object that represents
	a method and implements a `=` comparison method"

	self
		assert: [ aMethod isNotNil ]
		description: [ 'Method must not be nil' ].

	self editorElements 
		detect: [ :anEditorElement | 
			anEditorElement userData
				at: #editedMethod
				ifPresent: [ :anEditedMethod | aMethod = anEditedMethod ]
				ifAbsent: [ false ] ]
		ifFound: [ :anEditorElement | aBlock cull: anEditorElement ]
]

{ #category : #search }
GtConnector >> elementsWithMethod: aMethod [

	^ self editorElements 
		select: [ :anEditorElement | 
			anEditorElement userData
				at: #editedMethod
				ifPresent: [ :anEditedMethod | aMethod = anEditedMethod ]
				ifAbsent: [ false ] ]
]

{ #category : #search }
GtConnector >> elementsWithSource: aSource [
	"Return a collection of source elements whose source is a given object"
	<return: #SequenceableCollection of: #BlElement>

	^ Array streamContents: [ :aStream |
		self allChildrenBreadthFirstDo: [ :aChildElement |
			(aChildElement isConnectorSource
				and: [ aChildElement connectorSource = aSource ])
					ifTrue: [ aStream nextPut: aChildElement ] ] ]
]

{ #category : #search }
GtConnector >> elementsWithTarget: aTarget [
	"Return a collection of target elements whose target is a given object"
	<return: #SequenceableCollection of: #BlElement>

	^ Array streamContents: [ :aStream |
		self allChildrenBreadthFirstDo: [ :aChildElement |
			(aChildElement isConnectorTarget
				and: [ aChildElement connector model = aTarget ])
					ifTrue: [ aStream nextPut: aChildElement ] ] ]
]

{ #category : #'gt-extension' }
GtConnector >> gtLiveFor: aView [
	^ (super gtLiveFor: aView) 
		stencil: [ self asPannableElement ]
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
		c horizontal matchParent.
		c vertical matchParent.
		c padding: (BlInsets all: 40) ].

	self layout: (GtGraphHorizontalDominanceTreeLayout new horizontalGap: 100; verticalGap: 40).
	
	self initializeListeners
]

{ #category : #initialization }
GtConnector >> initializeListeners [
	
	stylerListener := GtConnectorStylerListener new connector: self
]

{ #category : #'private - adding / removing' }
GtConnector >> link: anElement [
	"I create a logical edge between elements (not visible)"

	self
		assert: [ anElement isConnectorTarget ]
		description: [ 'An element must be a target' ].

	(self sourcesWithTarget: anElement connectorTarget)
		do: [ :anInnerElement |
			(self elementsWithMethod: anInnerElement connectorSource)
				do: [ :aSourceElement | self addEdgeFrom: aSourceElement to: anElement ] ]
]

{ #category : #private }
GtConnector >> openMethod: aMethod [
	"Open a given method without connecting it to other"
	| aTargetElement |	
	self
		assert: [ (self hasOpenedMethod: aMethod) not ]
		description: [ 'Can not open already opened method' ].

	aTargetElement := self createAndAddElementForMethod: aMethod.	
]

{ #category : #'private - adding / removing' }
GtConnector >> removeEdgeFrom: aSourceElement to: aTargetElement [
	"I remove edges associated with the given element and edges from other elements with which it is connected"

	aSourceElement constraints graph outgoingEdges
		select: [ :anEdge | anEdge toElement == aTargetElement ]
		thenDo: [ :anEdge |
			aSourceElement constraints graph removeConnectedEdge: anEdge.
			aTargetElement constraints graph removeConnectedEdge: anEdge ].
	self requestLayout
]

{ #category : #'private - adding / removing' }
GtConnector >> removeEdgesFrom: anElement [
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
GtConnector >> removeLink: aLink [
	| aSourceElement aTargetElement |
	
	aSourceElement := self
		elementWithMethod: aLink source
		ifAbsent: [ ^ self ].
		
	aTargetElement := self
		elementWithMethod: aLink target
		ifAbsent: [ ^ self ].

	self removeEdgeFrom: aSourceElement to: aTargetElement
]

{ #category : #search }
GtConnector >> sourcesWithTarget: aTarget [
	"Return a collection of target elements whose source is a given object"
	<return: #SequenceableCollection of: #BlElement>

	^ Array streamContents: [ :aStream |
		self allChildrenBreadthFirstDo: [ :aChildElement |
			(aChildElement isConnectorSource
				and: [ aChildElement connectorTarget = aTarget ])
					ifTrue: [ aStream nextPut: aChildElement ] ] ]
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
