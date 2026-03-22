"
A ROAbstractGridLayout is xxxxxxxxx.

Instance Variables
	gapSize:		<Object>
	lineItemsCountBlock:		<Object>

gapSize
	- xxxxx

lineItemsCountBlock
	- xxxxx


"
Class {
	#name : #GtGraphAbstractGridLayout,
	#superclass : #GtGraphLayout,
	#instVars : [
		'gapSize',
		'lineItemsCountBlock'
	],
	#category : #'GToolkit-BlocGraph-Layouts-Layouts'
}

{ #category : #public }
GtGraphAbstractGridLayout class >> isAbstract [
	^ self name = #GtGraphAbstractGridLayout
]

{ #category : #'instance creation' }
GtGraphAbstractGridLayout class >> withGap: anInteger [ 

	^ self new 
			gapSize: anInteger; 
			yourself
]

{ #category : #'instance creation' }
GtGraphAbstractGridLayout class >> withGap: anInteger withLineItemsCount: aBlock [
	
	^self new
		gapSize: anInteger;
		lineItemsCount: aBlock;
		yourself
]

{ #category : #'instance creation' }
GtGraphAbstractGridLayout class >> withLineItemsCount: aBlock [
	
	^self new
		lineItemsCount: aBlock;
		yourself
]

{ #category : #'initialize-release' }
GtGraphAbstractGridLayout >> defaultGapSize [
	^ 5
]

{ #category : #accessing }
GtGraphAbstractGridLayout >> defaultLineItemsCount [
	
	^ [ :elements | 
			| height width |
			(elements size < 3 
				ifTrue: [ (elements size max: 1) @ 1 ]
				ifFalse: 
					[ height := (elements size * 0.618034) sqrt ceiling truncated.
					width := (elements size / height) ceiling truncated.
					width @ height ]) x ]
]

{ #category : #accessing }
GtGraphAbstractGridLayout >> gapSize [
	
	^ gapSize
]

{ #category : #accessing }
GtGraphAbstractGridLayout >> gapSize: anInteger [
	gapSize := anInteger
]

{ #category : #'initialize-release' }
GtGraphAbstractGridLayout >> initialize [
	super initialize.
	gapSize := self defaultGapSize.
	lineItemsCountBlock := self defaultLineItemsCount.
]

{ #category : #accessing }
GtGraphAbstractGridLayout >> lineItemsCount: aNumberOrASymbolOrABlock [
	"The argument will be evaluated (using rtValue:) against the set of elements to perform the layout on. The result of this evaluation has to be a number, which indicates the number of elements per line"
	lineItemsCountBlock := aNumberOrASymbolOrABlock
]

{ #category : #accessing }
GtGraphAbstractGridLayout >> lineItemsCountBlock [
	
	^ lineItemsCountBlock
]
