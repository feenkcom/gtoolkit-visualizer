Class {
	#name : #GtTargetCircleWithUnderlineAdornment,
	#superclass : #BrTextAdornmentAttribute,
	#instVars : [
		'identifier',
		'circleSize',
		'text',
		'start',
		'stop'
	],
	#category : #'GToolkit-Connector'
}

{ #category : #accessing }
GtTargetCircleWithUnderlineAdornment >> affect: aTBrTextEditorTextualPiece in: anEditorElement [
	| circleElement |
	
	circleElement := BrButton new
		geometry: BlEllipse new;
		size: circleSize@circleSize;
		look: (GtExplainerTargetLook new explanationModel: identifier).
		
	circleElement addEventHandlerOn: GtExplanationLinkConnectedEvent
		do: [ :anEvent |
			anEvent consumed: true.
			(self text)
				attributes: {
					BlTextUnderlineAttribute new beNotOverwritableByStyler; paint: BrGlamorousColors textHighlightColor }].
	circleElement addEventHandlerOn: GtExplanationLinkDisconnectedEvent 
		do: [ :anEvent |
			anEvent consumed: true.
			(self text)
				removeAttribute: BlTextUnderlineAttribute ].
	
	^ circleElement .
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
	text := '' asRopedText.
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

{ #category : #accessing }
GtTargetCircleWithUnderlineAdornment >> text [
	^ text.
]

{ #category : #accessing }
GtTargetCircleWithUnderlineAdornment >> text: aTextPiece [
	text := aTextPiece.
]
