"
I am a special selection on-click chooser with the support of the selection ""dive in"".

Initially, the selection context (or step) is the diagrammer canvas.

 - After the first click on a figure I choose the top-most parent of a clicked figure whose parent is the current selection content, in this case a canvas. Once selected, that parent becomes a new selection context.
 - Next click selects the top-parent of a click target within the selection context after the previous click.
 - If user clicks outside of the current selection context, we reset it and start all over again with the canvas as selection context.

Selection can not dive-in of the elements marked as selection leaf:
[[[
	""make element a selection leaf (or cutting point)""
	element beDiagrammerSelectionLeaf.
	""ask whether an element is a selection leaf (false by default)""
	element isDiagrammerSelectionLeaf
]]]
"
Class {
	#name : #GtDiagrammerSelectionChooser,
	#superclass : #BlEventListener,
	#instVars : [
		'selectionTool',
		'currentSelection',
		'mouseDownPosition'
	],
	#category : #'GToolkit-Diagrammer-Tools - Selection'
}

{ #category : #'instance creation' }
GtDiagrammerSelectionChooser class >> new [
	self error: 'Do not create an instance of ', self name, ' using new. Please use #on: instead'
]

{ #category : #'instance creation' }
GtDiagrammerSelectionChooser class >> on: aSelectionTool [
	^ self basicNew 
		initialize;
		selectionTool: aSelectionTool
]

{ #category : #private }
GtDiagrammerSelectionChooser >> computeSelectionChainFor: anElement [
	<return: #Collection of: #BlElement>
	| theParents |

	"first we have to collect all parents of the given element"
	theParents := Array streamContents: [ :aStream |
		aStream nextPut: anElement.
		anElement allParentsDo: [ :aParentElement | aStream nextPut: aParentElement ] ].

	"then select only those ones that are parents of the element marked as selection leaf (cutting point).
	Note: selection leaf is included in the chain, however selection can not `dive-in` in the leaf"
	theParents := (Array streamContents: [ :aStream |
		| aCurrentParent anIndex |
		anIndex := theParents size.

		[ anIndex > 0 and: [ (aCurrentParent := theParents at: anIndex) isDiagrammerSelectionLeaf not ] ] whileTrue: [
			aStream nextPut: aCurrentParent.
			anIndex := anIndex - 1 ].

		aCurrentParent isDiagrammerSelectionLeaf
			ifTrue: [ aStream nextPut: aCurrentParent ] ]) reversed.
		
	^ theParents
]

{ #category : #accessing }
GtDiagrammerSelectionChooser >> currentSelection [
	<return: #BlElement>

	^ currentSelection ifNil: [ currentSelection := self selectionTool canvas ]
]

{ #category : #accessing }
GtDiagrammerSelectionChooser >> currentSelection: anElement [
	"make a given element current selection context"
	
	self
		assert: [ anElement isNotNil ]
		description: [ 'Current selection can not be set to nil directly' ].
	
	currentSelection := anElement
]

{ #category : #'api - selection' }
GtDiagrammerSelectionChooser >> deselect [
	self selectionTool deselectAll
]

{ #category : #private }
GtDiagrammerSelectionChooser >> findSelectionTarget: aSourceElement ifFound: foundBlock ifNone: exceptionBlock [
	| theParents |

	theParents := self computeSelectionChainFor: aSourceElement.

	theParents
		detect: [ :anElement |
			anElement parent = self currentSelection
				or: [ anElement = self currentSelection
					and: [ anElement ~= self selectionTool canvas ] ] ]
		ifFound: [ :anElement | foundBlock cull: anElement ]
		ifNone: [
			theParents
				detect: [ :anElement | anElement parent = self selectionTool canvas ]
				ifFound: [ :anElement | foundBlock cull: anElement ]
				ifNone: [ exceptionBlock value ] ]
]

{ #category : #'mouse handlers' }
GtDiagrammerSelectionChooser >> mouseDownEvent: anEvent [

	self
		findSelectionTarget: anEvent target
		ifFound: [ :anElement | 
			mouseDownPosition := anElement bounds inSpace position.
			((anElement hasParent: self currentSelection)
				or: [ anElement = self currentSelection ])
				ifFalse: [ self deselect ] ]
		ifNone: [self deselect ]
]

{ #category : #'mouse handlers' }
GtDiagrammerSelectionChooser >> mouseUpEvent: anEvent [

	self
		findSelectionTarget: anEvent target
		ifFound: [ :anElement |
			((mouseDownPosition = anElement bounds inSpace position)
				or: [ self currentSelection = self selectionTool canvas ])
					ifTrue: [ self select: anElement ] ]
		ifNone: [ self deselect ]
]

{ #category : #accessing }
GtDiagrammerSelectionChooser >> resetCurrentSelection [
	currentSelection := nil
]

{ #category : #'api - selection' }
GtDiagrammerSelectionChooser >> select: anElement [
	self selectionTool selectOnly: anElement
]

{ #category : #accessing }
GtDiagrammerSelectionChooser >> selectionTool [
	<return: #GtDiagrammerSelectionTool>

	^ selectionTool
]

{ #category : #accessing }
GtDiagrammerSelectionChooser >> selectionTool: aGtDiagrammerSelectionTool [
	selectionTool := aGtDiagrammerSelectionTool
]
