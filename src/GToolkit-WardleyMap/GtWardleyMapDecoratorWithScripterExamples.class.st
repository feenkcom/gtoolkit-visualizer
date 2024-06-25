Class {
	#name : #GtWardleyMapDecoratorWithScripterExamples,
	#superclass : #Object,
	#traits : 'TBlDevScripterExamples',
	#classTraits : 'TBlDevScripterExamples classTrait',
	#category : #'GToolkit-WardleyMap-Examples'
}

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
GtWardleyMapDecoratorWithScripterExamples >> mapWithProposedModifications [
	<gtExample>
	| aScripter |
	aScripter := self
			scripterWithModel: [ GtWardleyMapDecoratorExamples new mapWithProposedModifications ]
			element: [ :aMap | 
				GtWardleyMapElement new
					wardleyMapViewModel: (GtWardleyMapViewModel new wardleyMapModel: aMap) ].

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

	^ aScripter
]

{ #category : #'examples - proposed modifications' }
GtWardleyMapDecoratorWithScripterExamples >> mapWithProposedModifications_EdgeABAccept [
	<gtExample>
	| aScripter anEdgeName |
	aScripter := self mapWithProposedModifications.

	anEdgeName := 'Edge A->B'.
	
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
		nonExistentPropositionElementIds: { GtWardleyMapAddAcceptId. GtWardleyMapAddRejectId}
		ofEdgeNamed: anEdgeName.

	^ aScripter
]

{ #category : #'examples - proposed modifications' }
GtWardleyMapDecoratorWithScripterExamples >> mapWithProposedModifications_EdgeABReject [
	<gtExample>
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
		nonExistentPropositionElementIds: { GtWardleyMapAddAcceptId. GtWardleyMapAddRejectId}
		ofEdgeNamed: anEdgeName.

	^ aScripter
]

{ #category : #'examples - proposed modifications' }
GtWardleyMapDecoratorWithScripterExamples >> mapWithProposedModifications_EdgeACAccept [
	<gtExample>
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
		nonExistentPropositionElementIds: { GtWardleyMapRemoveAcceptId. GtWardleyMapRemoveRejectId}
		ofEdgeNamed: anEdgeName.

	^ aScripter
]

{ #category : #'examples - proposed modifications' }
GtWardleyMapDecoratorWithScripterExamples >> mapWithProposedModifications_EdgeACReject [
	<gtExample>
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
		nonExistentPropositionElementIds: { GtWardleyMapRemoveAcceptId. GtWardleyMapRemoveRejectId}
		ofEdgeNamed: anEdgeName.

	^ aScripter
]

{ #category : #'examples - proposed modifications' }
GtWardleyMapDecoratorWithScripterExamples >> mapWithProposedModifications_NodeAAccept [
	<gtExample>
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
		nonExistentPropositionElementIds: { GtWardleyMapAddAcceptId. GtWardleyMapAddRejectId}
		ofNodeNamed: aNodeName.

	^ aScripter
]

{ #category : #'examples - proposed modifications' }
GtWardleyMapDecoratorWithScripterExamples >> mapWithProposedModifications_NodeAReject [
	<gtExample>
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
		nonExistentPropositionElementIds: { GtWardleyMapAddAcceptId. GtWardleyMapAddRejectId}
		ofNodeNamed: aNodeName.

	^ aScripter
]

{ #category : #'examples - proposed modifications' }
GtWardleyMapDecoratorWithScripterExamples >> mapWithProposedModifications_NodeBSelectProposedName [
	<gtExample>
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
		/ BrAnchoredOuterContainer;
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

	^ aScripter
]

{ #category : #'examples - proposed modifications' }
GtWardleyMapDecoratorWithScripterExamples >> mapWithProposedModifications_NodeBSelectProposedName_Accept [
	<gtExample>
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
		nonExistentPropositionElementIds: { GtWardleyMapRenameProposalsId. GtWardleyMapRenameAcceptId. GtWardleyMapRenameRejectId }
		ofNodeNamed: aNodeName.

	^ aScripter
]

{ #category : #'examples - proposed modifications' }
GtWardleyMapDecoratorWithScripterExamples >> mapWithProposedModifications_NodeBSelectProposedName_Reject [
	<gtExample>
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
		nonExistentPropositionElementIds: { GtWardleyMapRenameProposalsId. GtWardleyMapRenameAcceptId. GtWardleyMapRenameRejectId }
		ofNodeNamed: aNodeName.

	^ aScripter
]

{ #category : #'examples - proposed modifications' }
GtWardleyMapDecoratorWithScripterExamples >> mapWithProposedModifications_NodeCAcceptRemoval [
	<gtExample>
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
		nonExistentPropositionElementIds: { GtWardleyMapRemoveAcceptId. GtWardleyMapRemoveRejectId}
		ofNodeNamed: aNodeName.

	^ aScripter
]

{ #category : #'examples - proposed modifications' }
GtWardleyMapDecoratorWithScripterExamples >> mapWithProposedModifications_NodeCRejectRemoval [
	<gtExample>
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
		nonExistentPropositionElementIds: { GtWardleyMapRemoveAcceptId. GtWardleyMapRemoveRejectId}
		ofNodeNamed: aNodeName.

	^ aScripter
]
