Class {
	#name : #GtWardleyMapDecoratorWithScripterExamples,
	#superclass : #Object,
	#traits : 'TBlDevScripterExamples',
	#classTraits : 'TBlDevScripterExamples classTrait',
	#category : #'GToolkit-WardleyMap-Examples'
}

{ #category : #'examples - proposed modifications' }
GtWardleyMapDecoratorWithScripterExamples >> assertScripter: aScripter allPropositionElementCounter: anInteger [ 
	aScripter
		substeps: 'Assert map all-proposition' 
		do: [ :aStep | 
			aStep assert 
				label: ('Assert map all-proposition element counter is {1}' format: { anInteger });
				value: [ :anElement | anElement counter ] equals: anInteger;
				// GtWardleyMapAllPropositionElement;
				play.
			
			aStep assert 
				label: ('Assert map all-proposition element is{1} visible'
					format: { anInteger isZero ifTrue: [ ' not' ] ifFalse: [ '' ] });
				value: [ :anElement | anElement visibility ] 
					equals: (anInteger isZero 
						ifTrue: [ BlVisibility gone ] 
						ifFalse: [ BlVisibility visible ]) ;
				// GtWardleyMapAllPropositionElement;
				play.
	].
]

{ #category : #'examples - proposed modifications' }
GtWardleyMapDecoratorWithScripterExamples >> assertScripter: aStep nonExistentPropositionElementIds: aCollectionOfIds ofEdgeNamed: anEdgeName [
	aStep
		substeps: ('Assert "{1}" proposition elements' format: {anEdgeName})
		do: [ :aSubStep | 
			aSubStep assert
				label: ('Assert "{1}" proposition element does not exist' format: {anEdgeName});
				notExists;
				// GtWardleyMapEdgePropositionElement;
				@ [ :anElement | anElement wardleyMapEdgeViewModel label = anEdgeName ];
				play.

			aCollectionOfIds
				do: [ :eachElementId | 
					aSubStep assert
						label: ('Assert "{1}" proposition {2} does not exist'
								format: {anEdgeName. eachElementId asSymbol});
						notExists;
						// GtWardleyMapEdgeElement;
						@ [ :anElement | 
							anElement graph isNode
								and: [ anElement wardleyMapNodeViewModel label = anEdgeName ] ];
						/ eachElementId;
						play ] ]
]

{ #category : #'examples - proposed modifications' }
GtWardleyMapDecoratorWithScripterExamples >> assertScripter: aStep nonExistentPropositionElementIds: aCollectionOfIds ofNodeNamed: aNodeName [
	aStep
		substeps: ('Assert "{1}" proposition elements' format: {aNodeName})
		do: [ :aSubStep | 
			aSubStep assert
				label: ('Assert "{1}" proposition element does not exist' format: {aNodeName});
				notExists;
				// GtWardleyMapNodePropositionElement;
				@ [ :anElement | anElement wardleyMapNodeViewModel label = aNodeName ];
				play.

			aCollectionOfIds
				do: [ :eachElementId | 
					aSubStep assert
						label: ('Assert "{1}" proposition {2} does not exist'
								format: {aNodeName. eachElementId asSymbol});
						notExists;
						// GtWardleyMapNodeElement;
						@ [ :anElement | 
							anElement graph isNode
								and: [ anElement wardleyMapNodeViewModel label = aNodeName ] ];
						/ eachElementId;
						play ] ]
]

{ #category : #'examples - proposed modifications' }
GtWardleyMapDecoratorWithScripterExamples >> collectWardleyAnnouncements: aScripter [
	| aCollection |
	aCollection := OrderedCollection new.
	aScripter userData at: #announcements put: aCollection.
	aScripter model weak
		when: Announcement
		send: #add:
		to: aCollection.
	aScripter element wardleyMapViewModel weak
		when: Announcement
		send: #add:
		to: aCollection
]

{ #category : #'examples - proposed modifications' }
GtWardleyMapDecoratorWithScripterExamples >> mapWithNodes [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self
			scripterWithModel: [ GtWardleyMapDecoratorExamples new mapWithNodes ]
			element: [ :aMap | 
				GtWardleyMapElement new
					wardleyMapViewModel: (GtWardleyMapViewModel new wardleyMapModel: aMap) ].

	^ aScripter
]

{ #category : #'examples - highlights' }
GtWardleyMapDecoratorWithScripterExamples >> mapWithNodesAddHighlights [
	<gtExample>
	<return: #BlScripter>
	| aScripter aNodeName anEdgeName |
	aScripter := self mapWithNodes.

	aNodeName := 'Node A'.

	aScripter do
		label: 'Add Node A highlight';
		block: [ :aMapElement | 
			| aMap aNodeA |
			aMap := aMapElement wardleyMapViewModel wardleyMapModel.
			aNodeA := aMap
					nodeWithName: aNodeName
					ifFound: [ :aNode | aNode ]
					ifNone: [ nil ].
			aMapElement wardleyMapViewModel
				nodeViewModelFor: aNodeA
				ifFound: [ :theNode | 
					theNode
						addWardleyMapDecoratorViewModel: GtWardleyMapHighlight new asDecoratorViewModel ]
				ifNone: [ AssertionFailure signal: 'Node A not found' ] ];
		play.

	aScripter assert
		label: 'Assert Node A highlight element exists';
		exists;
		// GtWardleyMapNodePropositionElement;
		@ [ :anElement | anElement wardleyMapNodeViewModel label = aNodeName ];
		play.

	anEdgeName := 'Edge A->B'.

	aScripter do
		label: 'Add Edge A->B highlight';
		block: [ :aMapElement | 
			| aMap anEdgeAB |
			aMap := aMapElement wardleyMapViewModel wardleyMapModel.
			anEdgeAB := aMap
					edgeWithName: anEdgeName
					ifFound: [ :anEdge | anEdge ]
					ifNone: [ nil ].
			aMapElement wardleyMapViewModel
				edgeViewModelFor: anEdgeAB
				ifFound: [ :theEdge | 
					theEdge
						addWardleyMapDecoratorViewModel: GtWardleyMapHighlight new asDecoratorViewModel ]
				ifNone: [ AssertionFailure signal: 'Edge A->B not found' ] ];
		play.

	aScripter assert
		label: 'Assert Edge A->B highlight element exists';
		exists;
		// GtWardleyMapEdgePropositionElement;
		@ [ :anElement | anElement wardleyMapEdgeViewModel label = anEdgeName ];
		play.

	^ aScripter
]

{ #category : #'examples - highlights' }
GtWardleyMapDecoratorWithScripterExamples >> mapWithNodesAddHighlights_DeleteNodeA [
	<gtExample>
	<return: #BlScripter>
	| aScripter aNodeName anEdgeName |
	aScripter := self mapWithNodesAddHighlights.

	aNodeName := 'Node A'.
	anEdgeName := 'Edge A->B'.

	aScripter do
		label: 'Delete Node A';
		block: [ :aMap | 
			aMap
				nodeWithName: aNodeName
				ifFound: [ :aNode | aMap removeNode: aNode ]
				ifNone: [ AssertionFailure signal: 'Node A not found' ] ];
		onModel;
		play.

	aScripter assert
		label: 'Assert Node A highlight element does not exist';
		notExists;
		// GtWardleyMapNodePropositionElement;
		@ [ :anElement | anElement wardleyMapNodeViewModel label = aNodeName ];
		play.

	aScripter assert
		label: 'Assert Edge A->B highlight element does not exist';
		notExists;
		// GtWardleyMapEdgePropositionElement;
		@ [ :anElement | anElement wardleyMapEdgeViewModel label = anEdgeName ];
		play.

	^ aScripter
]

{ #category : #'examples - proposed modifications' }
GtWardleyMapDecoratorWithScripterExamples >> mapWithNodesAddNodeDWithAddProposition [
	<gtExample>
	<return: #BlScripter>
	| aScripter aNodeName aNodeD anEdgeCD aNodeC anEdgeCDName |
	aScripter := self
			scripterWithModel: [ GtWardleyMapDecoratorExamples new mapWithNodes ]
			element: [ :aModel | 
				GtWardleyMapElement new
					wardleyMapViewModel: (GtWardleyMapViewModel new wardleyMapModel: aModel) ].

	aNodeD := GtWardleyMapNodeModelExamples new newNode.
	aNodeName := 'Node D'.
	aNodeD
		label: aNodeName;
		coordinate: 0.6 @ 0.8;
		addWardleyMapDecoratorModel: GtWardleyMapAddProposition new.

	aScripter do
		label: 'Add Node D';
		block: [ :anElement | 
			(BrAsyncElementPromise on: anElement)
				promise: [ aScripter model addNode: aNodeD ] asAsyncPromise ];
		play.

	aScripter
		substeps: 'Assert Node D proposition elements'
		do: [ :aStep | 
			aStep assert
				label: 'Assert Node D proposition element exists';
				exists;
				// GtWardleyMapNodePropositionElement;
				@ [ :anElement | anElement wardleyMapNodeViewModel label = aNodeName ];
				play.

			aStep assert
				label: 'Assert Node D proposition accept button exists';
				exists;
				// GtWardleyMapNodeElement;
				@ [ :anElement | 
					anElement graph isNode
						and: [ anElement wardleyMapNodeViewModel label = aNodeName ] ];
				// GtWardleyCenterRightOuterDecoratorId;
				/ GtWardleyMapAddAcceptId;
				play.

			aStep assert
				label: 'Assert Node D proposition reject button exists';
				exists;
				// GtWardleyMapNodeElement;
				@ [ :anElement | 
					anElement graph isNode
						and: [ anElement wardleyMapNodeViewModel label = aNodeName ] ];
				// GtWardleyCenterRightOuterDecoratorId;
				/ GtWardleyMapAddRejectId;
				play ].

	aNodeC := aScripter model
			nodeWithName: 'Node C'
			ifFound: [ :aNode | aNode ]
			ifNone: [ nil ].

	anEdgeCDName := 'Edge C->D'.
	anEdgeCD := GtWardleyMapEdgeModel new
			label: 'Edge C->D';
			fromNode: aNodeC;
			toNode: aNodeD;
			width: 2;
			addWardleyMapDecoratorModel: GtWardleyMapAddProposition new.

	aScripter do
		label: 'Add Edge C->D';
		block: [ :anElement | 
			(BrAsyncElementPromise on: anElement)
				promise: [ aScripter model addEdge: anEdgeCD ] asAsyncPromise ];
		play.

	aScripter
		substeps: 'Assert Edge C->D proposition elements'
		do: [ :aStep | 
			aStep assert
				label: 'Assert Edge C->D proposition element exists';
				exists;
				// GtWardleyMapEdgePropositionElement;
				@ [ :anElement | anElement wardleyMapEdgeViewModel label = anEdgeCDName ];
				play.

			aStep assert
				label: 'Assert Edge C->D proposition accept button exists';
				exists;
				// GtWardleyMapEdgeElement;
				@ [ :anElement | 
					anElement graph isEdge
						and: [ anElement wardleyMapEdgeViewModel label = anEdgeCDName ] ];
				// GtWardleyMapAddAcceptId;
				play.

			aStep assert
				label: 'Assert Edge C->D proposition reject button exists';
				exists;
				// GtWardleyMapEdgeElement;
				@ [ :anElement | 
					anElement graph isEdge
						and: [ anElement wardleyMapEdgeViewModel label = anEdgeCDName ] ];
				// GtWardleyMapAddRejectId;
				play ].

	^ aScripter
]

{ #category : #'examples - proposed modifications' }
GtWardleyMapDecoratorWithScripterExamples >> mapWithNodesAddPropositions [
	<gtExample>
	<return: #BlScripter>
	| aScripter aNodeName |
	aScripter := self
			scripterWithModel: [ GtWardleyMapDecoratorExamples new mapWithNodes ]
			element: [ :aModel | 
				GtWardleyMapElement new
					wardleyMapViewModel: (GtWardleyMapViewModel new wardleyMapModel: aModel) ].

	aNodeName := 'Node A'.

	aScripter do
		label: 'Add Node A add-proposition';
		block: [ :aModel | 
			aScripter model
				nodeWithName: aNodeName
				ifFound: [ :theNode | theNode addWardleyMapDecoratorModel: GtWardleyMapAddProposition new ]
				ifNone: [ nil ] ];
		onModel;
		play.

	aScripter
		substeps: 'Assert Node A proposition elements'
		do: [ :aStep | 
			aStep assert
				label: 'Assert Node A proposition element exists';
				exists;
				// GtWardleyMapNodePropositionElement;
				@ [ :anElement | anElement wardleyMapNodeViewModel label = aNodeName ];
				play.

			aStep assert
				label: 'Assert Node A proposition accept button exists';
				exists;
				// GtWardleyMapNodeElement;
				@ [ :anElement | 
					anElement graph isNode
						and: [ anElement wardleyMapNodeViewModel label = aNodeName ] ];
				// GtWardleyCenterRightOuterDecoratorId;
				/ GtWardleyMapAddAcceptId;
				play.

			aStep assert
				label: 'Assert Node A proposition reject button exists';
				exists;
				// GtWardleyMapNodeElement;
				@ [ :anElement | 
					anElement graph isNode
						and: [ anElement wardleyMapNodeViewModel label = aNodeName ] ];
				// GtWardleyCenterRightOuterDecoratorId;
				/ GtWardleyMapAddRejectId;
				play ].

	^ aScripter
]

{ #category : #'examples - proposed modifications' }
GtWardleyMapDecoratorWithScripterExamples >> mapWithProposedModifications [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self
			scripterWithModel: [ GtWardleyMapDecoratorExamples new mapWithProposedModifications ]
			element: [ :aMap :theScripter | 
				| aViewModel |
				aViewModel := GtWardleyMapViewModel new wardleyMapModel: aMap.
				theScripter userData at: GtWardleyMapViewModel put: aViewModel.
				GtWardleyMapElement new wardleyMapViewModel: aViewModel ].

	aScripter
		substeps: 'Assert Node A proposition elements'
		do: [ :aStep | 
			| aNodeName |
			aNodeName := 'Node A'.
			aStep assert
				label: 'Assert Node A proposition element exists';
				exists;
				// GtWardleyMapNodePropositionElement;
				@ [ :anElement | anElement wardleyMapNodeViewModel label = aNodeName ];
				play.

			aStep assert
				label: 'Assert Node A proposition accept button exists';
				exists;
				// GtWardleyMapNodeElement;
				@ [ :anElement | 
					anElement graph isNode
						and: [ anElement wardleyMapNodeViewModel label = aNodeName ] ];
				// GtWardleyCenterRightOuterDecoratorId;
				/ GtWardleyMapAddAcceptId;
				play.

			aStep assert
				label: 'Assert Node A proposition reject button exists';
				exists;
				// GtWardleyMapNodeElement;
				@ [ :anElement | 
					anElement graph isNode
						and: [ anElement wardleyMapNodeViewModel label = aNodeName ] ];
				// GtWardleyCenterRightOuterDecoratorId;
				/ GtWardleyMapAddRejectId;
				play ].

	aScripter
		substeps: 'Assert Node B proposition elements'
		do: [ :aStep | 
			| aNodeName |
			aNodeName := 'Node B'.
			aStep assert
				label: 'Assert Node B proposition element exists';
				exists;
				// GtWardleyMapNodePropositionElement;
				@ [ :anElement | anElement wardleyMapNodeViewModel label = aNodeName ];
				play.

			aStep assert
				label: 'Assert Node B proposition names button exists';
				exists;
				// GtWardleyMapNodeElement;
				@ [ :anElement | 
					anElement graph isNode
						and: [ anElement wardleyMapNodeViewModel label = aNodeName ] ];
				// GtWardleyCenterRightOuterDecoratorId;
				/ GtWardleyMapRenameProposalsId;
				play.

			aStep assert
				label: 'Assert Node B proposition accept button exists';
				exists;
				// GtWardleyMapNodeElement;
				@ [ :anElement | 
					anElement graph isNode
						and: [ anElement wardleyMapNodeViewModel label = aNodeName ] ];
				// GtWardleyCenterRightOuterDecoratorId;
				/ GtWardleyMapRenameAcceptId;
				play.

			aStep assert
				label: 'Assert Node B proposition reject button exists';
				exists;
				// GtWardleyMapNodeElement;
				@ [ :anElement | 
					anElement graph isNode
						and: [ anElement wardleyMapNodeViewModel label = aNodeName ] ];
				// GtWardleyCenterRightOuterDecoratorId;
				/ GtWardleyMapRenameRejectId;
				play ].

	aScripter
		substeps: 'Assert Node C proposition elements'
		do: [ :aStep | 
			| aNodeName |
			aNodeName := 'Node C'.
			aStep assert
				label: 'Assert Node C proposition element exists';
				exists;
				// GtWardleyMapNodePropositionElement;
				@ [ :anElement | anElement wardleyMapNodeViewModel label = aNodeName ];
				play.

			aStep assert
				label: 'Assert Node C proposition accept button exists';
				exists;
				// GtWardleyMapNodeElement;
				@ [ :anElement | 
					anElement graph isNode
						and: [ anElement wardleyMapNodeViewModel label = aNodeName ] ];
				// GtWardleyCenterRightOuterDecoratorId;
				/ GtWardleyMapRemoveAcceptId;
				play.

			aStep assert
				label: 'Assert Node C proposition reject button exists';
				exists;
				// GtWardleyMapNodeElement;
				@ [ :anElement | 
					anElement graph isNode
						and: [ anElement wardleyMapNodeViewModel label = aNodeName ] ];
				// GtWardleyCenterRightOuterDecoratorId;
				/ GtWardleyMapRemoveRejectId;
				play ].

	aScripter
		substeps: 'Assert Edge A->B proposition elements'
		do: [ :aStep | 
			| anEdgeName |
			anEdgeName := 'Edge A->B'.
			aStep assert
				label: 'Assert Edge A->B proposition element exists';
				exists;
				// GtWardleyMapEdgePropositionElement;
				@ [ :anElement | anElement wardleyMapEdgeViewModel label = anEdgeName ];
				play.

			aStep assert
				label: 'Assert Edge A->B proposition accept button exists';
				exists;
				// GtWardleyMapEdgeElement;
				@ [ :anElement | 
					anElement graph isEdge
						and: [ anElement wardleyMapEdgeViewModel label = anEdgeName ] ];
				// GtWardleyMapAddAcceptId;
				play.

			aStep assert
				label: 'Assert Edge A->B proposition reject button exists';
				exists;
				// GtWardleyMapEdgeElement;
				@ [ :anElement | 
					anElement graph isEdge
						and: [ anElement wardleyMapEdgeViewModel label = anEdgeName ] ];
				// GtWardleyMapAddRejectId;
				play ].

	aScripter
		substeps: 'Assert Edge A->C proposition elements'
		do: [ :aStep | 
			| anEdgeName |
			anEdgeName := 'Edge A->C'.
			aStep assert
				label: 'Assert Edge A->C proposition element exists';
				exists;
				// GtWardleyMapEdgePropositionElement;
				@ [ :anElement | anElement wardleyMapEdgeViewModel label = anEdgeName ];
				play.

			aStep assert
				label: 'Assert Edge A->C proposition accept button exists';
				exists;
				// GtWardleyMapEdgeElement;
				@ [ :anElement | 
					anElement graph isEdge
						and: [ anElement wardleyMapEdgeViewModel label = anEdgeName ] ];
				// GtWardleyMapRemoveAcceptId;
				play.

			aStep assert
				label: 'Assert Edge A->C proposition reject button exists';
				exists;
				// GtWardleyMapEdgeElement;
				@ [ :anElement | 
					anElement graph isEdge
						and: [ anElement wardleyMapEdgeViewModel label = anEdgeName ] ];
				// GtWardleyMapRemoveRejectId;
				play ].

	self assertScripter: aScripter allPropositionElementCounter: 5.

	^ aScripter
]

{ #category : #'examples - proposed modifications' }
GtWardleyMapDecoratorWithScripterExamples >> mapWithProposedModifications_AllAccept [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self mapWithProposedModifications.

	aScripter click
		label: 'Accept all click';
		// GtWardleyMapAllPropositionElement;
		// GtWardleyMapAllAcceptId;
		play.

	aScripter assert
		label: 'Assert model edge and nodes';
		satisfies: [ :aModel | aModel edges size = 1 and: [ aModel nodes size = 2 ] ];
		onModel;
		play.

	self assertScripter: aScripter allPropositionElementCounter: 0.

	^ aScripter
]

{ #category : #'examples - proposed modifications' }
GtWardleyMapDecoratorWithScripterExamples >> mapWithProposedModifications_AllAccept_AddEdgeABRemoveProposition [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self mapWithProposedModifications_AllAccept.
	self collectWardleyAnnouncements: aScripter.

	aScripter do
		label: 'Add Edge A->B remove proposition';
		block: [ :aMap | 
			| aNodeA aNodeB anEdgeAB aRemoveAB |
			aNodeA := aMap
					nodeWithName: 'Node A'
					ifFound: [ :theNode | theNode ]
					ifNone: [ nil ].
			aNodeB := aMap
					nodeWithName: 'Node B'
					ifFound: [ :theNode | theNode ]
					ifNone: [ nil ].
			anEdgeAB := aMap
					edgeFromNode: aNodeA
					toNode: aNodeB
					ifFound: [ :theEdge | theEdge ]
					ifNone: [ nil ].
			aRemoveAB := GtWardleyMapRemoveProposition new.
			anEdgeAB addWardleyMapDecoratorModel: aRemoveAB ];
		onModel;
		play.

	self assertScripter: aScripter allPropositionElementCounter: 1.

	^ aScripter
]

{ #category : #'examples - proposed modifications' }
GtWardleyMapDecoratorWithScripterExamples >> mapWithProposedModifications_AllAccept_AddNodeARenameProposition [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self mapWithProposedModifications_AllAccept.
	self collectWardleyAnnouncements: aScripter.

	aScripter do
		label: 'Add rename Node A proposition';
		block: [ :aMap | 
			| aNodeA aRenameA |
			aNodeA := aMap
					nodeWithName: 'Node A'
					ifFound: [ :theNode | theNode ]
					ifNone: [ nil ].
			aRenameA := GtWardleyMapRenameProposition new
					options: {'Node X'.
							'Node Y'.
							'Node Z'}.
			aNodeA addWardleyMapDecoratorModel: aRenameA ];
		onModel;
		play.

	self assertScripter: aScripter allPropositionElementCounter: 1.

	^ aScripter
]

{ #category : #'examples - proposed modifications' }
GtWardleyMapDecoratorWithScripterExamples >> mapWithProposedModifications_AllReject [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self mapWithProposedModifications.

	aScripter click
		label: 'Reject all click';
		// GtWardleyMapAllPropositionElement;
		// GtWardleyMapAllRejectId;
		play.

	aScripter assert
		label: 'Assert model edge and nodes';
		satisfies: [ :aModel | aModel edges size = 0 and: [ aModel nodes size = 2 ] ];
		onModel;
		play.

	self assertScripter: aScripter allPropositionElementCounter: 0.

	^ aScripter
]

{ #category : #'examples - proposed modifications' }
GtWardleyMapDecoratorWithScripterExamples >> mapWithProposedModifications_DeleteAllNodes [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self mapWithProposedModifications.

	aScripter do
		label: 'Delete all nodes';
		block: [ :aMap | aMap nodes copy do: [ :aNode | aMap removeNode: aNode ] ];
		onModel;
		play.

	self assertScripter: aScripter allPropositionElementCounter: 0.

	^ aScripter
]

{ #category : #'examples - proposed modifications' }
GtWardleyMapDecoratorWithScripterExamples >> mapWithProposedModifications_DeleteAllNodes_AddNodeAWithAddProposition [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self mapWithProposedModifications_DeleteAllNodes.

	self collectWardleyAnnouncements: aScripter.

	aScripter do
		label: 'Add Node A add proposition';
		block: [ :aMap | 
			| aNodeA anAddA |
			aNodeA := GtWardleyMapNodeModel new label: 'Node A'.
			anAddA := GtWardleyMapAddProposition new.
			aNodeA addWardleyMapDecoratorModel: anAddA.
			aMap addNode: aNodeA ];
		onModel;
		play.

	self assertScripter: aScripter allPropositionElementCounter: 1.

	^ aScripter
]

{ #category : #'examples - proposed modifications' }
GtWardleyMapDecoratorWithScripterExamples >> mapWithProposedModifications_DeleteEdgeAB [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self mapWithProposedModifications.

	aScripter do
		label: 'Delete Edge A->B';
		block: [ :aMap | 
			aMap
				edgeWithName: 'Edge A->B'
				ifFound: [ :anEdge | aMap removeEdge: anEdge ]
				ifNone: [ AssertionFailure signal: 'Edge A->B not found' ] ];
		onModel;
		play.

	self assertScripter: aScripter allPropositionElementCounter: 4.

	^ aScripter
]

{ #category : #'examples - proposed modifications' }
GtWardleyMapDecoratorWithScripterExamples >> mapWithProposedModifications_DeleteNodeA [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self mapWithProposedModifications.

	aScripter do
		label: 'Delete Node A';
		block: [ :aMap | 
			aMap
				nodeWithName: 'Node A'
				ifFound: [ :aNode | aMap removeNode: aNode ]
				ifNone: [ AssertionFailure signal: 'Node A not found' ] ];
		onModel;
		play.

	self assertScripter: aScripter allPropositionElementCounter: 2.

	^ aScripter
]

{ #category : #'examples - proposed modifications' }
GtWardleyMapDecoratorWithScripterExamples >> mapWithProposedModifications_EdgeABAccept [
	<gtExample>
	<return: #BlScripter>
	| aScripter anEdgeName |
	aScripter := self mapWithProposedModifications.
	anEdgeName := 'Edge A->B'.
	self collectWardleyAnnouncements: aScripter.

	aScripter click
		label: 'Accept Edge A->B click';
		// GtWardleyMapEdgeElement;
		@ [ :anElement | 
			anElement graph isEdge
				and: [ anElement wardleyMapEdgeViewModel label = anEdgeName ] ];
		// GtWardleyMapAddAcceptId;
		play.
	aScripter assert
		label: 'Assert edge exists';
		satisfies: [ :aModel | 
			aModel
				edgeWithName: anEdgeName
				ifFound: [ :anEdge | true ]
				ifNone: [ false ] ];
		onModel;
		play.
	self
		assertScripter: aScripter
		nonExistentPropositionElementIds: {GtWardleyMapAddAcceptId.
				GtWardleyMapAddRejectId}
		ofEdgeNamed: anEdgeName.
	self assertScripter: aScripter allPropositionElementCounter: 4.
	^ aScripter
]

{ #category : #'examples - proposed modifications' }
GtWardleyMapDecoratorWithScripterExamples >> mapWithProposedModifications_EdgeABReject [
	<gtExample>
	<return: #BlScripter>
	| aScripter anEdgeName |
	aScripter := self mapWithProposedModifications.

	anEdgeName := 'Edge A->B'.

	aScripter click
		label: 'Reject Edge A->B click';
		// GtWardleyMapEdgeElement;
		@ [ :anElement | 
			anElement graph isEdge
				and: [ anElement wardleyMapEdgeViewModel label = anEdgeName ] ];
		// GtWardleyMapAddRejectId;
		play.

	aScripter assert
		label: 'Assert edge does not exist';
		satisfies: [ :aModel | 
			aModel
				edgeWithName: anEdgeName
				ifFound: [ :anEdge | false ]
				ifNone: [ true ] ];
		onModel;
		play.

	self
		assertScripter: aScripter
		nonExistentPropositionElementIds: {GtWardleyMapAddAcceptId.
				GtWardleyMapAddRejectId}
		ofEdgeNamed: anEdgeName.

	self assertScripter: aScripter allPropositionElementCounter: 4.

	^ aScripter
]

{ #category : #'examples - proposed modifications' }
GtWardleyMapDecoratorWithScripterExamples >> mapWithProposedModifications_EdgeACAccept [
	<gtExample>
	<return: #BlScripter>
	| aScripter anEdgeName |
	aScripter := self mapWithProposedModifications.

	anEdgeName := 'Edge A->C'.

	aScripter click
		label: 'Accept Edge A->C click';
		// GtWardleyMapEdgeElement;
		@ [ :anElement | 
			anElement graph isEdge
				and: [ anElement wardleyMapEdgeViewModel label = anEdgeName ] ];
		// GtWardleyMapRemoveAcceptId;
		play.

	aScripter assert
		label: 'Assert edge does not exist';
		satisfies: [ :aModel | 
			aModel
				edgeWithName: anEdgeName
				ifFound: [ :anEdge | false ]
				ifNone: [ true ] ];
		onModel;
		play.

	self
		assertScripter: aScripter
		nonExistentPropositionElementIds: {GtWardleyMapRemoveAcceptId.
				GtWardleyMapRemoveRejectId}
		ofEdgeNamed: anEdgeName.

	self assertScripter: aScripter allPropositionElementCounter: 4.

	^ aScripter
]

{ #category : #'examples - proposed modifications' }
GtWardleyMapDecoratorWithScripterExamples >> mapWithProposedModifications_EdgeACReject [
	<gtExample>
	<return: #BlScripter>
	| aScripter anEdgeName |
	aScripter := self mapWithProposedModifications.

	anEdgeName := 'Edge A->C'.

	aScripter click
		label: 'Reject Edge A->C click';
		// GtWardleyMapEdgeElement;
		@ [ :anElement | 
			anElement graph isEdge
				and: [ anElement wardleyMapEdgeViewModel label = anEdgeName ] ];
		// GtWardleyMapRemoveRejectId;
		play.

	aScripter assert
		label: 'Assert edge exists';
		satisfies: [ :aModel | 
			aModel
				edgeWithName: anEdgeName
				ifFound: [ :anEdge | true ]
				ifNone: [ true ] ];
		onModel;
		play.

	self
		assertScripter: aScripter
		nonExistentPropositionElementIds: {GtWardleyMapRemoveAcceptId.
				GtWardleyMapRemoveRejectId}
		ofEdgeNamed: anEdgeName.

	self assertScripter: aScripter allPropositionElementCounter: 4.

	^ aScripter
]

{ #category : #'examples - proposed modifications' }
GtWardleyMapDecoratorWithScripterExamples >> mapWithProposedModifications_NodeAAccept [
	<gtExample>
	<return: #BlScripter>
	| aScripter aNodeName |
	aScripter := self mapWithProposedModifications.

	aNodeName := 'Node A'.
	aScripter click
		label: 'Accept Node A click';
		// GtWardleyMapNodeElement;
		@ [ :anElement | 
			anElement graph isNode
				and: [ anElement wardleyMapNodeViewModel label = aNodeName ] ];
		// GtWardleyCenterRightOuterDecoratorId;
		/ GtWardleyMapAddAcceptId;
		play.

	aScripter assert
		label: 'Assert node exists';
		satisfies: [ :aModel | 
			aModel
				nodeWithName: aNodeName
				ifFound: [ :aNode | true ]
				ifNone: [ false ] ];
		onModel;
		play.

	self
		assertScripter: aScripter
		nonExistentPropositionElementIds: {GtWardleyMapAddAcceptId.
				GtWardleyMapAddRejectId}
		ofNodeNamed: aNodeName.

	self assertScripter: aScripter allPropositionElementCounter: 4.

	^ aScripter
]

{ #category : #'examples - proposed modifications' }
GtWardleyMapDecoratorWithScripterExamples >> mapWithProposedModifications_NodeAReject [
	<gtExample>
	<return: #BlScripter>
	| aScripter aNodeName |
	aScripter := self mapWithProposedModifications.

	aNodeName := 'Node A'.
	aScripter click
		label: 'Reject Node A click';
		// GtWardleyMapNodeElement;
		@ [ :anElement | 
			anElement graph isNode
				and: [ anElement wardleyMapNodeViewModel label = aNodeName ] ];
		// GtWardleyCenterRightOuterDecoratorId;
		/ GtWardleyMapAddRejectId;
		play.

	aScripter assert
		label: 'Assert node does not exist';
		satisfies: [ :aModel | 
			aModel
				nodeWithName: aNodeName
				ifFound: [ :aNode | false ]
				ifNone: [ true ] ];
		onModel;
		play.

	self
		assertScripter: aScripter
		nonExistentPropositionElementIds: {GtWardleyMapAddAcceptId.
				GtWardleyMapAddRejectId}
		ofNodeNamed: aNodeName.

	self assertScripter: aScripter allPropositionElementCounter: 2.

	^ aScripter
]

{ #category : #'examples - proposed modifications' }
GtWardleyMapDecoratorWithScripterExamples >> mapWithProposedModifications_NodeBSelectProposedName [
	<gtExample>
	<return: #BlScripter>
	| aScripter aNodeName |
	aScripter := self mapWithProposedModifications.

	aNodeName := 'Node B'.
	aScripter click
		label: 'Display Node B proposed names';
		// GtWardleyMapNodeElement;
		@ [ :anElement | 
			anElement graph isNode
				and: [ anElement wardleyMapNodeViewModel label = aNodeName ] ];
		// GtWardleyCenterRightOuterDecoratorId;
		/ GtWardleyMapRenameProposalsId;
		play.

	aScripter click
		label: 'Select Node X proposed name';
		onSpaceRoot;
		onDropdown: true;
		// (GtWardleyMapRenameProposalId indexed: 1);
		play.

	aScripter assert
		label: 'Node B is renamed to Node X';
		satisfies: [ :aMap | 
				(aMap
					nodeWithName: 'Node X'
					ifFound: [ :aNode | true ]
					ifNone: [ false ])
					and: (aMap
							nodeWithName: 'Node B'
							ifFound: [ :aNode | false ]
							ifNone: [ true ]) ]
			description: [ 'Node B must be renamed to Node X' ];
		onModel;
		play.

	self assertScripter: aScripter allPropositionElementCounter: 5.

	^ aScripter
]

{ #category : #'examples - proposed modifications' }
GtWardleyMapDecoratorWithScripterExamples >> mapWithProposedModifications_NodeBSelectProposedName_Accept [
	<gtExample>
	<return: #BlScripter>
	| aScripter aNodeName |
	aScripter := self mapWithProposedModifications_NodeBSelectProposedName.

	aNodeName := 'Node X'.
	aScripter click
		label: 'Accept Node X name';
		// GtWardleyMapNodeElement;
		@ [ :anElement | 
			anElement graph isNode
				and: [ anElement wardleyMapNodeViewModel label = aNodeName ] ];
		// GtWardleyCenterRightOuterDecoratorId;
		/ GtWardleyMapRenameAcceptId;
		play.

	aScripter assert
		label: 'Node B is renamed to Node X';
		satisfies: [ :aMap | 
				(aMap
					nodeWithName: 'Node X'
					ifFound: [ :aNode | true ]
					ifNone: [ false ])
					and: (aMap
							nodeWithName: 'Node B'
							ifFound: [ :aNode | false ]
							ifNone: [ true ]) ]
			description: [ 'Node B must be renamed to Node X' ];
		onModel;
		play.

	self
		assertScripter: aScripter
		nonExistentPropositionElementIds: {GtWardleyMapRenameProposalsId.
				GtWardleyMapRenameAcceptId.
				GtWardleyMapRenameRejectId}
		ofNodeNamed: aNodeName.

	self assertScripter: aScripter allPropositionElementCounter: 4.

	^ aScripter
]

{ #category : #'examples - proposed modifications' }
GtWardleyMapDecoratorWithScripterExamples >> mapWithProposedModifications_NodeBSelectProposedName_Reject [
	<gtExample>
	<return: #BlScripter>
	| aScripter aNodeName |
	aScripter := self mapWithProposedModifications_NodeBSelectProposedName.

	aNodeName := 'Node X'.
	aScripter click
		label: 'Reject Node X name';
		// GtWardleyMapNodeElement;
		@ [ :anElement | 
			anElement graph isNode
				and: [ anElement wardleyMapNodeViewModel label = aNodeName ] ];
		// GtWardleyCenterRightOuterDecoratorId;
		/ GtWardleyMapRenameRejectId;
		play.

	aNodeName := 'Node B'.
	aScripter assert
		label: 'Node B is not renamed to Node X';
		satisfies: [ :aMap | 
				(aMap
					nodeWithName: 'Node B'
					ifFound: [ :aNode | true ]
					ifNone: [ false ])
					and: (aMap
							nodeWithName: 'Node X'
							ifFound: [ :aNode | false ]
							ifNone: [ true ]) ]
			description: [ 'Node B must not be renamed to Node X' ];
		onModel;
		play.

	self
		assertScripter: aScripter
		nonExistentPropositionElementIds: {GtWardleyMapRenameProposalsId.
				GtWardleyMapRenameAcceptId.
				GtWardleyMapRenameRejectId}
		ofNodeNamed: aNodeName.

	self assertScripter: aScripter allPropositionElementCounter: 4.

	^ aScripter
]

{ #category : #'examples - proposed modifications' }
GtWardleyMapDecoratorWithScripterExamples >> mapWithProposedModifications_NodeCAcceptRemoval [
	<gtExample>
	<return: #BlScripter>
	| aScripter aNodeName |
	aScripter := self mapWithProposedModifications.

	aNodeName := 'Node C'.
	aScripter click
		label: 'Accept Node C click';
		// GtWardleyMapNodeElement;
		@ [ :anElement | 
			anElement graph isNode
				and: [ anElement wardleyMapNodeViewModel label = aNodeName ] ];
		// GtWardleyCenterRightOuterDecoratorId;
		/ GtWardleyMapRemoveAcceptId;
		play.

	aScripter assert
		label: 'Assert node does not exist';
		satisfies: [ :aModel | 
			aModel
				nodeWithName: aNodeName
				ifFound: [ :aNode | false ]
				ifNone: [ true ] ];
		onModel;
		play.

	self
		assertScripter: aScripter
		nonExistentPropositionElementIds: {GtWardleyMapRemoveAcceptId.
				GtWardleyMapRemoveRejectId}
		ofNodeNamed: aNodeName.

	self assertScripter: aScripter allPropositionElementCounter: 3.

	^ aScripter
]

{ #category : #'examples - proposed modifications' }
GtWardleyMapDecoratorWithScripterExamples >> mapWithProposedModifications_NodeCRejectRemoval [
	<gtExample>
	<return: #BlScripter>
	| aScripter aNodeName |
	aScripter := self mapWithProposedModifications.

	aNodeName := 'Node C'.
	aScripter click
		label: 'Accept Node C click';
		// GtWardleyMapNodeElement;
		@ [ :anElement | 
			anElement graph isNode
				and: [ anElement wardleyMapNodeViewModel label = aNodeName ] ];
		// GtWardleyCenterRightOuterDecoratorId;
		/ GtWardleyMapRemoveRejectId;
		play.

	aScripter assert
		label: 'Assert node exists';
		satisfies: [ :aModel | 
			aModel
				nodeWithName: aNodeName
				ifFound: [ :aNode | true ]
				ifNone: [ false ] ];
		onModel;
		play.

	self
		assertScripter: aScripter
		nonExistentPropositionElementIds: {GtWardleyMapRemoveAcceptId.
				GtWardleyMapRemoveRejectId}
		ofNodeNamed: aNodeName.

	self assertScripter: aScripter allPropositionElementCounter: 4.

	^ aScripter
]
