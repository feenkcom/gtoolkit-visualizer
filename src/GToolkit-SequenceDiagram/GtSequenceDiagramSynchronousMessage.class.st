Class {
	#name : #GtSequenceDiagramSynchronousMessage,
	#superclass : #GtSequenceDiagramMessage,
	#instVars : [
		'sender',
		'receiver'
	],
	#category : #'GToolkit-SequenceDiagram-Model'
}

{ #category : #accessing }
GtSequenceDiagramSynchronousMessage >> receiver [

	^ receiver
]

{ #category : #accessing }
GtSequenceDiagramSynchronousMessage >> receiver: anObject [

	receiver := anObject
]

{ #category : #accessing }
GtSequenceDiagramSynchronousMessage >> sender [

	^ sender
]

{ #category : #accessing }
GtSequenceDiagramSynchronousMessage >> sender: anObject [

	sender := anObject
]
