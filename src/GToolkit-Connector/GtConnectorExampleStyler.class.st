Class {
	#name : #GtConnectorExampleStyler,
	#superclass : #BrRBTextStyler,
	#instVars : [
		'exampleAction',
		'previousLinks'
	],
	#category : 'GToolkit-Connector'
}

{ #category : #factory }
GtConnectorExampleStyler class >> editorElementOnSourceCode: aString inClass: aClass [
	| styler editor editorElement text |
	
	text := aString asRopedText.
	styler := self new.
	styler classOrMetaClass: aClass.
	text attributes: { BrFontGenericFamilyAttribute monospace beNotOverwritableByStyler}.
	editor := BrTextEditor new.
	editor styler: styler.
	editor text: text.
	
	editorElement := BrEditorElement new.
	editorElement editor: editor.
	
	editorElement
		constraintsDo: [ :c | 
			c textFlow pushLine.
			c horizontal matchParent.
			c vertical fitContent ];
		background: Color white;
		border: (BlBorder paint: Color veryLightGray width: 1).
	^ editorElement
]

{ #category : #accessing }
GtConnectorExampleStyler >> exampleAction [
	^ exampleAction
]

{ #category : #accessing }
GtConnectorExampleStyler >> exampleAction: anObject [
	exampleAction := anObject
]

{ #category : #private }
GtConnectorExampleStyler >> extraStyle: aText ast: ast [
	| selfSendsExamples newLinks createdLinks deletedLinks |
	
	newLinks := OrderedCollection new.
	
	selfSendsExamples := self findExampleSendsIn: ast.
	selfSendsExamples do: [ :each | 
		| buttonAttribute targetExampleMethod aLink |
		
		targetExampleMethod := ast methodNode methodClass lookupSelector: each selector.
		
		aLink := GtConnectorLink
			source: ast method
			target: targetExampleMethod.
		newLinks add: aLink.

		buttonAttribute := GtConnectorTextButtonAttribute link: aLink.
		buttonAttribute actionBlock: [ :anEvent | exampleAction valueWithEnoughArguments: { targetExampleMethod . each . anEvent currentTarget } ].
		aText 
			attributes: { buttonAttribute } 
			from: each stop - 1
			to: each stop.
			
		self fireEvent: (GtConnectorButtonAttributeCreatedEvent new attribute: buttonAttribute) ].
	
	createdLinks := newLinks difference: previousLinks.
	deletedLinks := previousLinks difference: newLinks.
	previousLinks := newLinks.
	
	deletedLinks do: [ :aLink | self fireEvent: (GtConnectorLinkDeletedEvent link: aLink) ].
	createdLinks do: [ :aLink | self fireEvent: (GtConnectorLinkCreatedEvent link: aLink) ].
]

{ #category : #private }
GtConnectorExampleStyler >> findExampleSendsIn: anAST [
	^ anAST allChildren select: [ :each | 
		each isMessage and: [ 
			each isSelfSend and: [ 
				each isUnary and: [
					(anAST methodNode methodClass canPerform: each selector) and: [ 
						(anAST methodNode methodClass lookupSelector: each selector) isGTExampleMethod ] ] ] ] ]
]

{ #category : #initialization }
GtConnectorExampleStyler >> initialize [
	super initialize.

	previousLinks := OrderedCollection new
]

{ #category : #accessing }
GtConnectorExampleStyler >> links [
	<return: #SequenceableCollection of: #GtConnectorLink>

	^ previousLinks
]
