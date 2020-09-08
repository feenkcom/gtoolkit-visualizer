Class {
	#name : #GtConnectorContainer,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable',
	#classTraits : 'TBrLayoutResizable classTrait',
	#instVars : [
		'entity'
	],
	#category : #'GToolkit-Connector-Core'
}

{ #category : #'api - accessing' }
GtConnectorContainer >> entity [
	"Return an entity for which a view is created."
	^ entity
]

{ #category : #'api - accessing' }
GtConnectorContainer >> entity: anEntity [
	"Set an entity for which a view is created."
	entity = anEntity ifTrue: [ ^ self ].
	entity := anEntity.
	self onEntityChanged.
]

{ #category : #initialization }
GtConnectorContainer >> initialize [
	super initialize.
	self addInteractiveModelState: BrLayoutHorizontalResizerModel matchParent.
	self addInteractiveModelState: BrLayoutVerticalResizerModel matchParent.
	self layout: BlFrameLayout new.
	
	self addLook: BrLayoutResizerLook inherit.
]

{ #category : #'private - hooks' }
GtConnectorContainer >> onEntityChanged [
	self updateView.
]

{ #category : #'private - updating' }
GtConnectorContainer >> updateView [
	| aView |
	self removeChildren.
	aView := self entity gtConnectionsFor: GtPhlowEmptyView new.
	aView asElementDo: [ :anElement | 
		self addChild: anElement ].
]
