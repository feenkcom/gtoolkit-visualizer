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
	| allHeaderElements aLongestMethodName aMargin |
	aLongestMethodName := self specification messageViewModels
			detectMax: [ :each | each name size ].
	aMargin := aLongestMethodName
			ifNil: [ BlInsets left: 5 right: 5 ]
			ifNotNil: [ | aNameLegth |
				aNameLegth := aLongestMethodName name size.
				aNameLegth < 15
					ifTrue: [ BlInsets left: 5 right: 5 ]
					ifFalse: [ | anExtra |
						anExtra := (aNameLegth - 15) * 2.
						BlInsets left: 5 + anExtra right: 5 + anExtra ] ].

	allHeaderElements := self specification participantViewModels
			collect: [ :eachViewModel | 
				| aHeadElement |
				aHeadElement := eachViewModel asHeadElement.
				aHeadElement margin: aMargin.
				aHeadElement ].
	self specification participantHeaderElements: allHeaderElements
]

{ #category : #building }
GtSequenceDiagramElementChildrenBuilder >> computeMessageViewModelElements: aMessageViewModel [
	<return: #GtSequenceDiagramMessageChildren>
	^ aMessageViewModel newMessageElementUsingBuilder: self.
]

{ #category : #building }
GtSequenceDiagramElementChildrenBuilder >> computeSelfMessageViewModelElements: aMessageViewModel [
	<return: #GtSequenceDiagramMessageChildren>
	| aNodeElement aMessageSpecification aNodeIndex |
	aNodeElement := GtSequenceDiagramSelfMessageNodeElement new
			messageViewModel: aMessageViewModel.

	aNodeIndex := self positionOfParticipant: aMessageViewModel senderViewModel.

	aMessageSpecification := GtSequenceDiagramMessageChildren new
			positions: self specification numberOfParticipants;
			at: aNodeIndex putFromNodeElement: aNodeElement.

	self fillMessageSpecificationEmptyNodes: aMessageSpecification.

	^ aMessageSpecification
]

{ #category : #building }
GtSequenceDiagramElementChildrenBuilder >> computeSendMessageViewModelElements: aMessageViewModel [
	| aFromNodeElement aToNodeElement anEdgeElement aFromNodeIndex aToNodeIndex aMessageSpecification |
	aMessageViewModel senderViewModel = aMessageViewModel receiverViewModel
		ifTrue: [ ^ self computeSelfMessageViewModelElements: aMessageViewModel ].

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
		zIndex: GtSequenceDiagramUtility messageZIndex.

	aFromNodeIndex := self positionOfParticipant: aMessageViewModel senderViewModel.
	aToNodeIndex := self positionOfParticipant: aMessageViewModel receiverViewModel.

	aMessageSpecification := GtSequenceDiagramMessageChildren new
			positions: self specification numberOfParticipants;
			edgeElement: anEdgeElement;
			at: aFromNodeIndex putFromNodeElement: aFromNodeElement;
			at: aToNodeIndex putToNodeElement: aToNodeElement.
	self fillMessageSpecificationEmptyNodes: aMessageSpecification.

	^ aMessageSpecification
]

{ #category : #building }
GtSequenceDiagramElementChildrenBuilder >> fillMessageSpecificationEmptyNodes: aMessageSpecification [
	aMessageSpecification nodeElements
		withIndexDo: [ :anElement :anIndex | 
			anElement
				ifNil: [ aMessageSpecification
						at: anIndex
						putElement: GtSequenceDiagramVerticalLineElement new ] ]
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
