"
#Wardley Map model
Represents a Wardley Map model, see [](https://en.wikipedia.org/wiki/Wardley_map) to learn more about the concept.
A map consists of {{gtClass:GtWardleyMapNodeModel}} that can be connected with {{gtClass:GtWardleyMapEdgeModel}}.
{{gtExample:GtWardleyMapModelExamples>>#newMapWithNodes|codeExpanded=false|previewExpanded=true|previewShow=#gtLiveFor:|previewHeight=200}}
#Visitor
Each model entity that uses {{gtClass:TGtWardleyMapVisitable}} is able to be visited by {{gtClass:TGtWardleyMapVisitor}}. One of the applications is an ability to export a map to various formats such as {{gtClass:Dictionary}} or {{gtClass:STONJSON}}:
{{gtExample:GtWardleyMapModelExamples>>#newMapWithNodes|codeExpanded=false|previewExpanded=true|previewShow=#gtJSONFor:|previewHeight=300}}


"
Class {
	#name : #GtWardleyMapModel,
	#superclass : #Object,
	#traits : 'TGtAnnouncer + TGtWardleyMapExportable + TGtWardleyMapVisitable + TGtOptions + TGtWithWardleyContextMenuItems + TGtWithWardleyMapDecoratorModels',
	#classTraits : 'TGtAnnouncer classTrait + TGtWardleyMapExportable classTrait + TGtWardleyMapVisitable classTrait + TGtOptions classTrait + TGtWithWardleyContextMenuItems classTrait + TGtWithWardleyMapDecoratorModels classTrait',
	#instVars : [
		'announcer',
		'nodes',
		'edges',
		'sections',
		'title',
		'notes',
		'isTitleVisible',
		'evolutionSections',
		'isEvolutionAxisVisible'
	],
	#category : #'GToolkit-WardleyMap-! Models'
}

{ #category : #comparing }
GtWardleyMapModel >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ title = anObject title 
		and: [ isTitleVisible = anObject isTitleVisible 
		and: [ nodes = anObject nodes 
		and: [ edges = anObject edges
		and: [ isEvolutionAxisVisible = anObject isEvolutionAxisVisible
		and: [ evolutionSections = anObject evolutionSections ] ] ] ] ]
]

{ #category : #visiting }
GtWardleyMapModel >> accept: aWardleyMapVisitor [
	^ aWardleyMapVisitor visitWardleyMap: self
]

{ #category : #'api - edges' }
GtWardleyMapModel >> addEdge: aGtWardleyMapEdgeModel [
	aGtWardleyMapEdgeModel hasParent
		ifTrue: [ GtWardleyMapParentAlreadySetError signal ].

	self
		assert: [ aGtWardleyMapEdgeModel notNil ]
		description: [ 'Edge must not be nil' ].

	self
		assert: [ self hasNode: aGtWardleyMapEdgeModel fromNode ]
		description: [ 'The edge must be from the existing node' ].

	self
		assert: [ self hasNode: aGtWardleyMapEdgeModel toNode ]
		description: [ 'The edge must be from the existing node' ].

	"`self` edges are not permitted"
	aGtWardleyMapEdgeModel fromNode = aGtWardleyMapEdgeModel toNode
		ifTrue: [ ^ self ].

	"only one edges between nodes is allowed"
	(self hasEdgeConnecting: aGtWardleyMapEdgeModel fromNode and: aGtWardleyMapEdgeModel toNode)
		ifTrue: [ ^ self ].

	self edges add: aGtWardleyMapEdgeModel.
	aGtWardleyMapEdgeModel parent: self.
	self announce: (GtWardleyMapEdgeModelAdded new edgeModel: aGtWardleyMapEdgeModel)
]

{ #category : #'api - nodes' }
GtWardleyMapModel >> addNode: aGtWardleyMapNodeModel [
	aGtWardleyMapNodeModel hasParent
		ifTrue: [ GtWardleyMapParentAlreadySetError signal ].

	aGtWardleyMapNodeModel hasId
		ifFalse: [ aGtWardleyMapNodeModel id: self nextUniqueId ]
		ifTrue: [
			(self hasNodeWithId: aGtWardleyMapNodeModel id)
				ifTrue: [ self error: 'Can not add a node with already used id' ]. ].

	nodes add: aGtWardleyMapNodeModel.
	aGtWardleyMapNodeModel parent: self.
	self announce: (GtWardleyMapNodeModelAdded new nodeModel: aGtWardleyMapNodeModel)
]

{ #category : #'api - nodes' }
GtWardleyMapModel >> addNote: aGtWardleyMapNoteModel [
	aGtWardleyMapNoteModel hasParent
		ifTrue: [ GtWardleyMapParentAlreadySetError signal ].

	aGtWardleyMapNoteModel hasId
		ifFalse: [ aGtWardleyMapNoteModel id: self nextUniqueId ]
		ifTrue: [
			(self hasNoteWithId: aGtWardleyMapNoteModel id)
				ifTrue: [ self error: 'Can not add a note with already used id' ]. ].

	notes add: aGtWardleyMapNoteModel.
	aGtWardleyMapNoteModel parent: self.
	self announce: (GtWardleyMapNoteModelAdded new noteModel: aGtWardleyMapNoteModel)
]

{ #category : #'api - edges' }
GtWardleyMapModel >> allEdgesConnecting: aWardleyMapNodeModel do: aBlock [
	| theEdges |
	
	theEdges := self edges select: [ :eachEdge | eachEdge fromNode = aWardleyMapNodeModel or: [ eachEdge toNode = aWardleyMapNodeModel ] ].
	theEdges do: aBlock
]

{ #category : #announcer }
GtWardleyMapModel >> announcer [
	<return: #Announcer>

	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #converting }
GtWardleyMapModel >> asWardleyMapScript [
	^ GtWardleyMapScriptExporter new
		beNewPipelineSyntax;
		beLfNewLine;
		wardleyMap: self;
		export;
		script
]

{ #category : #'api - edges' }
GtWardleyMapModel >> edgeFromNode: aFromNode toNode: aToNode ifFound: aFoundBlock ifNone: aNoneBlock [
	^ self edges
		detect: [ :anEdge | anEdge fromNode == aFromNode and: [ anEdge toNode == aToNode ] ]
		ifFound: aFoundBlock
		ifNone: aNoneBlock
]

{ #category : #'api - nodes' }
GtWardleyMapModel >> edgeWithName: aName ifFound: aFoundBlock ifNone: aNoneBlock [
	^ self edges
		detect: [ :eachEdge | eachEdge label = aName ]
		ifFound: aFoundBlock
		ifNone: aNoneBlock
]

{ #category : #'api - edges' }
GtWardleyMapModel >> edges [
	^ edges
]

{ #category : #accessing }
GtWardleyMapModel >> edges: aCollection [
	edges copy do: [ :anEdge | self removeEdge: anEdge ].
	aCollection do: [ :anEdge | self addEdge: anEdge ]
]

{ #category : #'api - decorators' }
GtWardleyMapModel >> ensureAllProposition [
	(self wardleyMapDecoratorModels anySatisfy: #isAllProposition)
		ifTrue: [ ^ self ].
	self addWardleyMapDecoratorModel: GtWardleyMapAllProposition new
]

{ #category : #'api - title' }
GtWardleyMapModel >> evolutionSections [
	<return: #Array of: #String>
	^ evolutionSections
		ifNil: [ evolutionSections := GtWardleyMapConstants defaultEvolutionSections ]
]

{ #category : #'api - title' }
GtWardleyMapModel >> evolutionSections: aCollectionOfStrings [
	self evolutionSections = aCollectionOfStrings
		ifTrue: [ ^ self ].

	evolutionSections := aCollectionOfStrings.
	self notifyEvolutionSectionsChanged.
]

{ #category : #'gt-extensions' }
GtWardleyMapModel >> gtEdgesFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'Edges';
		priority: 20;
		items: [ self edges ];
		column: 'Index' text: [ :_ :anIndex | anIndex ] width: 40;
		column: 'Color' 
			stencil: [ :aNode |
				BlElement new 
					size: 8@8;
					background: aNode color;
					geometry: BlCircleGeometry new;
					margin: (BlInsets left: 3 right: 3);
					constraintsDo: [ :c | 
						c linear vertical alignCenter ] ] 
			width: 40;
		column: 'From' text: [ :anEdge | anEdge fromNode label ];
		column: 'To' text: [ :anEdge | anEdge toNode label ];
		column: 'Label' text: [ :anEdge | anEdge label ];
		column: 'Visible label' text: [ :anEdge | 
			anEdge isLabelVisible 
				ifTrue: [ 'yes' ] 
				ifFalse: [ 'no' asRopedText foreground: BrGlamorousColors disabledButtonTextColor ] ]
]

{ #category : #'gt-extensions' }
GtWardleyMapModel >> gtJSONFor: aView [
	<gtView>

	^ aView textEditor
		title: 'JSON';
		priority: 8;
		aptitude: [ BrGlamorousCodeEditorAptitude ];
		styler: [ JSONParser gtStyler ];
		text: [ self asJSONForExport ];
		actionUpdateButtonTooltip: 'Update JSON';
		actionButtonLabel: 'Copy'
			action: [ Clipboard clipboardText: self asJSONForExport ]
]

{ #category : #'gt-extensions' }
GtWardleyMapModel >> gtLiveFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Live';
		priority: 2;
		stencil: [
			GtWardleyMapElement new
				wardleyMapViewModel: (GtWardleyMapViewModel new wardleyMapModel: self);
				yourself ]
]

{ #category : #'gt-extensions' }
GtWardleyMapModel >> gtNodesFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'Nodes';
		priority: 20;
		items: [ self nodes ];
		column: 'Index' text: [ :_ :anIndex | anIndex ] width: 40;
		column: 'Color' 
			stencil: [ :aNode |
				BlElement new 
					size: 8@8;
					background: aNode color;
					geometry: BlCircleGeometry new;
					margin: (BlInsets left: 3 right: 3);
					constraintsDo: [ :c | 
						c linear vertical alignCenter ] ] 
			width: 40;
		column: 'Name' text: #label;
		column: 'With pipeline' 
			text: [ :aNode | aNode isPipelineVisible 
				ifTrue: [ 'yes' ] 
				ifFalse: [ 'no' asRopedText foreground: BrGlamorousColors disabledButtonTextColor ] ]
			width: 85;
		column: 'Inner nodes' 
			text: [ :aNode | 
				| aSize |
				aSize := aNode innerNodes size.
				aSize isZero 
					ifTrue: [ aSize asRopedText foreground: BrGlamorousColors disabledButtonTextColor ]
					ifFalse: [ aSize ] ]
			 width: 80;
		column: 'Evolve' text: [ :aNode | 
			aNode isEvolveVisible
				ifFalse: [ 'no' asRopedText foreground: BrGlamorousColors disabledButtonTextColor ]
				ifTrue: [ aNode evolvedLabel ] ];
		column: 'X' text: [ :aNode | aNode x printShowingDecimalPlaces: 3 ] width: 50;
		column: 'Y' text: [ :aNode | aNode y printShowingDecimalPlaces: 3 ] width: 50;
		column: 'Label X' text: [ :aNode | aNode labelModel x printShowingDecimalPlaces: 3 ] width: 50;
		column: 'Label Y' text: [ :aNode | aNode labelModel y printShowingDecimalPlaces: 3 ] width: 50
]

{ #category : #'gt-extensions' }
GtWardleyMapModel >> gtNotesFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'Notes';
		priority: 25;
		items: [ self notes ];
		column: 'Index' text: [ :_ :anIndex | anIndex ] width: 40;
		column: 'Color' 
			stencil: [ :aNode |
				BlElement new 
					size: 8@8;
					background: aNode color;
					geometry: BlCircleGeometry new;
					margin: (BlInsets left: 3 right: 3);
					constraintsDo: [ :c | 
						c linear vertical alignCenter ] ] 
			width: 40;
		column: 'Text' text: #label
]

{ #category : #'gt - extensions' }
GtWardleyMapModel >> gtWardleyMapDecorators [
	^ Array streamContents: [ :aStream | 
		self wardleyMapDecoratorModels  do: [ :aDecorator | 
				aStream nextPut: self -> aDecorator ].
		self nodes do: [ :each | 
	 		each wardleyMapDecoratorModels do: [ :aDecorator | 
				aStream nextPut: each -> aDecorator ] ].
		self edges do: [ :each | 
			each wardleyMapDecoratorModels do: [ :aDecorator | 
	 			aStream nextPut: each -> aDecorator ] ] ]
]

{ #category : #'gt - extensions' }
GtWardleyMapModel >> gtWardleyMapDecoratorsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Decorators';
		priority: 30;
		items: [ self gtWardleyMapDecorators ];
		column: 'Item' text: [ :anAssoc | anAssoc key ];
		column: 'Decorator' text: [ :anAssoc | anAssoc value ];
		column: 'Proposition'
			text: [ :anAssoc | 
				anAssoc value isActionableProposition
					ifTrue: [ 'yes' ]
					ifFalse: [ 'no' asRopedText foreground: BrGlamorousColors disabledButtonTextColor ] ] width: 50;
		send: #value
]

{ #category : #'gt-extensions' }
GtWardleyMapModel >> gtWardleyScriptFor: aView [
	<gtView>
	
	^ (aView textEditor)
		title: 'Script';
		priority: 9;
		aptitude: [ BrGlamorousCodeEditorAptitude ];
		styler: [ GtWardleyMapParser gtStyler ];
		text: [ self asWardleyMapScript ];
		actionUpdateButtonTooltip: 'Update Script';
		actionButtonLabel: 'Copy' action: [ Clipboard clipboardText: self asWardleyMapScript ];
		actionButtonLabel: 'AST' tooltip: 'Parse script' action: [ :aButton | 
			aButton phlow spawnObject: (GtWardleyMapParser parse: self asWardleyMapScript) ]
]

{ #category : #testing }
GtWardleyMapModel >> hasEdgeConnecting: aNodeModel and: anotherNodeModel [

	^ self edges anySatisfy: [ :eachEdge |
		(eachEdge fromNode = aNodeModel
			or: [ eachEdge fromNode = anotherNodeModel ])
				and: [ eachEdge toNode = aNodeModel
					or: [ eachEdge toNode = anotherNodeModel ] ] ]
]

{ #category : #testing }
GtWardleyMapModel >> hasNode: aGtWardleyMapNodeModel [
	self
		assert: [ aGtWardleyMapNodeModel notNil ]
		description: [ 'Map node must not be nil' ].
		
	^ self nodes includes: aGtWardleyMapNodeModel
]

{ #category : #testing }
GtWardleyMapModel >> hasNodeWithId: anId [
	^ self
		nodeWithId: anId
		ifFound: [ true ]
		ifNone: [ false ]
]

{ #category : #testing }
GtWardleyMapModel >> hasNoteWithId: anId [
	^ self
		noteWithId: anId
		ifFound: [ true ]
		ifNone: [ false ]
]

{ #category : #testing }
GtWardleyMapModel >> hasParent [
	^ false
]

{ #category : #comparing }
GtWardleyMapModel >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ ((((title hash 
		bitXor: isTitleVisible hash) 
		bitXor: nodes hash)
		bitXor: edges hash)
		bitXor: isEvolutionAxisVisible hash)
		bitXor: evolutionSections hash
]

{ #category : #initialization }
GtWardleyMapModel >> initialize [
	super initialize.

	nodes := OrderedCollection new.
	edges := OrderedCollection new.
	notes := OrderedCollection new.
	title := GtWardleyMapUtility defaultMapTitle.
	isTitleVisible := false.
	evolutionSections := GtWardleyMapConstants defaultEvolutionSections.
	isEvolutionAxisVisible := true
]

{ #category : #'api - evolution sections' }
GtWardleyMapModel >> isEvolutionAxisVisible [
	<return: #Boolean>
	^ isEvolutionAxisVisible ifNil: [ isEvolutionAxisVisible := true ]
]

{ #category : #'api - evolution sections' }
GtWardleyMapModel >> isEvolutionAxisVisible: aBoolean [
	self isEvolutionAxisVisible = aBoolean
		ifTrue: [ ^ self ].
		
	isEvolutionAxisVisible := aBoolean.
	self notifyEvolutionAxisVisibilityChanged
]

{ #category : #'api - title' }
GtWardleyMapModel >> isTitleVisible [
	<return: #Boolean>
	^ isTitleVisible ifNil: [ isTitleVisible := false ]
]

{ #category : #'api - title' }
GtWardleyMapModel >> isTitleVisible: aBoolean [
	self isTitleVisible = aBoolean
		ifTrue: [ ^ self ].
		
	isTitleVisible := aBoolean.
	self notifyTitleVisibilityChanged
]

{ #category : #'api - context menu' }
GtWardleyMapModel >> menuItemAddItemLabel [
	<wardleyContextMenuItem: 1>
	^ GtWardleyMapLabelMenuItem new text: 'Add item:'
]

{ #category : #'api - context menu' }
GtWardleyMapModel >> menuItemAddNodeButton [
	<wardleyContextMenuItem: 3>
	^ GtWardleyMapNodeButtonWithLabelMenuItem new
		label: 'Add node';
		action: [ :aContextMenuItem :aBrButton :aBrButtonModel :anEvent | 
			| aNormalizedPosition |
			anEvent consumed: true.
			aNormalizedPosition := GtWardleyMapUtility
					normalizedItemPositionOnEvent: anEvent
					canvas: aContextMenuItem canvasElement.
			aNormalizedPosition
				ifNotNil: [ aContextMenuItem wardleyMapViewModel
						addNewNodeAt: aNormalizedPosition
						fromElement: aBrButton ].
			aContextMenuItem editorElement fireEvent: BrContextMenuHideWish new ]
]

{ #category : #'api - context menu' }
GtWardleyMapModel >> menuItemAddNoteButton [
	<wardleyContextMenuItem: 2>
	^ GtWardleyMapNodeButtonWithLabelMenuItem new
		label: 'Add note';
		action: [ :aContextMenuItem :aBrButton :aBrButtonModel :anEvent | 
			| aNormalizedPosition |
			anEvent consumed: true.
			aNormalizedPosition := GtWardleyMapUtility
					normalizedItemPositionOnEvent: anEvent
					canvas: aContextMenuItem canvasElement.
			aNormalizedPosition ifNotNil: [ 
				aContextMenuItem wardleyMapViewModel 
					addNewNoteAt: aNormalizedPosition ].
			aContextMenuItem editorElement fireEvent: BrContextMenuHideWish new ]
]

{ #category : #'api - context menu' }
GtWardleyMapModel >> menuItemMapVisibilityLabel [
	<wardleyContextMenuItem: 4>
	^ GtWardleyMapLabelMenuItem new text: 'Map visibility:'
]

{ #category : #'api - context menu' }
GtWardleyMapModel >> menuItemSectionsVisibilityButton [
	<wardleyContextMenuItem: 6>
	^ GtWardleyMapEvolutionAxisVisiblityMenuItem new
]

{ #category : #'api - context menu' }
GtWardleyMapModel >> menuItemTitleVisibilityPicker [
	<wardleyContextMenuItem: 5>
	^ GtWardleyMapTitleVisiblityMenuItem new
]

{ #category : #private }
GtWardleyMapModel >> nextUniqueId [
	| aNextId |
	
	aNextId := UUID new.
	[
	self
		nodeWithId: aNextId
		ifFound: [ false ]
		ifNone: [ true ] ] whileFalse: [ aNextId := UUID new ].

	^ aNextId
]

{ #category : #'api - nodes' }
GtWardleyMapModel >> nodeWithId: anId ifFound: aFoundBlock ifNone: aNoneBlock [
	^ self nodes
		detect: [ :eachNode | eachNode id = anId ]
		ifFound: aFoundBlock
		ifNone: aNoneBlock
]

{ #category : #'api - nodes' }
GtWardleyMapModel >> nodeWithName: aName ifFound: aFoundBlock ifNone: aNoneBlock [
	^ self nodes
		detect: [ :eachNode | eachNode label = aName ]
		ifFound: aFoundBlock
		ifNone: aNoneBlock
]

{ #category : #'api - nodes' }
GtWardleyMapModel >> nodes [
	^ nodes
]

{ #category : #'api - nodes' }
GtWardleyMapModel >> nodes: aCollection [
	nodes copy do: [ :aNode | self removeNode: aNode ].
	aCollection do: [ :aNode | self addNode: aNode ]
]

{ #category : #'api - notes' }
GtWardleyMapModel >> noteWithId: anId ifFound: aFoundBlock ifNone: aNoneBlock [
	^ self notes
		detect: [ :eachNote | eachNote id = anId ]
		ifFound: aFoundBlock
		ifNone: aNoneBlock
]

{ #category : #'api - notes' }
GtWardleyMapModel >> noteWithText: aString ifFound: aFoundBlock ifNone: aNoneBlock [
	^ self notes
		detect: [ :eachNote | eachNote label = aString ]
		ifFound: aFoundBlock
		ifNone: aNoneBlock
]

{ #category : #'api - notes' }
GtWardleyMapModel >> notes [
	^ notes ifNil: [ notes := OrderedCollection new ]
]

{ #category : #'api - evolution sections' }
GtWardleyMapModel >> notifyEvolutionAxisVisibilityChanged [
	self announce: GtWardleyMapEvolutionAxisVisibilityChanged new
]

{ #category : #'api - evolution sections' }
GtWardleyMapModel >> notifyEvolutionSectionsChanged [
	self announce: GtWardleyMapEvolutionSectionsChanged new
]

{ #category : #'api - title' }
GtWardleyMapModel >> notifyTitleChanged [
	self announce: GtWardleyMapTitleChanged new
]

{ #category : #'api - title' }
GtWardleyMapModel >> notifyTitleVisibilityChanged [
	self announce: GtWardleyMapTitleVisibilityChanged new
]

{ #category : #'api - decorators' }
GtWardleyMapModel >> notifyWardleyMapDecoratorModelAdded: aWardleyMapDecoratorModel [
	self
		propagateAnnouncement: (GtWardleyMapDecoratorModelAdded new
				decoratorModel: aWardleyMapDecoratorModel)
]

{ #category : #'api - decorators' }
GtWardleyMapModel >> notifyWardleyMapDecoratorModelRemoved: aWardleyMapDecoratorViewModel [
	self
		announce: (GtWardleyMapDecoratorModelRemoved new
				decoratorModel: aWardleyMapDecoratorViewModel)
]

{ #category : #accessing }
GtWardleyMapModel >> propagateAnnouncement: anAnnouncement [
	self announce: anAnnouncement
]

{ #category : #'api - edges' }
GtWardleyMapModel >> removeEdge: aGtWardleyMapEdgeModel [
	self
		assert: [ aGtWardleyMapEdgeModel notNil ]
		description: [ 'Edge must not be nil' ].
		
	self
		assert: [ self hasNode: aGtWardleyMapEdgeModel fromNode ]
		description: [ 'The edge must be from the existing node' ].
		
	self
		assert: [ self hasNode: aGtWardleyMapEdgeModel toNode ]
		description: [ 'The edge must be from the existing node' ].

	self edges remove: aGtWardleyMapEdgeModel ifAbsent: [ ^ self ].
	aGtWardleyMapEdgeModel removeParent.
	self announce: (GtWardleyMapEdgeModelRemoved new edgeModel: aGtWardleyMapEdgeModel)
]

{ #category : #'api - nodes' }
GtWardleyMapModel >> removeNode: aGtWardleyMapNodeModel [

	"before removing a node we should remove all connected edges"	
	self allEdgesConnecting: aGtWardleyMapNodeModel do: [ :eachEdge | self removeEdge: eachEdge ].
	
	"remove its pipeline"
	aGtWardleyMapNodeModel isPipelineVisible: false.
	
	"remove its evolve"
	aGtWardleyMapNodeModel isEvolveVisible: false.
	
	nodes remove: aGtWardleyMapNodeModel ifAbsent: [ ^ self ].
	aGtWardleyMapNodeModel removeParent.
	aGtWardleyMapNodeModel removeFromPipeline.
	aGtWardleyMapNodeModel removeInnerNodes.
	self announce: (GtWardleyMapNodeModelRemoved new nodeModel: aGtWardleyMapNodeModel)
]

{ #category : #'api - nodes' }
GtWardleyMapModel >> removeNote: aGtWardleyMapNoteModel [

	notes remove: aGtWardleyMapNoteModel ifAbsent: [ ^ self ].
	aGtWardleyMapNoteModel removeParent.
	self announce: (GtWardleyMapNoteModelRemoved new noteModel: aGtWardleyMapNoteModel)
]

{ #category : #printing }
GtWardleyMapModel >> storeOn: aStream [
	aStream
		nextPut: $(;
		nextPutAll:
			'GtWardleyMapFromDictionaryImporter new importWardleyMapFrom: (STONJSON fromString: ';
		nextPutAll: self asJSONForExport storeString;
		nextPutAll: '))'
]

{ #category : #'api - title' }
GtWardleyMapModel >> title [
	^ title
]

{ #category : #'api - title' }
GtWardleyMapModel >> title: aString [
	self title = aString
		ifTrue: [ ^ self ].

	title := aString.
	self notifyTitleChanged.
]
