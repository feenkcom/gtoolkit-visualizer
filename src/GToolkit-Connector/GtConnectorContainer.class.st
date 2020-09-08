"
I am a ${class:BlElement}$.
I hold a ${method:GtConnectorContainer>>#entity|label=#selector}$ and display its ${class:GtConnector}$ view calling ${method:Object>>#gtConnectionsFor:}$. 
I ${method:GtConnectorContainer>>#updateView|label=update}$ the view when the ${method:GtConnectorContainer>>#entity:|label=entity}$ is changed.
!! Example
For the entity: ${example:GtConnectorExamples>>#entityOne|noCode}$ 
I display: ${example:GtConnectorExamples>>#entityOneContainer|codeExpanded=false|previewExpanded=true|previewHeight=400}$
"
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
	aView ifItHasContent: [
		aView asElementDo: [ :anElement | 
			self addChild: anElement ] ].
]
