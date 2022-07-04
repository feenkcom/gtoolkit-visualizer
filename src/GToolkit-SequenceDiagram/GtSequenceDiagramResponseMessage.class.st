Class {
	#name : #GtSequenceDiagramResponseMessage,
	#superclass : #GtSequenceDiagramMessage,
	#instVars : [
		'sender',
		'receiver'
	],
	#category : #'GToolkit-SequenceDiagram-Model'
}

{ #category : #accessing }
GtSequenceDiagramResponseMessage >> newMessageEdgeElementUsingBuilder: aBuilder viewModel: aViewModel [
	<return: #GtSequenceDiagramMessageEdgeElement>
	^ aBuilder newMessageResponseEdgeElementForViewModel: aViewModel
]

{ #category : #accessing }
GtSequenceDiagramResponseMessage >> receiver [

	^ receiver
]

{ #category : #accessing }
GtSequenceDiagramResponseMessage >> receiver: anObject [

	receiver := anObject
]

{ #category : #accessing }
GtSequenceDiagramResponseMessage >> sender [

	^ sender
]

{ #category : #accessing }
GtSequenceDiagramResponseMessage >> sender: anObject [

	sender := anObject
]
