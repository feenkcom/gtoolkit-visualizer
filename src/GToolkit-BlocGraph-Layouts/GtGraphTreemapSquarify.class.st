"
I split an area into rectangles that are close to squares (aspect ratio 1) as much as possible.
I use {{gtMethod:GtGraphTreemapNode>>#weight}} node values to split an area into.
I use {{gtClass:GtGraphTreemapSquarifyStep}} to split area into sub-areas and measure {{gtClass:GtGraphTreemapNode}} positions and extends.

The algorithm is implemented as described in the paper by Mark Bruls, Kees Huizing, and Jarke J. van Wij, ""Squarified Treemaps"" ([PDF](https://www.win.tue.nl/~vanwijk/stm.pdf)).
1. # Algorithm Explanation

This is an adapted extract from the paper Squarified Treemaps mentioned above. Suppose we have a rectangle with width {{gtExample:GtGraphTreemapLayoutExamples>>#squarifyWithSevenNodes|label=#width}} and height {{gtExample:GtGraphTreemapLayoutExamples>>#squarifyWithSevenNodes|label=#height}}, and furthermore suppose that this rectangle must be subdivided in seven rectangles with areas {{gtExample:GtGraphTreemapLayoutExamples>>#squarifyWithSevenNodes|label=#nodeValues}}. The area will be subdivided as follows:
{{gtExample:GtGraphTreemapLayoutExamples>>#squarifyWithSevenNodes|noCode|codeExpanded=false|previewExpanded=true|previewShow=#gtPreviewFor:}}

The  of our algorithm is to split the initial rectangle. We choose for a horizontal subdivision, because the original rectangle is wider than high. We next fill the left half. First we add a single rectangle. The aspect ratio of this first rectangle is {{gtExample:GtGraphTreemapLayoutExamples>>#squarifyWithSevenNodesFirstStep|label=#worstValueRounded}}.

{{gtExample:GtGraphTreemapLayoutExamples>>#squarifyWithSevenNodesFirstStep|previewExpanded=true|noCode}}

Next we add a second rectangle, above the first. The worst aspect ratio improves to {{gtExample:GtGraphTreemapLayoutExamples>>#squarifyWithSevenNodesSecondStep|label=#worstValueRounded}}.
{{gtExample:GtGraphTreemapLayoutExamples>>#squarifyWithSevenNodesSecondStep|previewExpanded=true|noCode}}

However, if we add the next (area 4) above these original rectangles, the aspect ratio of this rectangle is {{gtExample:GtGraphTreemapLayoutExamples>>#squarifyWithSevenNodesThirdStep|label=#worstValueRounded}}.
{{gtExample:GtGraphTreemapLayoutExamples>>#squarifyWithSevenNodesThirdStep|previewExpanded=true|noCode}}

Therefore, we decide that we have reached an optimum for the left half in step two, and start processing the right half. The initial subdivision we choose here is vertical, because the rectangle is higher than wider. In step 4 we add the rectangle with area 4:
{{gtExample:GtGraphTreemapLayoutExamples>>#squarifyWithSevenNodesFourthStep|previewExpanded=true|noCode}}

In the next step, we add area 3. The worst aspect ratio decreases from {{gtExample:GtGraphTreemapLayoutExamples>>#squarifyWithSevenNodesFourthStep|label=#worstValueRounded}} to {{gtExample:GtGraphTreemapLayoutExamples>>#squarifyWithSevenNodesFifthStep|label=#worstValueRounded}}: 
{{gtExample:GtGraphTreemapLayoutExamples>>#squarifyWithSevenNodesFifthStep|previewExpanded=true|noCode}}

Addition of the next (area 2) however does not improve the result as the worst aspect ratio increases from {{gtExample:GtGraphTreemapLayoutExamples>>#squarifyWithSevenNodesFifthStep|label=#worstValueRounded}} to {{gtExample:GtGraphTreemapLayoutExamples>>#squarifyWithSevenNodesSixthStep|label=#worstValueRounded}}:
{{gtExample:GtGraphTreemapLayoutExamples>>#squarifyWithSevenNodesSixthStep|previewExpanded=true|noCode}}

So we reject the previous step and start to fill the right top partition:
{{gtExample:GtGraphTreemapLayoutExamples>>#squarifyWithSevenNodesSeventhStep|previewExpanded=true|noCode}}
 
These steps are repeated until all rectangles have been processed. The final result is the following:
{{gtExample:GtGraphTreemapLayoutExamples>>#squarifyWithSevenNodes|noCode|codeExpanded=false|previewExpanded=true}}.

An optimal result can not be guaranteed, and counterexamples can be set up. The order in which the rectangles are processed is important. We found that a decreasing order usually gives the best results. The initially large rectangle is then filled in first with the larger subrectangles.


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
	| columnCount currentColumn aContainer theStepsToElements |
	columnCount := firstStep largestRectangleChain.

	aContainer := BlElement new
			constraintsDo: [ :c | 
				c horizontal fitContent.
				c vertical fitContent ];
			layout: (BlGridLayout new
					columnCount: columnCount;
					cellSpacing: 5).
	theStepsToElements := IdentityDictionary new.

	currentColumn := 0.
	self allSteps
		do: [ :eachStep | 
			| anElement |
			currentColumn := currentColumn + 1.
			anElement := eachStep asElementWithOccupiedArea.
			anElement margin: (BlInsets all: 20).
			theStepsToElements at: eachStep put: anElement.
			aContainer addChild: anElement.

			eachStep isRejectedStep
				ifTrue: [ columnCount - currentColumn
						timesRepeat: [ aContainer addChild: (BlElement new size: 1 @ 1) ].
					currentColumn := 0 ] ].

	theStepsToElements
		keysAndValuesDo: [ :eachStep :eachStepElement | 
			| aNextStep aNextStepElement |
			eachStep hasNextStep
				ifTrue: [ aNextStep := eachStep nextStep.
					aNextStepElement := theStepsToElements at: aNextStep.
					eachStepElement graph connectTo: aNextStepElement.
					aContainer
						addChild: (BlLineElement new
								constraintsDo: [ :c | c ignoreByLayout ];
								border: (BlBorder paint: (Color gray alpha: 0.3) width: 2);
								zIndex: -2;
								fromAnchor: (BlNearestPositionBoundsAnchor nearestTo: aNextStepElement from: eachStepElement);
								toAnchor: (BlNearestPositionBoundsAnchor nearestTo: eachStepElement from: aNextStepElement);
								toHead: (BlArrowheadSimpleArrow new
										border: (BlBorder builder
												paint: (Color gray darker alpha: 0.3);
												width: 5;
												build))) ].

			(eachStep isRejectedStep not and: [ eachStep rejectedStep isDefinedStep ])
				ifTrue: [ aNextStep := eachStep rejectedStep.
					aNextStepElement := theStepsToElements at: aNextStep.
					eachStepElement graph connectTo: aNextStepElement.
					aContainer
						addChild: (BlLineElement new
								constraintsDo: [ :c | c ignoreByLayout ];
								border: (BlBorder paint: (Color gray alpha: 0.3) width: 2);
								zIndex: -2;
								fromAnchor: (BlNearestPositionBoundsAnchor nearestTo: aNextStepElement from: eachStepElement);
								toAnchor: (BlNearestPositionBoundsAnchor nearestTo: eachStepElement from: aNextStepElement);
								toHead: (BlArrowheadSimpleArrow new
										border: (BlBorder builder
												paint: (Color gray darker alpha: 0.3);
												width: 5;
												build))) ] ].
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
	<return: #GtGraphTreemapSquarifyStep>
	^ firstStep
]

{ #category : #'gt-extension' }
GtGraphTreemapSquarify >> gtAllStepsFor: aView [
	<gtView>
	firstStep ifNil: [ ^ aView empty ].
	^ (firstStep gtAllStepsFor: aView)
		title: 'Steps list'
]

{ #category : #'gt-extension' }
GtGraphTreemapSquarify >> gtAllStepsMondrianPreviewFor: aView [
	<gtView>
	self nodes ifNil: [ ^ aView empty ].
	^ aView mondrian
		title: 'Mondrian';
		painting: [ :aMondrian |
			aMondrian nodes
				shape: [ :eachStep | eachStep asElementWithOccupiedArea
					margin: (BlInsets all: 10) ];
				with: self allSteps.
			aMondrian edges
				fromCenterBottom;
				toCenterTop;
				connectFrom: #yourself
				toAll: [ :eachStep | { eachStep rejectedStep. eachStep nextStep } ].
			aMondrian layout horizontalTree
		]
]

{ #category : #'gt-extension' }
GtGraphTreemapSquarify >> gtAllStepsPreviewFor: aView [
	<gtView>
	self nodes ifNil: [ ^ aView empty ].
	^ aView explicit
		title: 'Steps figure';
		priority: 1.5;
		stencil: [ self asAllStepsPreview asScalableElement
			margin: (BlInsets all: 10) ]
]

{ #category : #accessing }
GtGraphTreemapSquarify >> height [
	^ self extent y
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
GtGraphTreemapSquarify >> width [
	^ self extent x
]

{ #category : #accessing }
GtGraphTreemapSquarify >> width: aWidth height: anHeight [ 
	self extent: aWidth @ anHeight
]
