Class {
	#name : #GtSequenceDiagramMessage,
	#superclass : #Object,
	#traits : 'TGtSequenceDiagramMessage',
	#classTraits : 'TGtSequenceDiagramMessage classTrait',
	#instVars : [
		'messages',
		'name',
		'model'
	],
	#category : #'GToolkit-SequenceDiagram-Model'
}

{ #category : #'gt - extensions' }
GtSequenceDiagramMessage >> gtMessagesFor: aView [
	<gtView>
	self messages ifNil: [ ^ aView empty ].
	^ aView columnedTree
		title: 'Messages';
		priority: 10;
		items: [ {self} ];
		children: #messages;
		expandUpTo: 2;
		column: 'Name' text: #name;
		column: 'Sender'
			text: [ :aMessage | aMessage sender ifNotNil: [ :v | v name ] ];
		column: 'Receiver'
			text: [ :aMessage | aMessage receiver ifNotNil: [ :v | v name ] ];
		actionUpdateButton
]

{ #category : #testing }
GtSequenceDiagramMessage >> hasModel [
	^ model isNotNil
]

{ #category : #initialization }
GtSequenceDiagramMessage >> initialize [
	super initialize.

	messages := Array empty
]

{ #category : #'api - building' }
GtSequenceDiagramMessage >> message: aMessage [
	self messages: (self messages copyWith: aMessage)
]

{ #category : #accessing }
GtSequenceDiagramMessage >> messages [
	<return: #Collection of: #TGtSequenceDiagramMessage>
	^ messages
]

{ #category : #accessing }
GtSequenceDiagramMessage >> messages: anObject [

	messages := anObject
]

{ #category : #accessing }
GtSequenceDiagramMessage >> model [
	^ model ifNotNil: [ :v | v value ]
]

{ #category : #accessing }
GtSequenceDiagramMessage >> model: anObject [
	model := GtSequenceDiagramValue new value: anObject
]

{ #category : #accessing }
GtSequenceDiagramMessage >> name [
	^ name
]

{ #category : #accessing }
GtSequenceDiagramMessage >> name: aString [
	name := aString
]

{ #category : #'instance creation' }
GtSequenceDiagramMessage >> newMessageEdgeElementUsingBuilder: aBuilder viewModel: aViewModel [
	<return: #GtSequenceDiagramMessageEdgeElement>
	^ self subclassResponsibility
]

{ #category : #'instance creation' }
GtSequenceDiagramMessage >> newMessageElementUsingBuilder: aBuilder viewModel: aViewModel [
	<return: #GtSequenceDiagramMessageChildren>
	^ self subclassResponsibility
]

{ #category : #accessing }
GtSequenceDiagramMessage >> receiver [
	<return: #TGtSequenceDiagramParticipant>
	^ self subclassResponsibility 
]

{ #category : #accessing }
GtSequenceDiagramMessage >> sender [
	<return: #TGtSequenceDiagramParticipant>
	^ self subclassResponsibility 
]
