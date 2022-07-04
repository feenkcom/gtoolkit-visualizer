Class {
	#name : #GtSequenceDiagramSelfMessage,
	#superclass : #GtSequenceDiagramMessage,
	#instVars : [
		'participant'
	],
	#category : #'GToolkit-SequenceDiagram-Model'
}

{ #category : #accessing }
GtSequenceDiagramSelfMessage >> newMessageElementUsingBuilder: aBuilder viewModel: aViewModel [
	<return: #GtSequenceDiagramMessageChildren>
	^ aBuilder computeSelfMessageViewModelElements: aViewModel
]

{ #category : #accessing }
GtSequenceDiagramSelfMessage >> participant [
	<return: #TGtSequenceDiagramParticipant>
	^ participant
]

{ #category : #accessing }
GtSequenceDiagramSelfMessage >> participant: aParticipant [

	participant := aParticipant
]

{ #category : #accessing }
GtSequenceDiagramSelfMessage >> receiver [
	<return: #TGtSequenceDiagramParticipant>
	^ self participant
]

{ #category : #accessing }
GtSequenceDiagramSelfMessage >> sender [
	<return: #TGtSequenceDiagramParticipant>
	^ self participant
]
