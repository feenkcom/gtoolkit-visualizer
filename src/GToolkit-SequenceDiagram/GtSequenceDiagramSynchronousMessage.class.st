Class {
	#name : #GtSequenceDiagramSynchronousMessage,
	#superclass : #GtSequenceDiagramMessage,
	#instVars : [
		'sender',
		'receiver'
	],
	#category : #'GToolkit-SequenceDiagram-Model'
}

{ #category : #'instance creation' }
GtSequenceDiagramSynchronousMessage >> newMessageEdgeElementUsingBuilder: aBuilder viewModel: aViewModel [
	<return: #GtSequenceDiagramMessageEdgeElement>
	^ aBuilder newMessageCallEdgeElementForViewModel: aViewModel
]

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
