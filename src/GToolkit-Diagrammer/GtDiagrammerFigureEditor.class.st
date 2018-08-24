Class {
	#name : #GtDiagrammerFigureEditor,
	#superclass : #Object,
	#instVars : [
		'editorBlock',
		'title',
		'condition',
		'announcer',
		'parent',
		'editorDeclarations'
	],
	#category : 'GToolkit-Diagrammer-Model'
}

{ #category : #'instance creation' }
GtDiagrammerFigureEditor class >> editorsOf: anObject [
	| aComposite |

	aComposite := GtDiagrammerCompositeEditor new.
	self editorsOf: anObject in: aComposite.
	^ aComposite editors
]

{ #category : #'instance creation' }
GtDiagrammerFigureEditor class >> editorsOf: anObject in: aComposite [
	((Pragma
		allNamed: #diagrammerEditor:
		from: anObject class
		to: BlElement)
		sorted: [ :a :b | (a argumentAt: 1) < (b argumentAt: 1) ])
		do: [ :aPragma | anObject perform: aPragma methodSelector with: aComposite ]
]

{ #category : #enumeration }
GtDiagrammerFigureEditor >> allEditors [
	<return: #Array of: #GtDiagrammerFigureEditor>

	^ Array streamContents: [ :aStream |
		self editors do: [ :anEditor |
			aStream nextPut: anEditor.
			aStream nextPutAll: anEditor allEditors ] ]
]

{ #category : #enumeration }
GtDiagrammerFigureEditor >> allEditorsThatMeetCondition [
	<return: #Array of: #GtDiagrammerFigureEditor>

	^ Array streamContents: [ :aStream |
		self editors do: [ :anEditor |
			anEditor meetsCondition
				ifTrue: [
					aStream nextPut: anEditor.
					aStream nextPutAll: anEditor allEditorsThatMeetCondition ] ] ]
]

{ #category : #'api - script' }
GtDiagrammerFigureEditor >> and: anEditorBlock [
	anEditorBlock value: self with
]

{ #category : #announcement }
GtDiagrammerFigureEditor >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #updating }
GtDiagrammerFigureEditor >> changed [
	"Let editor know that the structure of its graphical representation changed and it should be recreated"

	self root notifyChanged
]

{ #category : #announcement }
GtDiagrammerFigureEditor >> changedDo: aBlock [
	self announcer when: GtDiagrammerEditorChanged do: aBlock
]

{ #category : #announcement }
GtDiagrammerFigureEditor >> changedSend: aSymbol to: anReceiverObject [
	self announcer weak when: GtDiagrammerEditorChanged send: aSymbol to: anReceiverObject
]

{ #category : #accessing }
GtDiagrammerFigureEditor >> editor [
	"Return an editor element for the property"
	<return: #BlElement>

	^ editorBlock cull: self
]

{ #category : #'api - script' }
GtDiagrammerFigureEditor >> editor: aBlock [
	editorBlock := aBlock
]

{ #category : #accessing }
GtDiagrammerFigureEditor >> editors [
	^ Array streamContents: [ :aStream |
		editorDeclarations do: [ :anEditorDeclaration |
			| theEditors |
			
			theEditors := anEditorDeclaration editors.
			theEditors do: [ :anEditor | anEditor parent: self ].
			aStream nextPutAll: theEditors ] ]
]

{ #category : #enumeration }
GtDiagrammerFigureEditor >> editorsThatMeetCondition [
	<return: #Array of: #GtDiagrammerFigureEditor>

	^ self editors select: #meetsCondition
]

{ #category : #'api - script' }
GtDiagrammerFigureEditor >> from: anObjectOrBlock [
	"Add all editors for an object as my sub-editors when condition meets"
	| aDeclaration |

	aDeclaration := self newDeclaration.
	aDeclaration condition: [ self meetsCondition ].
	aDeclaration editors: [ self class editorsOf: anObjectOrBlock value ].

	editorDeclarations add: aDeclaration
]

{ #category : #testing }
GtDiagrammerFigureEditor >> hasParent [
	^ parent isNotNil
]

{ #category : #testing }
GtDiagrammerFigureEditor >> hasVisualRepresentation [
	<return: #Boolean>

	^ editorBlock isNotNil
]

{ #category : #initialization }
GtDiagrammerFigureEditor >> initialize [
	super initialize.

	editorDeclarations := OrderedCollection new.

	title := ''.
	editorBlock := nil.
	condition := true
]

{ #category : #testing }
GtDiagrammerFigureEditor >> meetsCondition [
	<return: #Boolean>

	^ condition value
]

{ #category : #'instance creation' }
GtDiagrammerFigureEditor >> newDeclaration [
	^ GtDiagrammerFigureEditorDeclaration new
]

{ #category : #announcement }
GtDiagrammerFigureEditor >> notifyChanged [
	self announcer announce: (GtDiagrammerEditorChanged editor: self)
]

{ #category : #accessing }
GtDiagrammerFigureEditor >> parent [
	<return: #GtDiagrammerFigureEditor>
	self
		assert: [ self hasParent ]
		description: [ 'Parent can not be accessed if it does not exist' ].

	^ parent
]

{ #category : #'private - accessing' }
GtDiagrammerFigureEditor >> parent: aGtDiagrammerFigureEditor [
	
	self
		assert: [ self hasParent not or: [ self parent == aGtDiagrammerFigureEditor ] ]
		description: [ 'I already have a different parent editor' ].

	parent := aGtDiagrammerFigureEditor
]

{ #category : #accessing }
GtDiagrammerFigureEditor >> root [
	<return: #GtDiagrammerFigureEditor>
	
	^ self hasParent
		ifTrue: [ self parent root ]
		ifFalse: [ self ]
]

{ #category : #accessing }
GtDiagrammerFigureEditor >> title [
	<return: #String>

	^ title
]

{ #category : #'api - script' }
GtDiagrammerFigureEditor >> title: aString [
	title := aString
]

{ #category : #'api - script' }
GtDiagrammerFigureEditor >> when: aBlock [
	condition := aBlock
]

{ #category : #'api - script' }
GtDiagrammerFigureEditor >> with [
	| anEditor aDeclaration |
	
	anEditor := self class new.

	aDeclaration := self withDeclaration.
	aDeclaration editor: anEditor.

	^ anEditor
]

{ #category : #'instance creation' }
GtDiagrammerFigureEditor >> withDeclaration [
	| aDeclaration |
	
	aDeclaration := self newDeclaration.
	editorDeclarations add: aDeclaration.
	
	^ aDeclaration
]
