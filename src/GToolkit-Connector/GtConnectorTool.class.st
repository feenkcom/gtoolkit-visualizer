Class {
	#name : #GtConnectorTool,
	#superclass : #GtPhlowTool,
	#instVars : [
		'object'
	],
	#category : #'GToolkit-Connector-Core'
}

{ #category : #'api - converting' }
GtConnectorTool >> asElementDo: aOneArgBlock [
	| anElement |
	anElement := GtConnectorContainer new entity: self object.

	^ aOneArgBlock cull: anElement
]

{ #category : #'private - converting' }
GtConnectorTool >> asTabElement [
	"Return a tool element that is going to be used as a part of ${class:GtPhlowCompositeTool}$"
	<return: #BlElement>
	| aContainer |
	aContainer := super asTabElement.
	aContainer addEventHandler: (GtPhlowToolChangedObjectHandler new
		onChangeSend: #entity: to: aContainer).
	^ aContainer
]

{ #category : #'api - converting' }
GtConnectorTool >> icon [ 
	^ BrGlamorousVectorIcons largebranching asElement asScalableElement size: 16@16
]

{ #category : #'api - accessing' }
GtConnectorTool >> name [
	^ 'connector'
]

{ #category : #'api - accessing' }
GtConnectorTool >> object [
	^ object
]

{ #category : #'api - accessing' }
GtConnectorTool >> object: anObject [
	object := anObject
]

{ #category : #'private - accessing' }
GtConnectorTool >> tabLook [
	^ BrGlamorousTabSwitcherWithIconAptitude
]
