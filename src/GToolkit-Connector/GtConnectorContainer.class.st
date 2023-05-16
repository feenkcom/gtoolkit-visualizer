"
I am a {{gtClass:BlElement}}.
I hold a {{gtMethod:GtConnectorContainer>>#entity|label=#selector}} and display its {{gtClass:GtConnector}} view calling {{gtMethod:Object>>#gtConnectionsFor:}}. 
I {{gtMethod:GtConnectorContainer>>#updateView|label=update}} the view when the {{gtMethod:GtConnectorContainer>>#entity:|label=entity}} is changed.
1. # Example

For the entity: {{gtExample:GtConnectorExamples>>#entityOne|noCode}} 
I display: {{gtExample:GtConnectorExamples>>#entityOneContainer|codeExpanded=false|previewExpanded=true|previewHeight=400}}


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

	self layout: BlFrameLayout new.
	self matchParent.
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
