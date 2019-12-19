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
		'leafEllipseBlock',
		'containerBlock',
		'layoutIterator'
	],
	#category : #'GToolkit-TreeMap'
}

{ #category : #api }
GtNestedRectangleTreeMap >> containerEllipse: aBlock [
	containerBlock := aBlock
]

{ #category : #implementation }
GtNestedRectangleTreeMap >> create [
	<return: #BlElement>
	^ roots size = 1 
		ifTrue: [ self createFor: roots anyOne ]
		ifFalse: [
			| element|
			element := self createContainerFor: roots.
			self 
				setup: element 
				withChildren: roots 
				andLeaves: {}.
			element ]
]

{ #category : #implementation }
GtNestedRectangleTreeMap >> createContainerFor: anObject [
	| containerElement |
	containerElement := BlElement new
		layout: layoutIterator nextLayout;
		geometry: BlRectangle new;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent.
			c treemap weight: (leavesSizeBlock value: anObject) ];
		when: BlClickEvent
			do: [ :e | 
			e target phlow spawnObject: anObject.
			e consumed: true ];
		border: (BlBorder paint: (Color gray alpha: 0.5) width: 2).
	containerBlock cull: containerElement cull: anObject.
	^ containerElement
]

{ #category : #implementation }
GtNestedRectangleTreeMap >> createFor: anObject [
	| element leaves children |
	element := self createContainerFor: anObject.
	leaves := self createLeavesFor: anObject.
	children := traversalBlock value: anObject.
	self setup: element withChildren: children andLeaves: leaves.
	^ element
]

{ #category : #implementation }
GtNestedRectangleTreeMap >> createLeavesFor: anObject [
	^ (leavesCreationBlock value: anObject) collect: [ :leaf |
		| leafElement |
		leafElement := BlElement new
			geometry: BlRectangle new;
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent.
				c treemap weight: (leavesSizeBlock value: leaf) ];
			when: BlClickEvent do: [ :e | e target phlow spawnObject: leaf. e consumed: true ];
			background: (Color red darker alpha: 0.7);
			border: (BlBorder paint: (Color gray alpha: 0.2)).
		leafEllipseBlock cull: leafElement cull: leaf.
		leafElement ]
]

{ #category : #api }
GtNestedRectangleTreeMap >> deep: aBlock [
	traversalBlock := aBlock
]

{ #category : #initialization }
GtNestedRectangleTreeMap >> initialize [
	super initialize.
	leavesSizeBlock := [ :x | 10 ].
	traversalBlock := [ :x | {  } ].
	leavesCreationBlock := [ :x | {  } ].
	containerBlock := [ :ellipse | ellipse ].
	leafEllipseBlock := [ :ellipse | ellipse ].
	layoutIterator := GtNestedRectangleTreeMapContainerLayoutIterator new.
]

{ #category : #api }
GtNestedRectangleTreeMap >> leafEllipse: aBlock [
	leafEllipseBlock := aBlock
]

{ #category : #api }
GtNestedRectangleTreeMap >> leaves: aBlock [
	leavesCreationBlock := aBlock
]

{ #category : #api }
GtNestedRectangleTreeMap >> leavesSize: aBlock [
	leavesSizeBlock := aBlock
]

{ #category : #api }
GtNestedRectangleTreeMap >> roots: aCollection [
	roots := aCollection
]

{ #category : #implementation }
GtNestedRectangleTreeMap >> setup: element withChildren: children andLeaves: leaves [
	(children isEmpty and: [ leaves isEmpty ])
		ifTrue: [ element size: 1 asPoint ]
		ifFalse: [ element
				addChildren: leaves;
				addChildren: (children collect: [ :aChild | self createFor: aChild ]) ]
]
