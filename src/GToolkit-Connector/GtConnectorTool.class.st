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
	anElement := (self object gtConnectionsFor: GtPhlowEmptyView new) asElementDo: [ :e | e ].

	^ aOneArgBlock cull: anElement
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
	^ BrGlamorousTabSwitcherWithIconLook
]
