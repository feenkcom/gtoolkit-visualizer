"
My subclasses implement treemap algorithms.
Given {{gtClass:BlElement}} children must define a weight using {{gtMethod:GtGraphTreemapLayoutConstraints>>#weight:}}.

Here is an example of a such definition: {{gtExample:GtGraphTreemapLayoutExamples>>#numberElements}}

See my subclasses for more details and examples: {{gtClass:GtGraphTreemapLayout|show=gtSubclassesFor:|expanded=true}}


"
Class {
	#name : #GtGraphTreemapLayout,
	#superclass : #BlLayout,
	#instVars : [
		'sortFunction'
	],
	#category : #'GToolkit-BlocGraph-Layouts-Layouts - Treemap'
}

{ #category : #constraints }
GtGraphTreemapLayout class >> constraints [
	^ GtGraphTreemapLayoutConstraints new
]

{ #category : #factory }
GtGraphTreemapLayout class >> horizontalSlice [
	^ GtGraphTreemapSliceHorizontalLayout new
]

{ #category : #factory }
GtGraphTreemapLayout class >> squarify [
	^ GtGraphTreemapSquarifiedLayout new
]

{ #category : #factory }
GtGraphTreemapLayout class >> verticalSlice [
	^ GtGraphTreemapSliceVerticalLayout new
]

{ #category : #initialization }
GtGraphTreemapLayout >> defaultSortFunction [
	^ [ :theElements | theElements ]
]

{ #category : #'instance creation' }
GtGraphTreemapLayout >> descendentSortFunction [
	^ [ :theElements | theElements sort: [ :a :b | a constraints treemap weight > b constraints treemap weight ] ]
]

{ #category : #initialization }
GtGraphTreemapLayout >> initialize [
	super initialize.
	sortFunction := self defaultSortFunction.
]

{ #category : #layout }
GtGraphTreemapLayout >> layout: anElement in: aRectangle context: aBlElementBoundsUpdateContext [

	anElement children accountedByLayout do: [ :child |
		child applyLayoutIn: child measuredBounds asRectangle context: aBlElementBoundsUpdateContext ].

	self layoutIgnored: anElement context: aBlElementBoundsUpdateContext
]

{ #category : #layout }
GtGraphTreemapLayout >> measure: anElement with: anExtentSpec [
	| aTree aTotalWeight theChildren anAssoc |

	"since the treemap layout does not support unspecified measurement spec (fitContent of the container)
	we can directly compute the size of the parent"
	anElement measuredExtent: (anExtentSpec sizeFor: 0.0@0.0).
	
	"create a tree for the computed extent taking padding into account"	
	aTree := self treeFrom: anElement measuredExtent - anElement padding extent.
	
	"total weight should be a float to avoid Fractions"
	aTotalWeight := 0.0.
	self
		measuredChildren: anElement
		do: [ :eachChild | aTotalWeight := aTotalWeight + eachChild constraints treemap weight ].

	aTotalWeight isZero
		ifTrue: [ aTotalWeight := 1.0 ].
	
	"obtain children"
	theChildren := Array streamContents: [ :aStream |
		self measuredChildren: anElement do: [ :eachChild | aStream nextPut: eachChild ]
	].

	"sort children"
	self sortChildren: theChildren.
	
	"measure children"
	anAssoc := theChildren collect: [ :eachChild | 
		| aNode |

		aNode := GtGraphTreemapNode new.
		aNode weight: (eachChild constraints treemap weight / aTotalWeight).
		aNode value: eachChild constraints treemap weight.
		aNode totalValue: aTotalWeight.
		aTree addNode: aNode.	
		eachChild -> aNode.
	].

	"the main measurement pass"
	anAssoc do: [ :eachAssoc |
		eachAssoc key measuredBounds
			position: eachAssoc value position asFloatPoint + anElement padding topLeft.

		self
			measureChild: eachAssoc key
			parentSpec: anExtentSpec
			"we pass how much space is already used inside of the parent (the space a child can not occupy)"
			widthUsed: anElement measuredWidth - (eachAssoc value extent x asFloat - eachAssoc key margin width)
			heightUsed: anElement measuredHeight - (eachAssoc value extent y asFloat - eachAssoc key margin height)
	].
	
	self measureIgnored: anElement with: anExtentSpec
]

{ #category : #sorting }
GtGraphTreemapLayout >> sortChildren: theChildren [
	sortFunction value: theChildren
]

{ #category : #'instance creation' }
GtGraphTreemapLayout >> treeFrom: anExtent [
	<return: #GtGraphTreemap>
	^ self subclassResponsibility
]
