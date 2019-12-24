"
I split an area into rectangles that are close to squares (aspect ratio 1) as much as possible.
I use ${method:GtGraphTreemapNode>>#weight}$ node values to split an area into.
I use ${class:GtGraphTreemapSquarifyArea}$ to split area into sub-areas and measure ${class:GtGraphTreemapNode}$ positions and extends.

The algorithm is implemented as described in the paper by Mark Bruls, Kees Huizing, and Jarke J. van Wij, ""Squarified Treemaps"" [*PDF>https://www.win.tue.nl/~vanwijk/stm.pdf*].

!! Example 

The following example shows an area with seven nodes: 
${example:GtGraphTreemapLayoutExamples>>#squarifyWithSevenNodes|codeExpanded=false|previewExpanded=true}$.


"
Class {
	#name : #GtGraphTreemapSquarify,
	#superclass : #GtGraphTreemap,
	#instVars : [
		'extent',
		'firstStep'
	],
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Treemap'
}

{ #category : #enumerating }
GtGraphTreemapSquarify >> allAreas [
	self 
		deprecated: 'Please use #allSteps instead.'
		transformWith: '`@receiver allAreas' -> '`@receiver allSteps'.
	^ firstStep allSteps
]

{ #category : #enumerating }
GtGraphTreemapSquarify >> allSteps [
	^ firstStep allSteps
]

{ #category : #converting }
GtGraphTreemapSquarify >> asAllStepsPreview [
	| aContainer theStepsToElements |
	aContainer := BlElement new 
		constraintsDo: [ :c | 
			c horizontal fitContent.
			c vertical fitContent ];
		layout: (BlGridLayout new columnCount: 3; cellSpacing: 5).
	theStepsToElements := IdentityDictionary new.
	self allSteps do: [ :eachStep |
		| anElement |
		anElement := eachStep asElementWithOccupiedArea.
		theStepsToElements at: eachStep put: anElement.
		aContainer addChild: anElement ].
	theStepsToElements associationsDo: [ :anAssoc |
		| aNextStep aNextStepElement |
		anAssoc key hasNextStep ifTrue: [ 
			aNextStep := anAssoc key nextStep.
			aNextStepElement := theStepsToElements at: aNextStep.
			anAssoc value graph connectTo: aNextStepElement.
			aContainer addChild: (BlLineElement new
				constraintsDo: [ :c | c ignoreByLayout ];
				border: (BlBorder paint: (Color gray alpha: 0.3) width: 2);
					zIndex: -2;
					fromAnchor: (BlElementBottomCenterAnchor referenceElement: anAssoc value relatedTo: aNextStepElement);
					toAnchor: (BlElementTopCenterAnchor referenceElement: aNextStepElement relatedTo: anAssoc value);
					fromHead: (BlArrowheadSimpleArrow new border: (BlBorder builder paint: (Color gray darker alpha: 0.3); width: 5; build))) ]
	].
	^ aContainer
]

{ #category : #accessing }
GtGraphTreemapSquarify >> extent [
	^ self firstArea extent
]

{ #category : #accessing }
GtGraphTreemapSquarify >> extent: aPoint [ 
	self 
		assert: [ aPoint isNotNil ] 
		description: [ 'Extent must be non-nil' ].
	self firstArea extent: aPoint.
]

{ #category : #accessing }
GtGraphTreemapSquarify >> firstArea [
	<return: #GtGraphTreemapSquarifyArea>
	^ firstStep
]

{ #category : #'gt-extension' }
GtGraphTreemapSquarify >> gtAllStepsFor: aView [
	<gtView>
	firstStep ifNil: [ ^ aView empty ].
	^ firstStep gtAllStepsFor: aView
]

{ #category : #'gt-extension' }
GtGraphTreemapSquarify >> gtAllStepsPreviewFor: aView [
	<gtView>
	self nodes ifNil: [ ^ aView empty ].
	^ aView explicit
		title: 'All Steps';
		priority: 1.5;
		stencil: [ self asAllStepsPreview asScalableElement
			margin: (BlInsets all: 10) ]
]

{ #category : #initialization }
GtGraphTreemapSquarify >> initialize [
	super initialize.
	firstStep := GtGraphTreemapSquarifyStep new nodes: self nodes.
]

{ #category : #'seas optimizations' }
GtGraphTreemapSquarify >> updateNode: aNode [
	self firstArea squarifyNode: aNode
]

{ #category : #accessing }
GtGraphTreemapSquarify >> width: aWidth height: anHeight [ 
	self extent: aWidth @ anHeight
]
