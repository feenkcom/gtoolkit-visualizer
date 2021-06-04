"
I am useful to exemplify rectangles witch may represent {{gtClass:BlBounds}} of an {{gtClass:BlElement}}.

1. # Examples


I can draw a rectangle with margin: 
{{gtExample:GtGraphTreemapLayoutExamples>>#rectangleWithMarginUtility|codeExpanded=false|previewExpanded=true}}

I can draw a rectangle with bounds values:  
{{gtExample:GtGraphTreemapLayoutExamples>>#rectangleWithMarginAndInformationUtility|codeExpanded=false|previewExpanded=true}}


"
Class {
	#name : #GtGraphUtilities,
	#superclass : #Object,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'GToolkit-BlocGraph-Layouts-Utilities'
}

{ #category : #cleanup }
GtGraphUtilities class >> cleanUp [
	self resetUniqueInstance
]

{ #category : #accessing }
GtGraphUtilities class >> default [
	^ self uniqueInstance
]

{ #category : #cleanup }
GtGraphUtilities class >> resetUniqueInstance [
	uniqueInstance := nil
]

{ #category : #accessing }
GtGraphUtilities class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #'factory - rectangle' }
GtGraphUtilities >> informationForRectangle: aContainer bounds: aBounds [
	| aFontSize aTopLeftLabel aTopRightLabel aBottomRightLabel aBottomLeftLabel |
	
	aFontSize := aBounds extent min / 20.0.

	aTopLeftLabel := BlTextElement new text: (aBounds topLeft rounded asString asRopedText glamorousRegularFont fontSize: aFontSize).
	aTopLeftLabel constraintsDo: [ :c |
		c padding: (BlInsets all: aFontSize / 2.0).
		c ignoreByLayout.
		c ignored horizontal alignLeft.
		c ignored vertical alignTop ].
	(aContainer childNamed: #rectangle) addChild: aTopLeftLabel.
	
	aTopRightLabel := BlTextElement new text: (aBounds topRight rounded asString asRopedText glamorousRegularFont fontSize: aFontSize).
	aTopRightLabel constraintsDo: [ :c |
		c padding: (BlInsets all: aFontSize / 2.0).
		c ignoreByLayout.
		c ignored horizontal alignRight.
		c ignored vertical alignTop ].
	(aContainer childNamed: #rectangle) addChild: aTopRightLabel.
	
	aBottomRightLabel := BlTextElement new text: (aBounds bottomRight rounded asString asRopedText glamorousRegularFont fontSize: aFontSize).
	aBottomRightLabel constraintsDo: [ :c |
		c padding: (BlInsets all: aFontSize / 2.0).
		c ignoreByLayout.
		c ignored horizontal alignRight.
		c ignored vertical alignBottom ].
	(aContainer childNamed: #rectangle) addChild: aBottomRightLabel.
	
	aBottomLeftLabel := BlTextElement new text: (aBounds bottomLeft rounded asString asRopedText glamorousRegularFont fontSize: aFontSize).
	aBottomLeftLabel constraintsDo: [ :c |
		c padding: (BlInsets all: aFontSize / 2.0).
		c ignoreByLayout.
		c ignored horizontal alignLeft.
		c ignored vertical alignBottom ].
	(aContainer childNamed: #rectangle) addChild: aBottomLeftLabel.
	
	^ aContainer
]

{ #category : #'printing - numberss' }
GtGraphUtilities >> printNumber: aNumber [
	"print a number as float or as an original number, plus float"
	<return: #String>
	aNumber isFloat ifTrue: [ ^ aNumber printString ].
	^ aNumber printString, ' = ', (aNumber asFloat round: 4) printString
]

{ #category : #'factory - rectangle' }
GtGraphUtilities >> rectangleOn: anObject extent: anExtent [
	<return: #BlElement>
	^ self rectangleOn: anObject extent: anExtent margin: (BlInsets all: 0)
]

{ #category : #'factory - rectangle' }
GtGraphUtilities >> rectangleOn: anObject extent: anExtent margin: aMargin [
	<return: #BlElement>
	| aContainer aMarginRectangle anActualRectangle aBorderWidth aFloatExtent aFloatExtentAndMargin |

	aBorderWidth := (anExtent x / 100.0) min: 0.5.
	aFloatExtent := anExtent asFloatPoint.
	aFloatExtentAndMargin := aFloatExtent + aMargin extent asFloatPoint.

	aContainer := BlElement new.
	aContainer size: aFloatExtentAndMargin.

	aMarginRectangle := BlElement new.
	aMarginRectangle size: aFloatExtentAndMargin.
	aMarginRectangle border: (BlBorder builder dashedSmall paint: (Color black alpha: 0.2); width: aBorderWidth; build).
	aMarginRectangle background: (Color white alpha: 0.4).

	anActualRectangle := BlElement new.
	anActualRectangle size: aFloatExtent.
	anActualRectangle relocate: aMargin topLeft asFloatPoint.
	anActualRectangle background: (Color white alpha: 0.8).
	anActualRectangle border: (BlBorder paint: Color black width: aBorderWidth).
	anActualRectangle when: BlClickEvent do: [ :anEvent |
		anEvent consumed: true.
		anEvent currentTarget phlow spawnObject: anObject ].

	aContainer addChild: aMarginRectangle as: #margin.
	aContainer addChild: anActualRectangle as: #rectangle.
	
	^ aContainer
]
