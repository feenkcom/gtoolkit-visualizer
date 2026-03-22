Class {
	#name : #GtConnectorElementContext,
	#superclass : #Object,
	#instVars : [
		'model',
		'hasModel',
		'isLayoutSource',
		'isLayoutTarget',
		'isVisualSource',
		'isVisualTarget',
		'element',
		'connectorConnections'
	],
	#category : #'GToolkit-Connector-Core'
}

{ #category : #'instance creation' }
GtConnectorElementContext class >> on: anElement [
	^ self new 
		element: anElement;
		yourself
]

{ #category : #accessing }
GtConnectorElementContext >> beConnectedTo: anObject [ 
	connectorConnections ifNil: [ connectorConnections := Set new ].
	connectorConnections add: anObject.
]

{ #category : #actions }
GtConnectorElementContext >> beLayoutSource [
	self assert: [ isLayoutSource = false ].
	isLayoutSource := true.
	
	element 
		when: BlElementRemovedFromSceneGraphEvent
		do: [ :anEvent | 
			self emitSignalForEvent: anEvent forRole: #layoutSource.
			
			"Dispatch the event as the element is no longer in the scene graph"
			anEvent currentTarget dispatchEvent: (GtConnectorLayoutSourceElementRemovedEvent new
				element: anEvent currentTarget) ]
]

{ #category : #actions }
GtConnectorElementContext >> beLayoutTarget [
	self assert: [ isLayoutTarget = false ].
	isLayoutTarget := true.
	
	element 
		when: BlElementRemovedFromSceneGraphEvent
		do: [ :anEvent | 
			self emitSignalForEvent: anEvent forRole: #layoutTarget.
			
			"Dispatch the event as the element is no longer in the scene graph"
			anEvent currentTarget dispatchEvent: (GtConnectorLayoutTargetElementRemovedEvent new
				element: anEvent currentTarget) ]
]

{ #category : #accessing }
GtConnectorElementContext >> beNotConnectedTo: anObject [ 
	connectorConnections ifNotNil: [ connectorConnections remove: anObject ].
]

{ #category : #actions }
GtConnectorElementContext >> beVisualSource [
	self assert: [ isVisualSource = false ].
	isVisualSource := true.
	
	element
		when: BlElementAddedToSceneGraphEvent
		do: [ :anEvent | 
			self emitSignalForEvent: anEvent forRole: #visualSource.
			anEvent currentTarget fireEvent: (GtConnectorVisualSourceElementAddedEvent new
				element: anEvent currentTarget) ].
	element
		when: BlElementRemovedFromSceneGraphEvent
		do: [ :anEvent | 
			self emitSignalForEvent: anEvent forRole: #visualSource.
			"Dispatch the event as the element is no longer in the scene graph"
			anEvent currentTarget dispatchEvent: (GtConnectorVisualSourceElementRemovedEvent new
				element: anEvent currentTarget) ]
]

{ #category : #actions }
GtConnectorElementContext >> beVisualTarget [
	self assert: [ isVisualTarget = false ].
	isVisualTarget := true.
	
	element
		when: BlElementAddedToSceneGraphEvent
		do: [ :anEvent | 
			self emitSignalForEvent: anEvent forRole: #visualTarget.
			anEvent currentTarget fireEvent: (GtConnectorVisualTargetElementAddedEvent new
				element: anEvent currentTarget) ].
	element
		when: BlElementRemovedFromSceneGraphEvent
		do: [ :anEvent | 
			self emitSignalForEvent: anEvent forRole: #visualTarget.
			"Dispatch the event as the element is no longer in the scene graph"
			anEvent currentTarget dispatchEvent: (GtConnectorVisualTargetElementRemovedEvent new
				element: anEvent currentTarget) ]
]

{ #category : #accessing }
GtConnectorElementContext >> element [
	^ element
]

{ #category : #accessing }
GtConnectorElementContext >> element: anObject [
	element := anObject
]

{ #category : #logging }
GtConnectorElementContext >> emitSignalForEvent: anEvent forRole: aSymbol [
	GtConnectorContextEventSignal new 
		event: anEvent;
		elementRole: aSymbol;
		emit
]

{ #category : #testing }
GtConnectorElementContext >> hasModel [
	"I indicate if the context has a model, as nil can also be a valid model value."
	^ hasModel
]

{ #category : #initialization }
GtConnectorElementContext >> initialize [
	hasModel := false.
	isLayoutSource := false.
	isLayoutTarget := false.
	isVisualSource := false.
	isVisualTarget := false.
]

{ #category : #testing }
GtConnectorElementContext >> isConnectedTo: anObject [ 
	^ 	connectorConnections isNotNil and: [ connectorConnections includes: anObject  ].
]

{ #category : #accessing }
GtConnectorElementContext >> isLayoutSource [
	^ isLayoutSource
]

{ #category : #accessing }
GtConnectorElementContext >> isLayoutTarget [
	^ isLayoutTarget
]

{ #category : #accessing }
GtConnectorElementContext >> isVisualSource [
	^ isVisualSource
]

{ #category : #accessing }
GtConnectorElementContext >> isVisualTarget [
	^ isVisualTarget
]

{ #category : #accessing }
GtConnectorElementContext >> model [
	^ model
]

{ #category : #accessing }
GtConnectorElementContext >> model: anObject [
	self assert: [ hasModel not ].
	model := anObject.
	hasModel := true. 
]

{ #category : #accessing }
GtConnectorElementContext >> modelContains: anObject [
	hasModel ifFalse: [ ^ false ].
	^ model = anObject
]

{ #category : #accessing }
GtConnectorElementContext >> modelDo: aBloc [
	hasModel ifTrue:  [ aBloc value: model ].
]
