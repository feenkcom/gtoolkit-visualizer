Class {
	#name : #GtSequenceDiagramMessage,
	#superclass : #Object,
	#traits : 'TGtSequenceDiagramMessage',
	#classTraits : 'TGtSequenceDiagramMessage classTrait',
	#instVars : [
		'messages',
		'name'
	],
	#category : #'GToolkit-SequenceDiagram-Model'
}

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
