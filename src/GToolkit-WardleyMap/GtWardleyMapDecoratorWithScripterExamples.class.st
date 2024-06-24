Class {
	#name : #GtWardleyMapDecoratorWithScripterExamples,
	#superclass : #Object,
	#traits : 'TBlDevScripterExamples',
	#classTraits : 'TBlDevScripterExamples classTrait',
	#category : #'GToolkit-WardleyMap-Examples'
}

{ #category : #'examples - proposed modifications' }
GtWardleyMapDecoratorWithScripterExamples >> assertScripter: aStep nonExistentPropositionElementsOfNodeNamed: aNodeName [
	aStep
		substeps: ('Assert "{1}" proposition elements' format: { aNodeName })
		do: [ :aSubStep | 
			aSubStep assert
				label: ('Assert "{1}" proposition element does not exist' format: { aNodeName });
				notExists;
				// GtWardleyMapNodePropositionElement;
				@ [ :anElement | anElement wardleyMapNodeViewModel label = aNodeName ];
				play.

			aSubStep assert
				label: ('Assert "{1}" proposition accept button does not exist' format: { aNodeName });
				notExists;
				// GtWardleyMapNodeElement;
				@ [ :anElement | 
					anElement graph isNode
						and: [ anElement wardleyMapNodeViewModel label = aNodeName ] ];
				// GtWardleyCenterRightOuterDecoratorId;
				/ GtWardleyMapActionNodeButton;
				@ [ :aButton | aButton label asString = 'Keep' ];
				play.

			aSubStep assert
				label: ('Assert "{1}" proposition reject button does not exist' format: { aNodeName });
				notExists;
				// GtWardleyMapNodeElement;
				@ [ :anElement | 
					anElement graph isNode
						and: [ anElement wardleyMapNodeViewModel label = aNodeName ] ];
				// GtWardleyCenterRightOuterDecoratorId;
				/ GtWardleyMapActionNodeButton;
				@ [ :aButton | aButton label asString = 'Remove' ];
				play ]
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
				/ GtWardleyMapActionNodeButton;
				@ [ :aButton | aButton label asString = 'Keep' ];
				play.

			aStep assert
				label: 'Assert Node A proposition reject button exists';
				exists;
				// GtWardleyMapNodeElement;
				@ [ :anElement | 
					anElement graph isNode
						and: [ anElement wardleyMapNodeViewModel label = aNodeName ] ];
				// GtWardleyCenterRightOuterDecoratorId;
				/ GtWardleyMapActionNodeButton;
				@ [ :aButton | aButton label asString = 'Remove' ];
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
				/ GtWardleyMapActionNodeButton;
				@ [ :aButton | aButton label asString = 'Proposed names' ];
				play.

			aStep assert
				label: 'Assert Node B proposition accept button exists';
				exists;
				// GtWardleyMapNodeElement;
				@ [ :anElement | 
					anElement graph isNode
						and: [ anElement wardleyMapNodeViewModel label = aNodeName ] ];
				// GtWardleyCenterRightOuterDecoratorId;
				/ GtWardleyMapActionNodeButton;
				@ [ :aButton | aButton label asString = 'Accept rename' ];
				play.

			aStep assert
				label: 'Assert Node B proposition reject button exists';
				exists;
				// GtWardleyMapNodeElement;
				@ [ :anElement | 
					anElement graph isNode
						and: [ anElement wardleyMapNodeViewModel label = aNodeName ] ];
				// GtWardleyCenterRightOuterDecoratorId;
				/ GtWardleyMapActionNodeButton;
				@ [ :aButton | aButton label asString = 'Keep original name' ];
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
				/ GtWardleyMapActionNodeButton;
				@ [ :aButton | aButton label asString = 'Keep' ];
				play.

			aStep assert
				label: 'Assert Node C proposition reject button exists';
				exists;
				// GtWardleyMapNodeElement;
				@ [ :anElement | 
					anElement graph isNode
						and: [ anElement wardleyMapNodeViewModel label = aNodeName ] ];
				// GtWardleyCenterRightOuterDecoratorId;
				/ GtWardleyMapActionNodeButton;
				@ [ :aButton | aButton label asString = 'Remove' ];
				play ].

	^ aScripter
]

{ #category : #'examples - proposed modifications' }
GtWardleyMapDecoratorWithScripterExamples >> mapWithProposedModifications_AcceptNodeA [
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
		/ GtWardleyMapActionNodeButton;
		@ [ :aButton | aButton label asString = 'Keep' ];
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
		nonExistentPropositionElementsOfNodeNamed: aNodeName.
	
	^ aScripter
]

{ #category : #'examples - proposed modifications' }
GtWardleyMapDecoratorWithScripterExamples >> mapWithProposedModifications_AcceptNodeCDeletion [
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
		/ GtWardleyMapActionNodeButton;
		@ [ :aButton | aButton label asString = 'Remove' ];
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
		nonExistentPropositionElementsOfNodeNamed: aNodeName.
				
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
		nonExistentPropositionElementsOfNodeNamed: aNodeName.

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
		nonExistentPropositionElementsOfNodeNamed: aNodeName.

	^ aScripter
]

{ #category : #'examples - proposed modifications' }
GtWardleyMapDecoratorWithScripterExamples >> mapWithProposedModifications_RejectNodeA [
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
		/ GtWardleyMapActionNodeButton;
		@ [ :aButton | aButton label asString = 'Remove' ];
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
		nonExistentPropositionElementsOfNodeNamed: aNodeName.
				
	^ aScripter
]

{ #category : #'examples - proposed modifications' }
GtWardleyMapDecoratorWithScripterExamples >> mapWithProposedModifications_RejectNodeCDeletion [
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
		/ GtWardleyMapActionNodeButton;
		@ [ :aButton | aButton label asString = 'Keep' ];
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
		nonExistentPropositionElementsOfNodeNamed: aNodeName.
		
	^ aScripter
]
