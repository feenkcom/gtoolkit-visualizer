Class {
	#name : #GtSequenceDiagramElementChildren,
	#superclass : #Object,
	#instVars : [
		'sequenceDiagramViewModel',
		'sequenceDiagram',
		'participantViewModels',
		'participantHeaderElements',
		'messageChildren',
		'messageViewModels'
	],
	#category : #'GToolkit-SequenceDiagram-UI'
}

{ #category : #'instance creation' }
GtSequenceDiagramElementChildren class >> fromSequenceDiagramViewModel: aSequenceDiagramViewModel [
	| anInstance |
	anInstance := self new.
	anInstance sequenceDiagramViewModel: aSequenceDiagramViewModel.
	anInstance sequenceDiagram: aSequenceDiagramViewModel sequenceDiagram.
	anInstance participantViewModels: aSequenceDiagramViewModel participantViewModels.
	anInstance messageViewModels: aSequenceDiagramViewModel messageViewModels.
	^ anInstance
]

{ #category : #accessing }
GtSequenceDiagramElementChildren >> messageChildren [
	<return: #GtSequenceDiagramMessageChildren>
	^ messageChildren
]

{ #category : #accessing }
GtSequenceDiagramElementChildren >> messageChildren: anObject [

	messageChildren := anObject
]

{ #category : #accessing }
GtSequenceDiagramElementChildren >> messageViewModels [

	^ messageViewModels
]

{ #category : #accessing }
GtSequenceDiagramElementChildren >> messageViewModels: anObject [

	messageViewModels := anObject
]

{ #category : #accessing }
GtSequenceDiagramElementChildren >> numberOfParticipants [
	<return: #Integer>
	^ self participantViewModels size
]

{ #category : #accessing }
GtSequenceDiagramElementChildren >> participantHeaderElements [

	^ participantHeaderElements
]

{ #category : #accessing }
GtSequenceDiagramElementChildren >> participantHeaderElements: anObject [

	participantHeaderElements := anObject
]

{ #category : #accessing }
GtSequenceDiagramElementChildren >> participantViewModels [

	^ participantViewModels
]

{ #category : #accessing }
GtSequenceDiagramElementChildren >> participantViewModels: anObject [

	participantViewModels := anObject
]

{ #category : #accessing }
GtSequenceDiagramElementChildren >> sequenceDiagram [

	^ sequenceDiagram
]

{ #category : #accessing }
GtSequenceDiagramElementChildren >> sequenceDiagram: anObject [

	sequenceDiagram := anObject
]

{ #category : #accessing }
GtSequenceDiagramElementChildren >> sequenceDiagramViewModel [

	^ sequenceDiagramViewModel
]

{ #category : #accessing }
GtSequenceDiagramElementChildren >> sequenceDiagramViewModel: anObject [

	sequenceDiagramViewModel := anObject
]
