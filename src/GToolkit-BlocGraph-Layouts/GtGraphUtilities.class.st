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

{ #category : #'as yet unclassified' }
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
