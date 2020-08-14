Class {
	#name : #GtTargetCircleWithUnderlineAdornment,
	#superclass : #BrTextAdornmentAttribute,
	#instVars : [
		'identifier',
		'circleSize',
		'start',
		'stop',
		'coder',
		'node'
	],
	#classVars : [
		'highlights'
	],
	#category : #'GToolkit-Connector-Explainer'
}

{ #category : #accessing }
GtTargetCircleWithUnderlineAdornment >> affect: aTBrTextEditorTextualPiece in: anEditorElement [
	| circleElement underlineRules |
	
	circleElement := BrButton new
		geometry: BlEllipse new;
		size: circleSize@circleSize;
		look: (GtExplainerTargetLook new explanationModel: identifier).
		
	circleElement addEventHandlerOn: GtExplanationLinkConnectedEvent
		do: [ :anEvent |
			anEvent consumed: true.
			highlights add: self stylerRule.
			underlineRules := GtCompositeHighlighter forHighlighters: highlights.
			coder highlighter: underlineRules ].
	circleElement addEventHandlerOn: GtExplanationLinkDisconnectedEvent 
		do: [ :anEvent |
			anEvent consumed: true.
			coder removeAttributeNamed: #highlighter.
			coder addOns removeStylerOfType: GtASTNodeHighlighterStylerRule.
			coder requestUpdateAddOns.
			coder requestStyleSourceText ].
	
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
	highlights := OrderedCollection new.
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

{ #category : #'as yet unclassified' }
GtTargetCircleWithUnderlineAdornment >> stylerRule [
	^ (node isKindOf: RBMessageNode)
		ifTrue:
			[ 	GtASTNodeHighlighterStylerRule new
					nodeClassName: node className asSymbol;
					styleBlock: [ :aNode :aText |
					node keywordsIntervals do: [ :each |	
						(aText
							from: each first
							to: each last)
							attributes: {BlTextHighlightAttribute new paint: BrGlamorousColors textHighlightColor}].
					(aText
						from: node keywordsIntervals first first
						to: node keywordsIntervals last last)
						attributes: {BlTextUnderlineAttribute new paint: BrGlamorousColors textHighlightColor}] ]
		ifFalse:
			[ 	GtASTNodeHighlighterStylerRule new
					nodeClassName: node className asSymbol;
					styleBlock: [ :aNode :aText |
					(aText
						from: start
						to: stop)
						attributes: {BlTextHighlightAttribute new paint: BrGlamorousColors textHighlightColor}]  ].
]
