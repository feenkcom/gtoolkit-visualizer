Class {
	#name : #GtSequenceDiagramElementChildrenBuilder,
	#superclass : #Object,
	#instVars : [
		'specification'
	],
	#category : #'GToolkit-SequenceDiagram-UI'
}

{ #category : #'instace creation' }
GtSequenceDiagramElementChildrenBuilder class >> fromSequenceDiagramViewModel: aSequenceDiagramViewModel [
	| aSpecification |
	aSpecification := GtSequenceDiagramElementChildren
			fromSequenceDiagramViewModel: aSequenceDiagramViewModel.
	^ self new specification: aSpecification
]

{ #category : #building }
GtSequenceDiagramElementChildrenBuilder >> build [
	self buildParticipantHeaderElements.
	self buildMessageElements.
]

{ #category : #building }
GtSequenceDiagramElementChildrenBuilder >> buildMessageElements [
	| allMessageChildren |
	allMessageChildren := self specification messageViewModels
			collect: [ :aMessageViewModel | self computeMessageViewModelElements: aMessageViewModel ]
			thenReject: #isNil.

	self specification messageChildren: allMessageChildren
]

{ #category : #building }
GtSequenceDiagramElementChildrenBuilder >> buildParticipantHeaderElements [
	| allHeaderElements |
	allHeaderElements := self specification participantViewModels
			collect: [ :eachViewModel | eachViewModel asHeadElement margin: (BlInsets left: 5 right: 5) ].
	self specification participantHeaderElements: allHeaderElements
]

{ #category : #building }
GtSequenceDiagramElementChildrenBuilder >> computeMessageViewModelElements: aMessageViewModel [
	| aFromNodeElement aToNodeElement anEdgeElement aFromNodeIndex aToNodeIndex aMessageSpecification |
	aMessageViewModel senderViewModel = aMessageViewModel receiverViewModel
		ifTrue: [ ^ nil ].

	aFromNodeElement := GtSequenceDiagramMessageNodeElement new.
	aToNodeElement := GtSequenceDiagramMessageNodeElement new.
	anEdgeElement := GtSequenceDiagramMessageResponseEdgeElement new.
	anEdgeElement := aMessageViewModel newMessageEdgeElementUsingBuilder: self.

	aFromNodeElement graph beNode.
	aFromNodeElement messageViewModel: aMessageViewModel.
	aToNodeElement graph beNode.
	aToNodeElement messageViewModel: aMessageViewModel.

	anEdgeElement graph beEdge.
	anEdgeElement
		messageViewModel: aMessageViewModel;
		fromAnchor: (BlNearestPositionBoundsAnchor
				referenceElement: aFromNodeElement anchorElement
				relatedTo: aToNodeElement anchorElement);
		toAnchor: (BlNearestPositionBoundsAnchor
				referenceElement: aToNodeElement anchorElement
				relatedTo: aFromNodeElement anchorElement);
		clipChildren: false;
		zIndex: 2.
	
	aFromNodeIndex := self positionOfParticipant: aMessageViewModel senderViewModel.
	aToNodeIndex := self positionOfParticipant: aMessageViewModel receiverViewModel.

	aMessageSpecification := GtSequenceDiagramMessageChildren new
			positions: self specification numberOfParticipants;
			edgeElement: anEdgeElement;
			at: aFromNodeIndex putFromNodeElement: aFromNodeElement;
			at: aToNodeIndex putToNodeElement: aToNodeElement.

	aMessageSpecification nodeElements
		withIndexDo: [ :anElement :anIndex | 
			anElement
				ifNil: [ aMessageSpecification
						at: anIndex
						putElement: GtSequenceDiagramMessageNodeElement new ] ].

	^ aMessageSpecification
]

{ #category : #'instace creation' }
GtSequenceDiagramElementChildrenBuilder >> newMessageCallEdgeElementForViewModel: aViewModel [
	^ GtSequenceDiagramMessageSendEdgeElement new
]

{ #category : #'instace creation' }
GtSequenceDiagramElementChildrenBuilder >> newMessageResponseEdgeElementForViewModel: aViewModel [
	^ GtSequenceDiagramMessageResponseEdgeElement new
]

{ #category : #building }
GtSequenceDiagramElementChildrenBuilder >> positionOfParticipant: aParticipantViewModel [
	<return: #Integer>
	^ self specification participantViewModels indexOf: aParticipantViewModel
]

{ #category : #accessing }
GtSequenceDiagramElementChildrenBuilder >> specification [

	^ specification
]

{ #category : #accessing }
GtSequenceDiagramElementChildrenBuilder >> specification: anObject [

	specification := anObject
]
