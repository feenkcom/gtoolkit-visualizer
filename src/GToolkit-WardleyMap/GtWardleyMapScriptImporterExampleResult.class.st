Class {
	#name : #GtWardleyMapScriptImporterExampleResult,
	#superclass : #Object,
	#instVars : [
		'originalWardleyMap',
		'script',
		'importedWardleyMap'
	],
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #'gt - extensions' }
GtWardleyMapScriptImporterExampleResult >> gtImportedWarldeyMapLiveFor: aView [
	<gtView>
	^ aView explicit
		title: 'Imported Map';
		priority: 5;
		stencil: [ GtWardleyMapElement new
				wardleyMapViewModel: (GtWardleyMapViewModel new wardleyMapModel: self importedWardleyMap);
				yourself ]
]

{ #category : #'gt - extensions' }
GtWardleyMapScriptImporterExampleResult >> gtOriginalWardleyScriptFor: aView [
	<gtView>
	
	^ (aView textEditor)
		title: 'Original Script';
		priority: 2;
		aptitude: [ BrGlamorousCodeEditorAptitude ];
		styler: [ GtWardleyMapParser gtStyler ];
		text: [ self script ];
		actionButtonLabel: 'AST' tooltip: 'Parse script' action: [ :aButton | 
			aButton phlow spawnObject: (GtWardleyMapParser parse: self script) ]
]

{ #category : #'gt - extensions' }
GtWardleyMapScriptImporterExampleResult >> gtOriginalWarldeyMapLiveFor: aView [
	<gtView>
	^ aView explicit
		title: 'Original Map';
		priority: 1;
		stencil: [ GtWardleyMapElement new
				wardleyMapViewModel: (GtWardleyMapViewModel new wardleyMapModel: self originalWardleyMap);
				yourself ]
]

{ #category : #'gt - extensions' }
GtWardleyMapScriptImporterExampleResult >> gtOrignalAndImportedNodeDiffFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Node Diff';
		priority: 10;
		items: [ self originalWardleyMap nodes ];
		column: 'Index'
			text: [ :_ :anIndex | anIndex ]
			width: 40;
		column: 'Label'
			text: [ :aNode :anIndex | 
				self
					importedNode: aNode
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
					importedNode: aNode
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
					importedNode: aNode
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

{ #category : #private }
GtWardleyMapScriptImporterExampleResult >> importedNode: anOriginalNode at: aNodeIndex ifFound: aFoundBlock ifNone: aNoneBlock [
	| anImportedNode |
	anImportedNode := self importedWardleyMap nodes at: aNodeIndex.

	^ anImportedNode
		ifNotNil: [ aFoundBlock cull: anImportedNode cull: aNodeIndex ]
		ifNil: [ aNoneBlock value ]
]

{ #category : #accessing }
GtWardleyMapScriptImporterExampleResult >> importedWardleyMap [
	^ importedWardleyMap
]

{ #category : #accessing }
GtWardleyMapScriptImporterExampleResult >> importedWardleyMap: anObject [
	importedWardleyMap := anObject
]

{ #category : #accessing }
GtWardleyMapScriptImporterExampleResult >> originalWardleyMap [
	^ originalWardleyMap
]

{ #category : #accessing }
GtWardleyMapScriptImporterExampleResult >> originalWardleyMap: anObject [
	originalWardleyMap := anObject
]

{ #category : #accessing }
GtWardleyMapScriptImporterExampleResult >> script [
	^ script
]

{ #category : #accessing }
GtWardleyMapScriptImporterExampleResult >> script: anObject [
	script := anObject
]
