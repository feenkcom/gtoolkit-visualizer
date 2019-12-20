Class {
	#name : #GtGraphTreemapLayout,
	#superclass : #BlLayout,
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Treemap'
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

{ #category : #layout }
GtGraphTreemapLayout >> layout: anElement in: aRectangle [

	anElement children accountedByLayout do: [ :child |
		child applyLayoutIn: child measuredBounds asRectangle ].

	self layoutIgnored: anElement
]

{ #category : #layout }
GtGraphTreemapLayout >> measure: anElement with: anExtentSpec [
	| aTree aTotalWeight theChildren anAssoc |

	"since the treemap layout does not support unspecified measurement spec (fitContent of the container)
	we can directly compute the size of the parent"
	anElement measuredExtent: (anExtentSpec sizeFor: 0@0).
	
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

	"TODO: sort children"
	
	"Measure children"
	anAssoc := theChildren collect: [ :eachChild | 
		| aNode |

		aNode := GtGraphTreemapNode new.
		aNode weight: (eachChild constraints treemap weight / aTotalWeight).
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
			widthUsed: anElement measuredWidth - (eachAssoc value extent x asFloat "- eachChild margin width")
			heightUsed: anElement measuredHeight - (eachAssoc value extent y asFloat "- eachChild margin height")
	].
	
	self measureIgnored: anElement with: anExtentSpec
]

{ #category : #'instance creation' }
GtGraphTreemapLayout >> treeFrom: anExtent [
	<return: #GtGraphTreemap>
	^ self subclassResponsibility
]
