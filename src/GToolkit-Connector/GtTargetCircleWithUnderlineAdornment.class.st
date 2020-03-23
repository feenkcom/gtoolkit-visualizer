Class {
	#name : #GtTargetCircleWithUnderlineAdornment,
	#superclass : #BrTextAdornmentAttribute,
	#instVars : [
		'identifier',
		'circleSize',
		'text',
		'start',
		'stop',
		'coder',
		'node'
	],
	#classVars : [
		'underlines'
	],
	#category : #'GToolkit-Connector'
}

{ #category : #accessing }
GtTargetCircleWithUnderlineAdornment >> affect: aTBrTextEditorTextualPiece in: anEditorElement [
	| circleElement rule underlineRules |
	
	circleElement := BrButton new
		geometry: BlEllipse new;
		size: circleSize@circleSize;
		look: (GtExplainerTargetLook new explanationModel: identifier).
	
	rule := GtASTNodeHighlighterStylerRule new
		nodeClassName: node className asSymbol;
		styleBlock: [ :aNode :aText |
			(aText
				from: start
				to: stop)
			attributes: {BlTextHighlightAttribute new paint: BrGlamorousColors textHighlightColor}].
		
	circleElement addEventHandlerOn: GtExplanationLinkConnectedEvent
		do: [ :anEvent |
			anEvent consumed: true.
			underlines add: rule.
			underlineRules := GtCompositeHighlighter forHighlighters: underlines.
			coder highlighter: underlineRules ].
	circleElement addEventHandlerOn: GtExplanationLinkDisconnectedEvent 
		do: [ :anEvent |
			anEvent consumed: true.
			coder removeAttributeNamed: #highlighter.
			coder addOns removeStylerOfType: GtASTNodeHighlighterStylerRule.
			coder updateAddOns.
			coder styleText ].
	
	^ circleElement .
]

{ #category : #accessing }
GtTargetCircleWithUnderlineAdornment >> coder: aCoder [
	coder := aCoder.
]

{ #category : #accessing }
GtTargetCircleWithUnderlineAdornment >> identifier [
	^ identifier.
]

{ #category : #accessing }
GtTargetCircleWithUnderlineAdornment >> identifier: anIdentifier [
	identifier := anIdentifier.
]

{ #category : #initialization }
GtTargetCircleWithUnderlineAdornment >> initialize [
	super initialize.
	self beAppend.
	
	circleSize := 3.
	start := stop := 1.
	text := '' asRopedText.
	underlines := OrderedCollection new.
]

{ #category : #accessing }
GtTargetCircleWithUnderlineAdornment >> node: aNode [
	node := aNode.
]

{ #category : #accessing }
GtTargetCircleWithUnderlineAdornment >> size [
	^ circleSize.
]

{ #category : #accessing }
GtTargetCircleWithUnderlineAdornment >> size: aSize [
	circleSize := aSize.
]

{ #category : #accessing }
GtTargetCircleWithUnderlineAdornment >> start: aStartPoint [
	start := aStartPoint.
]

{ #category : #accessing }
GtTargetCircleWithUnderlineAdornment >> stop: aStopPoint [
	stop := aStopPoint.
]
