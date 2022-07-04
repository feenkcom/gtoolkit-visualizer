Class {
	#name : #GtSequenceDiagramSendMessage,
	#superclass : #GtSequenceDiagramMessage,
	#instVars : [
		'sender',
		'receiver'
	],
	#category : #'GToolkit-SequenceDiagram-Model'
}

{ #category : #'instance creation' }
GtSequenceDiagramSendMessage >> newMessageEdgeElementUsingBuilder: aBuilder viewModel: aViewModel [
	<return: #GtSequenceDiagramMessageEdgeElement>
	^ aBuilder newMessageCallEdgeElementForViewModel: aViewModel
]

{ #category : #accessing }
GtSequenceDiagramSendMessage >> receiver [

	^ receiver
]

{ #category : #accessing }
GtSequenceDiagramSendMessage >> receiver: anObject [

	receiver := anObject
]

{ #category : #accessing }
GtSequenceDiagramSendMessage >> sender [

	^ sender
]

{ #category : #accessing }
GtSequenceDiagramSendMessage >> sender: anObject [

	sender := anObject
]
