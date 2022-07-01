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
	| aFromNodeElement aToNodeElement anEdgeElement aFromNodeIndex aToNodeIndex aMessageSpecification aLabel |
	aMessageViewModel senderViewModel = aMessageViewModel receiverViewModel
		ifTrue: [ ^ nil ].

	aFromNodeElement := GtSequenceDiagramMessageNodeElement new.
	aToNodeElement := GtSequenceDiagramMessageNodeElement new.
	anEdgeElement := GtSequenceDiagramMessageEdgeElement new.

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
		toHead: (BlArrowheadTriangle new
				background: Color black;
				border: (BlBorder paint: Color black width: 1));
		clipChildren: false;
		zIndex: 2.

	aLabel := BrLabel new
			fitContent;
			aptitude: ((BrGlamorousLabelAptitude new 
				fontSize: 6;
				background: Color white));
			text: aMessageViewModel name;
			zIndex: 3;
			constraintsDo: [ :c | 
				c ignoreByLayout.
				c ignored horizontal alignCenter.
				c ignored vertical alignCenter.
				c margin: (BlInsets top: -1) ].
	anEdgeElement addChild: aLabel.

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
						putElement: GtSequenceDiagramMessageNodeElement new	"(BlElement new size: 3 @ 3)" ] ].

	^ aMessageSpecification
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
