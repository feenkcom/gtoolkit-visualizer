Class {
	#name : #GtWardleyMapScriptExampleResult,
	#superclass : #Object,
	#instVars : [
		'originalWardleyMap',
		'originalScript',
		'resultingWardleyMap',
		'resultingScript'
	],
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #'gt - extensions' }
GtWardleyMapScriptExampleResult >> gtOriginalAndResultingScriptDiffFor: aView [
	<gtView>
	self originalScript ifNil: [ ^ aView empty ].
	self resultingScript ifNil: [ ^ aView empty ].
	
	^ aView explicit
		title: 'Scripts Diff';
		priority: 22;
		stencil: [ GtDiffElementWithLabelStencil new
				fromLabelText: 'Original script:';
				toLabelText: 'Resulting script:';
				change: (GtDiffBuilder
					computeDifferencesFrom: self originalScript
					to: self resultingScript
					using: GtCharacterGroupDiffSplitter words);
				styler: GtWardleyMapParser gtStyler ]
]

{ #category : #'gt - extensions' }
GtWardleyMapScriptExampleResult >> gtOriginalWardleyScriptFor: aView [
	<gtView>
	
	self originalScript ifNil: [ ^ aView empty ].
	
	^ (aView textEditor)
		title: 'Original Script';
		priority: 2;
		aptitude: [ BrGlamorousCodeEditorAptitude ];
		styler: [ GtWardleyMapParser gtStyler ];
		text: [ self originalScript ];
		actionButtonLabel: 'AST' tooltip: 'Parse script' action: [ :aButton | 
			aButton phlow spawnObject: (GtWardleyMapParser parse: self originalScript) ]
]

{ #category : #'gt - extensions' }
GtWardleyMapScriptExampleResult >> gtOriginalWarldeyMapLiveFor: aView [
	<gtView>
	self originalWardleyMap ifNil: [ ^ aView empty ].
	
	^ aView explicit
		title: 'Original Map';
		priority: 1;
		stencil: [ GtWardleyMapElement new
				wardleyMapViewModel: (GtWardleyMapViewModel new wardleyMapModel: self originalWardleyMap);
				yourself ]
]

{ #category : #'gt - extensions' }
GtWardleyMapScriptExampleResult >> gtOrignalAndResultingNodeDiffFor: aView [
	<gtView>
	self originalWardleyMap ifNil: [ ^ aView empty ].
	self resultingWardleyMap ifNil: [ ^ aView empty ].
	
	^ aView columnedList
		title: 'Node Diff';
		priority: 20;
		items: [ self originalWardleyMap nodes ];
		column: 'Index'
			text: [ :_ :anIndex | anIndex ]
			width: 40;
		column: 'Label'
			text: [ :aNode :anIndex | 
				self
					resultingNode: aNode
					at: anIndex
					ifFound: [ :anImportedNode | 
						aNode label = anImportedNode label
							ifTrue: [ aNode label asRopedText foreground: BrGlamorousColors successBackgroundColor ]
							ifFalse: [ aNode label asRopedText
									append: (' vs. ' asRopedText foreground: BrGlamorousColors disabledButtonTextColor);
									append: (anImportedNode label asRopedText foreground: BrGlamorousColors errorBackgroundColor) ] ]
					ifNone: [ aNode label asRopedText
							foreground: BrGlamorousColors errorBackgroundColor ] ];
		column: 'X'
			text: [ :aNode :anIndex | 
				self
					resultingNode: aNode
					at: anIndex
					ifFound: [ :anImportedNode | 
						aNode x = anImportedNode x
							ifTrue: [ aNode x asRopedText foreground: BrGlamorousColors successBackgroundColor ]
							ifFalse: [ aNode x asRopedText
									append: (' vs. ' asRopedText foreground: BrGlamorousColors disabledButtonTextColor);
									append: (anImportedNode x asRopedText foreground: BrGlamorousColors errorBackgroundColor) ] ]
					ifNone: [ aNode x asRopedText
							foreground: BrGlamorousColors errorBackgroundColor ] ];
		column: 'Y'
			text: [ :aNode :anIndex | 
				self
					resultingNode: aNode
					at: anIndex
					ifFound: [ :anImportedNode | 
						aNode y = anImportedNode y
							ifTrue: [ aNode y asRopedText foreground: BrGlamorousColors successBackgroundColor ]
							ifFalse: [ aNode y asRopedText
									append: (' vs. ' asRopedText foreground: BrGlamorousColors disabledButtonTextColor);
									append: (anImportedNode y asRopedText foreground: BrGlamorousColors errorBackgroundColor) ] ]
					ifNone: [ aNode y asRopedText
							foreground: BrGlamorousColors errorBackgroundColor ] ]
]

{ #category : #'gt - extensions' }
GtWardleyMapScriptExampleResult >> gtResultingWardleyScriptFor: aView [
	<gtView>
	
	self resultingScript ifNil: [ ^ aView empty ].
	
	^ (aView textEditor)
		title: 'Resulting Script';
		priority: 12;
		aptitude: [ BrGlamorousCodeEditorAptitude ];
		styler: [ GtWardleyMapParser gtStyler ];
		text: [ self resultingScript ];
		actionButtonLabel: 'AST' tooltip: 'Parse script' action: [ :aButton | 
			aButton phlow spawnObject: (GtWardleyMapParser parse: self resultingScript) ]
]

{ #category : #'gt - extensions' }
GtWardleyMapScriptExampleResult >> gtResultingWarldeyMapLiveFor: aView [
	<gtView>
	self resultingWardleyMap ifNil: [ ^ aView empty ].
	
	^ aView explicit
		title: 'Resulting Map';
		priority: 10;
		stencil: [ GtWardleyMapElement new
				wardleyMapViewModel: (GtWardleyMapViewModel new wardleyMapModel: self resultingWardleyMap);
				yourself ]
]

{ #category : #accessing }
GtWardleyMapScriptExampleResult >> originalScript [
	^ originalScript
]

{ #category : #accessing }
GtWardleyMapScriptExampleResult >> originalScript: anObject [
	originalScript := anObject
]

{ #category : #accessing }
GtWardleyMapScriptExampleResult >> originalWardleyMap [
	^ originalWardleyMap
]

{ #category : #accessing }
GtWardleyMapScriptExampleResult >> originalWardleyMap: anObject [
	originalWardleyMap := anObject
]

{ #category : #private }
GtWardleyMapScriptExampleResult >> resultingNode: anOriginalNode at: aNodeIndex ifFound: aFoundBlock ifNone: aNoneBlock [
	| aResultingNode |
	aResultingNode := self resultingWardleyMap nodes at: aNodeIndex.

	^ aResultingNode
		ifNotNil: [ aFoundBlock cull: aResultingNode cull: aNodeIndex ]
		ifNil: [ aNoneBlock value ]
]

{ #category : #accessing }
GtWardleyMapScriptExampleResult >> resultingScript [
	^ resultingScript
]

{ #category : #accessing }
GtWardleyMapScriptExampleResult >> resultingScript: anObject [
	resultingScript := anObject
]

{ #category : #accessing }
GtWardleyMapScriptExampleResult >> resultingWardleyMap [
	^ resultingWardleyMap
]

{ #category : #accessing }
GtWardleyMapScriptExampleResult >> resultingWardleyMap: anObject [
	resultingWardleyMap := anObject
]
