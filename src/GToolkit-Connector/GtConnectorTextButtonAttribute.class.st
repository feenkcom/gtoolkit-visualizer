Class {
	#name : #GtConnectorTextButtonAttribute,
	#superclass : #BrTextAdornmentAttribute,
	#traits : 'TBlEventTarget',
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'actionBlock',
		'link',
		'eventDispatcher'
	],
	#category : #'GToolkit-Connector-Extensions'
}

{ #category : #'instance creation' }
GtConnectorTextButtonAttribute class >> link: aConnectorLink [
	^ self new initializeWith: aConnectorLink
]

{ #category : #'instance creation' }
GtConnectorTextButtonAttribute class >> source: aSource target: aTarget [
	^ self new initializeWith: (GtConnectorLink source: aSource target: aTarget)
]

{ #category : #accessing }
GtConnectorTextButtonAttribute >> actionBlock [
	^ actionBlock
]

{ #category : #accessing }
GtConnectorTextButtonAttribute >> actionBlock: aBlock [
	actionBlock := aBlock
]

{ #category : #initialization }
GtConnectorTextButtonAttribute >> affect: aTBrTextEditorTextualPiece in: anEditorElement [
	^ self newButton
]

{ #category : #'event management accessing' }
GtConnectorTextButtonAttribute >> eventDispatcher [
	"Return an object responsible for event dispatching"
	<return: #BlDirectEventDispatcher>

	^ eventDispatcher
]

{ #category : #initialization }
GtConnectorTextButtonAttribute >> initialize [
	super initialize.
	
	eventDispatcher := BlDirectEventDispatcher on: self.
	actionBlock := [  ].
	
	self beAppend
]

{ #category : #initialization }
GtConnectorTextButtonAttribute >> initializeWith: aLink [
	link := aLink
]

{ #category : #accessing }
GtConnectorTextButtonAttribute >> link [
	<return: #GtConnectorLink>

	^ link
]

{ #category : #initialization }
GtConnectorTextButtonAttribute >> newButton [
	<return: #BlElement>
	| aButton |
	aButton := BlElement new
		size: 6 @ 6;
		margin: (BlInsets top: 0 right: 2 bottom: 0 left: 2);
		background: (Color gray alpha: 0.5);
		geometry: BlEllipseGeometry new;
		addEventHandlerOn: BlClickEvent
			do: [ :anEvent | actionBlock value: anEvent ];
		yourself.
	aButton connector model: self target.
	aButton connector beVisualSource.
	^ aButton
]

{ #category : #printing }
GtConnectorTextButtonAttribute >> printOn: stream [
	super printOn: stream.
	stream space.
	self source printOn: stream.
	stream nextPutAll: '->'.
	self target printOn: stream
]

{ #category : #accessing }
GtConnectorTextButtonAttribute >> source [
	^ self link source
]

{ #category : #accessing }
GtConnectorTextButtonAttribute >> target [
	^ self link target
]
