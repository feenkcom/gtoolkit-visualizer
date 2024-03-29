"
A ROGridLayout places elements as a grid.

Instance Variables
	gapSize:		<SmallInteger>
	lineItemsCountBlock:		<BlockContext>

gapSize
	- number of pixels between each elements, horizontally and vertically

lineItemsCountBlock
	- tells the amount of item per line should be used


"
Class {
	#name : #GtGraphGridLayout,
	#superclass : #GtGraphAbstractGridLayout,
	#category : 'GToolkit-BlocGraph-Layouts-Layouts'
}

{ #category : #hook }
GtGraphGridLayout >> doExecute: elements with: anExtentSpec [
	| pointer lineItemCount lineItemSize maxLastLineHeight originalGapLeft originalGapTop |
	originalGapLeft := 0.
	originalGapTop := 0.
	
	pointer := originalGapLeft @ originalGapTop.
	lineItemSize := self lineItemsCountBlock cull: elements.
	lineItemCount := 0.
	maxLastLineHeight := 0.

	elements
		do: [ :element | 
			translator translateTopLeftOf: element to: pointer.
			pointer := (pointer x + element width + self gapSize) @ pointer y.
			lineItemCount := lineItemCount + 1.
			maxLastLineHeight := maxLastLineHeight max: element height.
			lineItemCount >= lineItemSize
				ifTrue: [ 
					pointer := originalGapLeft @ (pointer y + (self gapSize) + maxLastLineHeight).
					
					maxLastLineHeight := 0.
					lineItemCount := 0 ].
			self step ].

]
