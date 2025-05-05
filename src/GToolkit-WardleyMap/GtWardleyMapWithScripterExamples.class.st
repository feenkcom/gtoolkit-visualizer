Class {
	#name : #GtWardleyMapWithScripterExamples,
	#superclass : #Object,
	#traits : 'TBlDevScripterExamples',
	#classTraits : 'TBlDevScripterExamples classTrait',
	#category : #'GToolkit-WardleyMap-Examples'
}

{ #category : #'examples - ui' }
GtWardleyMapWithScripterExamples >> pipelineWithInnerNodes [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self
			scripterWithModel: [ GtWardleyMapModelExamples new newMapWithPipelineInnerNodes ]
			element: [ :aModel | 
				GtWardleyMapCanvasElement new
					wardleyMapViewModel: (GtWardleyMapViewModel new wardleyMapModel: aModel) ].	"Ensure an extent to compute exact node positions, dragging, etc."
	aScripter
		doStep: [ :s | 
			s
				label: 'Ensure 800 @ 600 space extent';
				block: [ :aSpace | aSpace extent: 800 @ 600 ];
				onSpace ].

	^ aScripter
]

{ #category : #'examples - ui' }
GtWardleyMapWithScripterExamples >> pipelineWithInnerNodes_addAndHoverInnerEdge [
	<gtExample>
	<return: #BlScripter>
	| aScripter anEdgeName |
	aScripter := self pipelineWithInnerNodes.

	anEdgeName := 'Edge D->E'.

	aScripter do
		label: 'Add Edge D->E';
		block: [ :aMap | 
			| aNodeD aNodeE anEdgeDE |
			aNodeD := aMap
					nodeWithName: 'Node D'
					ifFound: [ :each | each ]
					ifNone: [ nil ].
			aNodeE := aMap
					nodeWithName: 'Node E'
					ifFound: [ :each | each ]
					ifNone: [ nil ].
			anEdgeDE := GtWardleyMapEdgeModel new
					label: 'Edge D->E';
					fromNode: aNodeD;
					toNode: aNodeE;
					width: 2.
			aMap addEdge: anEdgeDE ];
		onModel;
		play.

	aScripter
		substeps: 'Edge D->E hovering'
		do: [ :aStep | 
			aStep mouseMoveOver
				label: 'Hover Edge D->E';
				// (#edge asBlocElementId indexed: 10);
				play.

			aStep assert
				label: 'Assert Edge D->E is hovered';
				value: [ :aNodeElement | aNodeElement border ]
					equals: [ BlBorder paint: GtWardleyMapConstants hoverColor width: 2 ];
				// (#edge asBlocElementId indexed: 10);
				play ].


	^ aScripter
]

{ #category : #'examples - ui' }
GtWardleyMapWithScripterExamples >> pipelineWithInnerNodes_addEdgeFC [
	<gtExample>
	<return: #BlScripter>
	| aScripter anEdgeCount |
	aScripter := self pipelineWithInnerNodes.

	aScripter
		substeps: 'Add Edge D->E primary dragging between nodes'
		do: [ :aStep | 
			aStep do
				label: 'Get edge count';
				block: [ :aMap | anEdgeCount := aMap edges size ];
				onModel;
				play.

			aStep mouseMoveOver
				label: 'Mouse over Node D';
				// (#node asBlocElementId indexed: 5);
				play.
			aStep mouseDown
				modifiers: BlKeyModifiers primary;
				play.
			aStep mouseMoveOver
				label: 'Move mouse to Node E';
				modifiers: BlKeyModifiers primary;
				// (#node asBlocElementId indexed: 2);
				play.
			aStep mouseUp
				modifiers: BlKeyModifiers primary;
				play.

			aStep assert
				label: 'Assert edge count + 1';
				value: [ :aMap | aMap edges size ] equals: [ anEdgeCount + 1 ];
				onModel;
				play.

			aStep assert
				label: 'Assert Node F is not highlighted';
				value: [ :aNodeElement | (aNodeElement childNamed: #node) background ]
					equals: [ :aNodeElement | aNodeElement wardleyMapNodeViewModel nodeColor asBlBackground ];
				// (#node asBlocElementId indexed: 5);
				play ].


	^ aScripter
]

{ #category : #'examples - ui' }
GtWardleyMapWithScripterExamples >> pipelineWithInnerNodes_addEvolve [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self pipelineWithInnerNodes.

	aScripter
		substeps: 'Add Node A evolve'
		do: [ :aStep | 
			| aNodeElementsCount aPipelineElementCount anEvolveElementCount anEdgeCount |
			aStep do
				label: 'Count canvas elements';
				block: [ :aCanvas | 
					aNodeElementsCount := (aCanvas query / GtWardleyMapNodeElement) all size.
					aPipelineElementCount := (aCanvas query / GtWardleyMapPipelineElement) all
							size.
					anEvolveElementCount := (aCanvas query / GtWardleyMapEvolveElement) all
							size.
					anEdgeCount := (aCanvas query / GtWardleyMapEdgeElement) all size ];
				play.

			aStep secondaryClick
				label: 'Open context menu';
				id: (#node asBlocElementId indexed: 0);
				play.

			aStep click
				label: 'Click on add evolve';
				onSpaceRoot;
				onDropdown: true;
				// (GtWardleyMapContextMenuItemId
						definingMethod: GtWardleyMapNodeModel >> #menuItemNodeAddEvolveButton);
				play.

			aStep assert
				label: 'Assert node elements count';
				value: [ :aCanvas | (aCanvas query / GtWardleyMapNodeElement) all size ]
					equals: aNodeElementsCount;
				play.

			aStep assert
				label: 'Assert pipeline elements count';
				value: [ :aCanvas | (aCanvas query / GtWardleyMapPipelineElement) all size ]
					equals: aPipelineElementCount;
				play.

			aStep assert
				label: 'Assert evolve elements count';
				value: [ :aCanvas | (aCanvas query / GtWardleyMapEvolveElement) all size ]
					equals: anEvolveElementCount + 1;
				play.

			aStep assert
				label: 'Assert edge elements count';
				value: [ :aCanvas | (aCanvas query / GtWardleyMapEdgeElement) all size ]
					equals: anEdgeCount + 1;
				play ].


	^ aScripter
]

{ #category : #'examples - ui' }
GtWardleyMapWithScripterExamples >> pipelineWithInnerNodes_addNewNode [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self pipelineWithInnerNodes.

	aScripter
		substeps: 'Add new node'
		do: [ :aStep | 
			aStep doubleClick
				label: 'Double click to add new node';
				play.

			aStep assert
				label: 'Assert new node is added';
				exists;
				// (#node asBlocElementId indexed: 10);
				play.

			aStep assert
				label: 'Assert node label edit mode';
				satisfies: [ :anEditorLabel | anEditorLabel isEditable ]
					description: [ 'Node label must be in edit mode' ];
				// (#node asBlocElementId indexed: 10);
				// GtWardleyMapNodeLabelId;
				play.

			aStep assert
				label: 'Assert node label text selection';
				value: [ :anEditorLabel | anEditorLabel selection indices ]
					equals: [ :anEditorLabel | 1 to: 5 ];
				// (#node asBlocElementId indexed: 10);
				// GtWardleyMapNodeLabelId;
				play.

			aStep assert
				label: 'Assert node label cursor is visible';
				satisfies: [ :aCursorElement | aCursorElement visibility isVisible ]
					description: [ 'Node label cursor must be visible' ];
				// (#node asBlocElementId indexed: 10);
				// GtWardleyMapNodeLabelId;
				// BrCursorElement;
				play.

			aStep assert
				label: 'Assert node label focus';
				satisfies: [ :anEditorLabel | anEditorLabel isFocused ]
					description: [ 'Node label must be focused' ];
				// (#node asBlocElementId indexed: 10);
				// GtWardleyMapNodeLabelId;
				play ].

	^ aScripter
]

{ #category : #'examples - ui' }
GtWardleyMapWithScripterExamples >> pipelineWithInnerNodes_addNewNode_clickOnCanvas [
	"When we click outside of a node label, we want to lose the label focus
	and its hide cursor."

	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self pipelineWithInnerNodes_addNewNode.

	aScripter
		substeps: 'Type node label and click outside'
		do: [ :aStep | 
			aStep type
				label: 'Type new node label';
				text: 'Node Z';
				play.

			aStep click play.

			aStep assert
				label: 'Assert node label focus';
				satisfies: [ :anEditorLabel | anEditorLabel isFocused not ]
					description: [ 'Node label must not be focused' ];
				// (#node asBlocElementId indexed: 10);
				// GtWardleyMapNodeLabelId;
				play.

			aStep assert
				label: 'Assert node label read-only mode';
				satisfies: [ :anEditorLabel | anEditorLabel isReadOnly ]
					description: [ 'Node label must be in read-only mode' ];
				// (#node asBlocElementId indexed: 10);
				// GtWardleyMapNodeLabelId;
				play.

			aStep assert
				label: 'Assert node label cursor is not visible';
				satisfies: [ :aCursorElement | aCursorElement visibility isVisible not ]
					description: [ 'Node label cursor must not be visible' ];
				// (#node asBlocElementId indexed: 10);
				// GtWardleyMapNodeLabelId;
				// BrCursorElement;
				play.

			aStep assert
				label: 'Assert node model label is set';
				value: [ :aNodeElement | aNodeElement wardleyMapNodeViewModel label ]
					equals: 'Node Z';
				// (#node asBlocElementId indexed: 10);
				play ].

	^ aScripter
]

{ #category : #'examples - ui' }
GtWardleyMapWithScripterExamples >> pipelineWithInnerNodes_addNewNode_typeLabel [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self pipelineWithInnerNodes_addNewNode.

	aScripter
		substeps: 'Type new node label'
		do: [ :aStep | 
			aStep type
				label: 'Type new node label';
				text: 'Node Z';
				play.

			aStep keyPress
				key: BlKeyboardKey return;
				play.

			aStep assert
				label: 'Assert node label read-only mode';
				satisfies: [ :anEditorLabel | anEditorLabel isReadOnly ]
					description: [ 'Node label must be in read-only mode' ];
				// (#node asBlocElementId indexed: 10);
				// GtWardleyMapNodeLabelId;
				play.

			aStep assert
				label: 'Assert node label cursor is not visible';
				satisfies: [ :aCursorElement | aCursorElement visibility isVisible not ]
					description: [ 'Node label cursor must not be visible' ];
				// (#node asBlocElementId indexed: 10);
				// GtWardleyMapNodeLabelId;
				// BrCursorElement;
				play.

			aStep assert
				label: 'Assert node model label is set';
				value: [ :aNodeElement | aNodeElement wardleyMapNodeViewModel label ]
					equals: 'Node Z';
				// (#node asBlocElementId indexed: 10);
				play ].

	^ aScripter
]

{ #category : #'examples - ui' }
GtWardleyMapWithScripterExamples >> pipelineWithInnerNodes_assertInitialWidgetPositions [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self pipelineWithInnerNodes.

	aScripter
		checks: 'Assert widget positions'
		do: [ :aStep | 
			aStep
				assertStep: [ :s | 
					s
						label: 'Node A position';
						value: [ :aNodeElement | aNodeElement bounds inSpace asRectangle ]
							equals: [ 194.0 @ 444.0 corner: 206.0 @ 456.0 ];
						id: (#node asBlocElementId indexed: 0) ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Node B position';
						value: [ :aNodeElement | aNodeElement bounds inSpace asRectangle ]
							equals: [ 394.0 @ 144.0 corner: 406.0 @ 156.0 ];
						id: (#node asBlocElementId indexed: 1) ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Node C position';
						value: [ :aNodeElement | aNodeElement bounds inSpace asRectangle ]
							equals: [ 594.0 @ 294.0 corner: 606.0 @ 306.0 ];
						id: (#node asBlocElementId indexed: 2) ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Node D position';
						value: [ :aNodeElement | aNodeElement bounds inSpace asRectangle ]
							equals: [ 154.0 @ 460.0 corner: 166.0 @ 472.0 ];
						id: (#node asBlocElementId indexed: 3) ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Node F position';
						value: [ :aNodeElement | aNodeElement bounds inSpace asRectangle ]
							equals: [ 322.0 @ 450.0 corner: 334.0 @ 462.0 ];
						id: (#node asBlocElementId indexed: 5) ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Node G position';
						value: [ :aNodeElement | aNodeElement bounds inSpace asRectangle ]
							equals: [ 298.0 @ 462.0 corner: 310.0 @ 474.0 ];
						id: (#node asBlocElementId indexed: 6) ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Pipeline A position';
						value: [ :aNodeElement | aNodeElement bounds inSpace asRectangle ]
							equals: [ 152.0 @ 456.0 corner: 248.0 @ 476.0 ];
						id: (#pipeline asBlocElementId indexed: 7) ] ].


	^ aScripter
]

{ #category : #'examples - ui' }
GtWardleyMapWithScripterExamples >> pipelineWithInnerNodes_deleteNodeWithPipelineAndEvolve [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self pipelineWithInnerNodes_addEvolve.

	aScripter
		substeps: 'Delete Node A'
		do: [ :aStep | 
			| aNodeElementsCount aPipelineElementCount anEvolveElementCount anEdgeCount |
			aStep do
				label: 'Count canvas elements';
				block: [ :aCanvas | 
					aNodeElementsCount := (aCanvas query / GtWardleyMapNodeElement) all size.
					aPipelineElementCount := (aCanvas query / GtWardleyMapPipelineElement) all
							size.
					anEvolveElementCount := (aCanvas query / GtWardleyMapEvolveElement) all
							size.
					anEdgeCount := (aCanvas query / GtWardleyMapEdgeElement) all size ];
				play.

			aStep secondaryClick
				label: 'Open context menu';
				id: (#node asBlocElementId indexed: 0);
				play.

			aStep click
				label: 'Click on delete node';
				onSpaceRoot;
				onDropdown: true;
				// (GtWardleyMapContextMenuItemId
						definingMethod: GtWardleyMapNodeModel >> #menuItemNodeDeleteButton);
				play.

			aStep assert
				label: 'Assert node elements count';
				value: [ :aCanvas | (aCanvas query / GtWardleyMapNodeElement) all size ]
					equals: aNodeElementsCount - 1;
				play.

			aStep assert
				label: 'Assert pipeline elements count';
				value: [ :aCanvas | (aCanvas query / GtWardleyMapPipelineElement) all size ]
					equals: aPipelineElementCount - 1;
				play.

			aStep assert
				label: 'Assert evolve elements count';
				value: [ :aCanvas | (aCanvas query / GtWardleyMapEvolveElement) all size ]
					equals: anEvolveElementCount - 1;
				play.

			aStep assert
				label: 'Assert edge elements count';
				value: [ :aCanvas | (aCanvas query / GtWardleyMapEdgeElement) all size ]
					equals: anEdgeCount - 2;
				play ].


	^ aScripter
]

{ #category : #'examples - ui' }
GtWardleyMapWithScripterExamples >> pipelineWithInnerNodes_mouseOverLabelA [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self pipelineWithInnerNodes.

	aScripter
		substeps: 'Node A hovering'
		do: [ :aStep | 
			aStep
				mouseMoveOverStep: [ :s | 
					s
						label: 'Hover Node A';
						id: (#node asBlocElementId indexed: 0);
						id: GtWardleyMapNodeLabelId ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Node A is highlighted';
						value: [ :aNodeElement | aNodeElement background ]
							equals: [ Color gray asBlBackground ];
						id: (#node asBlocElementId indexed: 0);
						/ #node ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Label A is highlighted';
						value: [ :aLabelElement | 
								aLabelElement text iterator
									detectAttribute: [ :each | each class = BlTextForegroundAttribute ]
									ifFound: [ :that | that paint ]
									ifNone: [ nil ] ]
							equals: [ GtWardleyMapConstants hoverColor ];
						id: (#node asBlocElementId indexed: 0);
						id: GtWardleyMapNodeLabelId ] ].


	^ aScripter
]

{ #category : #'examples - ui' }
GtWardleyMapWithScripterExamples >> pipelineWithInnerNodes_mouseOverNodeA [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self pipelineWithInnerNodes.

	aScripter
		substeps: 'Node A hovering'
		do: [ :aStep | 
			aStep
				mouseMoveOverStep: [ :s | 
					s
						label: 'Hover Node A';
						id: (#node asBlocElementId indexed: 0) ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Node A is highlighted';
						value: [ :aNodeElement | aNodeElement background ]
							equals: [ GtWardleyMapConstants hoverColor asBlBackground ];
						id: (#node asBlocElementId indexed: 0);
						/ #node ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Label A is highlighted';
						value: [ :aLabelElement | 
								aLabelElement text iterator
									detectAttribute: [ :each | each class = BlTextForegroundAttribute ]
									ifFound: [ :that | that paint ]
									ifNone: [ nil ] ]
							equals: [ GtWardleyMapConstants hoverColor ];
						id: (#node asBlocElementId indexed: 0);
						id: GtWardleyMapNodeLabelId ] ].


	^ aScripter
]
