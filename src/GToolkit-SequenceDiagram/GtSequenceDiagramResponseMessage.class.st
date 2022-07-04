Class {
	#name : #GtSequenceDiagramResponseMessage,
	#superclass : #GtSequenceDiagramMessage,
	#instVars : [
		'sender',
		'receiver'
	],
	#category : #'GToolkit-SequenceDiagram-Model'
}

{ #category : #'instance creation' }
GtSequenceDiagramResponseMessage >> newMessageEdgeElementUsingBuilder: aBuilder viewModel: aViewModel [
	<return: #GtSequenceDiagramMessageEdgeElement>
	^ aBuilder newMessageResponseEdgeElementForViewModel: aViewModel
]

{ #category : #'instance creation' }
GtSequenceDiagramResponseMessage >> newMessageElementUsingBuilder: aBuilder viewModel: aViewModel [
	<return: #GtSequenceDiagramMessageChildren>
	^ aBuilder computeSendMessageViewModelElements: aViewModel
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
