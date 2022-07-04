Class {
	#name : #GtSequenceDiagramMessageViewModel,
	#superclass : #Object,
	#traits : 'TGtWithSequenceDiagramMessage + TGtAnnouncer',
	#classTraits : 'TGtWithSequenceDiagramMessage classTrait + TGtAnnouncer classTrait',
	#instVars : [
		'announcer',
		'depth',
		'receiverViewModel',
		'senderViewModel'
	],
	#category : #'GToolkit-SequenceDiagram-View Models'
}

{ #category : #announcer }
GtSequenceDiagramMessageViewModel >> announcer [
	<return: #Announcer>
	^ announcer
]

{ #category : #accessing }
GtSequenceDiagramMessageViewModel >> depth [

	^ depth
]

{ #category : #accessing }
GtSequenceDiagramMessageViewModel >> depth: anObject [

	depth := anObject
]

{ #category : #initialization }
GtSequenceDiagramMessageViewModel >> initialize [
	super initialize.
	announcer := Announcer new
]

{ #category : #accessing }
GtSequenceDiagramMessageViewModel >> name [
	^ self hasMessage ifTrue: [ self message name ] ifFalse: [ '<unknown>' ]
]

{ #category : #'instance creation' }
GtSequenceDiagramMessageViewModel >> newMessageEdgeElementUsingBuilder: aBuilder [
	<return: #GtSequenceDiagramMessageEdgeElement>
	^ self message newMessageEdgeElementUsingBuilder: aBuilder viewModel: self
]

{ #category : #accessing }
GtSequenceDiagramMessageViewModel >> receiverViewModel [

	^ receiverViewModel
]

{ #category : #accessing }
GtSequenceDiagramMessageViewModel >> receiverViewModel: anObject [

	receiverViewModel := anObject
]

{ #category : #accessing }
GtSequenceDiagramMessageViewModel >> senderViewModel [

	^ senderViewModel
]

{ #category : #accessing }
GtSequenceDiagramMessageViewModel >> senderViewModel: anObject [

	senderViewModel := anObject
]
