Class {
	#name : #GtGraphAbstractRegularTreeLayout,
	#superclass : #GtGraphAbstractGraphLayout,
	#instVars : [
		'alreadyLayoutedNodes',
		'topGap',
		'leftGap',
		'nodesByLayer',
		'isLayered',
		'shouldBeHorizontallyReversed',
		'shouldBeVerticallyReversed'
	],
	#category : #'GToolkit-BlocGraph-Layouts-Layouts'
}

{ #category : #testing }
GtGraphAbstractRegularTreeLayout class >> isAbstract [
	^ self = GtGraphAbstractRegularTreeLayout
]

{ #category : #private }
GtGraphAbstractRegularTreeLayout >> atLayer: aNumber add: aNodeCollection [
	| collection |
	collection := nodesByLayer at: aNumber ifAbsentPut: [OrderedCollection new].
	collection addAll: aNodeCollection
]

{ #category : #hook }
GtGraphAbstractRegularTreeLayout >> doExecute: elements with: anExtentSpec [
	| rootNodes |
	alreadyLayoutedNodes := OrderedCollection new.
	rootNodes := self rootNodesFor: elements.
	nodesByLayer := OrderedCollection new.
	self
		layout: rootNodes
		atPoint: self leftGap @ self topGap
		atLayer: 1.
	self isLayered ifTrue: [
		self rearrangeByLayers: elements ]
]

{ #category : #hook }
GtGraphAbstractRegularTreeLayout >> doPost: elements with: anExtentSpec [
	shouldBeHorizontallyReversed ifTrue: [ self horizontallyReverse: elements ].
	shouldBeVerticallyReversed ifTrue: [ self verticallyReverse: elements ].
]

{ #category : #accessing }
GtGraphAbstractRegularTreeLayout >> horizontallyReverse [
	shouldBeHorizontallyReversed := true
]

{ #category : #reversing }
GtGraphAbstractRegularTreeLayout >> horizontallyReverse: elements [
	"Horizontally reverse the elements, as well as the attachpoints"
	| largeur |
	
	largeur := (self groupBounds: elements) width.
	
	elements
		do: [ :el | self translator translate: el to: (largeur - el position x) @ el position y ]
]

{ #category : #'initialize-release' }
GtGraphAbstractRegularTreeLayout >> initialize [
	super initialize.
	topGap := 5.
	leftGap := 5.
	isLayered := false.
	shouldBeHorizontallyReversed := false.
	shouldBeVerticallyReversed := false
]

{ #category : #reversing }
GtGraphAbstractRegularTreeLayout >> inverseAttachPoint [
	"Invert the attach point of all the considered edges. It is likely that all the attachpoint are the same, but we do not have a garanty"
]

{ #category : #accessing }
GtGraphAbstractRegularTreeLayout >> isLayered [
	"Is the layout layered"
	
	^ isLayered
]

{ #category : #accessing }
GtGraphAbstractRegularTreeLayout >> isLayered: boolean [
	"Is the layout layered"
	
	isLayered := boolean
]

{ #category : #accessing }
GtGraphAbstractRegularTreeLayout >> layered [
	self isLayered: true
]

{ #category : #'hook-private' }
GtGraphAbstractRegularTreeLayout >> layout: aNodeCollection atPoint: aPoint atLayer: anObject [
	self subclassResponsibility
]

{ #category : #accessing }
GtGraphAbstractRegularTreeLayout >> leftGap [
	^ leftGap
]

{ #category : #accessing }
GtGraphAbstractRegularTreeLayout >> leftGap: anInteger [
	leftGap := anInteger
]

{ #category : #accessing }
GtGraphAbstractRegularTreeLayout >> levelDistance: aNumber [
	self subclassResponsibility
]

{ #category : #accessing }
GtGraphAbstractRegularTreeLayout >> nodeDistance: aNumber [
	self subclassResponsibility
]

{ #category : #private }
GtGraphAbstractRegularTreeLayout >> rearrangeByLayers: aGraph [
	self subclassResponsibility
]

{ #category : #accessing }
GtGraphAbstractRegularTreeLayout >> shouldBeHorizontallyReversed [
	"Return if the layout is horizontally reversed"
	^ shouldBeHorizontallyReversed 
]

{ #category : #accessing }
GtGraphAbstractRegularTreeLayout >> shouldBeVerticallyReversed [
	"Return if the layout is vertically reversed"
	^ shouldBeVerticallyReversed
]

{ #category : #accessing }
GtGraphAbstractRegularTreeLayout >> topGap [
	^ topGap
]

{ #category : #accessing }
GtGraphAbstractRegularTreeLayout >> topGap: anInteger [
	topGap := anInteger
]

{ #category : #accessing }
GtGraphAbstractRegularTreeLayout >> verticallyReverse [
	"Reverse the edge extremities"
	"Here is an example:

| b |	
b := RTMondrian new.
b nodes: (1 to: 100).
b edges connectFrom: [ :v | v // 2 ].
b layout tree verticallyReverse.
b
"
	shouldBeVerticallyReversed := true
	

]

{ #category : #reversing }
GtGraphAbstractRegularTreeLayout >> verticallyReverse: elements [
	"Vertically reverse the elements, as well as the attachpoints"
	| hauteur |
	
	hauteur := (self groupBounds: elements) height.
	elements
		do: [ :el | self translator translate: el to: el position x @ (hauteur - el position y) ]
]
