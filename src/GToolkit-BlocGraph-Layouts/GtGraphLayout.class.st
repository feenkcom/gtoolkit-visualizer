"
I am an abstract graph layout. My subclasses define the concrete algorithm.
"
Class {
	#name : #GtGraphLayout,
	#superclass : #BlFitLayout,
	#traits : 'TGtGraphLayoutUtils',
	#classTraits : 'TGtGraphLayoutUtils classTrait',
	#instVars : [
		'translator'
	],
	#category : #'GToolkit-BlocGraph-Layouts-Basic'
}

{ #category : #constraints }
GtGraphLayout class >> constraints [
	^ GtGraphConstraints new
]

{ #category : #hook }
GtGraphLayout >> applyOn: elements with: anExtentSpec [
	"Return quickly if there is nothing to do"
	(elements isEmpty)
		ifTrue: [ ^ self ].
	self executeOnElements: elements with: anExtentSpec
]

{ #category : #hook }
GtGraphLayout >> doExecute: elements with: anExtentSpec [
	"Performs the layout"

	self subclassResponsibility
]

{ #category : #hook }
GtGraphLayout >> doInitialize: elements with: anExtentSpec [
	"Method executed before beginning the layout. Useful when the graph to be ordered need to be prepared"
]

{ #category : #hook }
GtGraphLayout >> doPost: elements with: anExtentSpec [
	"Method executed after performing the layout"
]

{ #category : #hook }
GtGraphLayout >> executeOnElements: elements with: anExtentSpec [
	"Execute the layout, myself, on the elements"

	self doInitialize: elements with: anExtentSpec.
	self doExecute: elements with: anExtentSpec.
	self doPost: elements with: anExtentSpec
]

{ #category : #geometry }
GtGraphLayout >> groupBounds: aCollectionOfElements [
	"Return encompassing bounds of a collection of elements"

	^ (aCollectionOfElements 
		ifEmpty: [ (0 @ 0) corner: (0 @ 0) ]
		ifNotEmpty: [ Rectangle merging: (aCollectionOfElements collect: [ :anElement | anElement measuredBounds asRectangle ]) ])
]

{ #category : #initialization }
GtGraphLayout >> initialize [
	super initialize.

	translator := GtGraphLayoutTranslator default
]

{ #category : #layout }
GtGraphLayout >> measureChildrenPositions: aParentLayoutNode [
	self applyOn: aParentLayoutNode withGraphEdges children with: aParentLayoutNode extentSpec.

	aParentLayoutNode children
		roundPositions;
		normalizePositions
]

{ #category : #hook }
GtGraphLayout >> on: elements [
	self shouldNotImplement
]

{ #category : #hook }
GtGraphLayout >> step [
]

{ #category : #accessing }
GtGraphLayout >> translator [
	^ translator
]

{ #category : #accessing }
GtGraphLayout >> translator: t [
	translator := t
]
