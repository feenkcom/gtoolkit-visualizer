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
GtConnectorTool >> asTabDo: aBlock [
	| aTab |
	aTab := BrTab new
		look: BrGlamorousTabSwitcherWithIconLook;
		label: self name;
		icon: BrGlamorousVectorIcons largebranching;
		stencil: [ self asElementDo: [ :anElement | anElement ] ].
	aBlock cull: aTab.
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
