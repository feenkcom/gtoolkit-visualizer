"
I am an element for displaying a class. I show the name of the class and have a container for adding methods. I am meant to be used as a shape within Mondrian views.
"
Class {
	#name : #GtMondrianClassHierarcyExampleElement,
	#superclass : #BlElement,
	#category : #'GToolkit-Mondrian-Examples'
}

{ #category : #'building widgets' }
GtMondrianClassHierarcyExampleElement >> buildLabelElement [
	^ BlTextElement new
		constraintsDo: [ :c | 
			c padding: (BlInsets all: 5).
			c linear horizontal alignCenter ]
]

{ #category : #'building widgets' }
GtMondrianClassHierarcyExampleElement >> buildMethodsElement [
	^ BlElement new
		constraintsDo: [ :c | 
			c linear horizontal alignCenter ]
]

{ #category : #accessing }
GtMondrianClassHierarcyExampleElement >> className: aClassName [
	| classNameText |
	classNameText := aClassName asRopedText.
	classNameText attributes: {
		BlFontSizeAttribute size: 10 }.
	self labelElement text: classNameText
]

{ #category : #initialization }
GtMondrianClassHierarcyExampleElement >> initialize [ 
	| labelElement methodsElement|
	super initialize.
	self 
		layout: BlLinearLayout vertical;
		border: (BlBorder paint: Color gray width: 1);
		constraintsDo: [ :c |
			c padding: (BlInsets all: 5).
			c horizontal fitContent.
			c vertical fitContent ].
	labelElement := self buildLabelElement.
	methodsElement := self buildMethodsElement.
	methodsElement graph beChildrenContainer.
	self
		addChild: labelElement;
		addChild: methodsElement.
]

{ #category : #accessing }
GtMondrianClassHierarcyExampleElement >> labelElement [
	^ self children first
]
