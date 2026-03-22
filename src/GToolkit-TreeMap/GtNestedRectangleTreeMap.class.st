"
I am a copy of class GtNestedTreeMap. This comment is copied from there, and might not be entirely accurate

Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  State a one line summary. For example, ""I represent a paragraph of text"".

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	containerEllipseBlock:		<Object>
	leafEllipseBlock:		<Object>
	leavesCreationBlock:		<Object>
	leavesSizeBlock:		<Object>
	roots:		<Object>
	traversalBlock:		<Object>


    Implementation Points


"
Class {
	#name : #GtNestedRectangleTreeMap,
	#superclass : #BrStencil,
	#instVars : [
		'traversalBlock',
		'leavesCreationBlock',
		'leavesSizeBlock',
		'roots',
		'layoutIterator',
		'containerElementBlock',
		'leafElementBlock'
	],
	#category : #'GToolkit-TreeMap-Core'
}

{ #category : #api }
GtNestedRectangleTreeMap >> containerElement: aBlock [
	containerElementBlock := aBlock
]

{ #category : #implementation }
GtNestedRectangleTreeMap >> create [
	<return: #BlElement>
	^ roots size = 1 
		ifTrue: [ self createFor: (GtNestedTreeMapContext new model: roots anyOne; level: 1) ]
		ifFalse: [
			| aModelContext anElement |
			aModelContext := GtNestedTreeMapContext new model: roots anyOne; level: 1.
			anElement := self createContainerFor: aModelContext.
			self 
				setup: anElement
				context: aModelContext
				withChildren: roots 
				andLeaves: {}.
			anElement ]
]

{ #category : #implementation }
GtNestedRectangleTreeMap >> createContainerFor: aModelContext [
	| containerElement |
	containerElement := BlElement new
			layout: layoutIterator nextLayout;
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent ];
			border: self newContainterBorder.
	containerElementBlock cull: containerElement cull: aModelContext.
	"(containerElement eventDispatcher wantsEventType: BlClickEvent)
		ifFalse: [ containerElement
				when: BlClickEvent
				do: [ :e | 
					e target phlow spawnObject: aModelContext model.
					e consumed: true ] ]."
	^ containerElement
]

{ #category : #implementation }
GtNestedRectangleTreeMap >> createFor: aModelContext [
	| anElement theModelLeaves theModelNodes aWeight |
	anElement := self createContainerFor: aModelContext.
	theModelLeaves := self createLeavesFor: aModelContext.
	theModelNodes := traversalBlock value: aModelContext model.
	self setup: anElement context: aModelContext withChildren: theModelNodes andLeaves: theModelLeaves.
	aWeight := anElement children 
		inject: 0 into: [ :aSum :eachChild | aSum + eachChild constraints treemap weight ].
	anElement constraintsDo: [ :c | 
			c treemap weight: aWeight ].
	^ anElement
]

{ #category : #implementation }
GtNestedRectangleTreeMap >> createLeavesFor: aModelContext [
	^ (leavesCreationBlock value: aModelContext model)
		collect: [ :aLeaf | 
			| aLeafElement aLeafContext |
			aLeafContext := aModelContext copyWithModel: aLeaf.
			aLeafElement := BlElement new
					constraintsDo: [ :c | 
						c horizontal matchParent.
						c vertical matchParent.
						c treemap weight: (leavesSizeBlock value: aLeaf) ];
					border: self newLeafBoder.
			leafElementBlock cull: aLeafElement cull: aLeafContext.
			"(aLeafElement eventDispatcher wantsEventType: BlClickEvent)
				ifFalse: [ 
					aLeafElement
						when: BlClickEvent
						do: [ :e | 
							e target phlow spawnObject: aLeaf ] ]."
			aLeafElement ]
]

{ #category : #api }
GtNestedRectangleTreeMap >> deep: aBlock [
	traversalBlock := aBlock
]

{ #category : #accessing }
GtNestedRectangleTreeMap >> gtViewTreeMapRootsFor: aView [
	<gtView>
	^ aView tree
		title: 'Roots';
		items: [ roots ];
		children: [ :each | traversalBlock value: each ]
]

{ #category : #initialization }
GtNestedRectangleTreeMap >> initialize [
	super initialize.
	leavesSizeBlock := [ :aModel | 10 ].
	traversalBlock := [ :aModel | {  } ].
	leavesCreationBlock := [ :aModel | {  } ].
	containerElementBlock := [ :anElement :aModelContext | 
		anElement border: (BlBorder paint: (Color gray alpha: 0.5 / aModelContext level) width: 2).
		anElement padding: (BlInsets all: 2) ].
	leafElementBlock := [ :anElement :aLeafContext | 
		anElement border: (BlBorder paint: (Color gray alpha: 0.5 / aLeafContext level) width: 2).
		anElement background: (Color blue alpha: 0.2) ].
	layoutIterator := GtNestedRectangleTreeMapContainerLayoutIterator new.
]

{ #category : #api }
GtNestedRectangleTreeMap >> leafElement: aBlock [
	leafElementBlock := aBlock
]

{ #category : #api }
GtNestedRectangleTreeMap >> leaves: aBlock [
	leavesCreationBlock := aBlock
]

{ #category : #api }
GtNestedRectangleTreeMap >> leavesSize: aBlock [
	leavesSizeBlock := aBlock
]

{ #category : #'instance creation' }
GtNestedRectangleTreeMap >> newContainterBorder [
	^ BlBorder paint: (Color gray alpha: 0.5) width: 2
]

{ #category : #'instance creation' }
GtNestedRectangleTreeMap >> newLeafBoder [
	^ BlBorder paint: (Color gray alpha: 0.2) width: 2
]

{ #category : #api }
GtNestedRectangleTreeMap >> root: anObject [
	self roots: { anObject }
]

{ #category : #api }
GtNestedRectangleTreeMap >> roots: aCollection [
	roots := aCollection
]

{ #category : #implementation }
GtNestedRectangleTreeMap >> setup: anElement context: aModelContext withChildren: theChildren andLeaves: theLeaves [
	(theChildren isEmpty and: [ theLeaves isEmpty ])
		ifTrue: [ anElement size: 1 asPoint ]
		ifFalse: [ anElement
				addChildren: theLeaves;
				addChildren: (theChildren collect: [ :aChild | self createFor: (aModelContext copyWithModel: aChild) ]) ]
]

{ #category : #api }
GtNestedRectangleTreeMap >> tree: aNestedTreeNode [
	self roots: { aNestedTreeNode }
]
