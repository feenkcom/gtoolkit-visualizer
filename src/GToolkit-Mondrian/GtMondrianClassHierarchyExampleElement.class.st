"
I am an element for displaying a class. I show the name of the class and have a container for adding methods. I am meant to be used as a shape within Mondrian views.
"
Class {
	#name : #GtMondrianClassHierarchyExampleElement,
	#superclass : #BlElement,
	#instVars : [
		'labelElement',
		'methodsElement'
	],
	#category : #'GToolkit-Mondrian-Examples'
}

{ #category : #'building widgets' }
GtMondrianClassHierarchyExampleElement >> buildLabelElement [
	^ BrLabel new
		look: (BrLabelLook new
			fontSize: 10);
		constraintsDo: [ :c | 
			c padding: (BlInsets all: 5).
			c linear horizontal alignCenter ]
]

{ #category : #'building widgets' }
GtMondrianClassHierarchyExampleElement >> buildMethodsElement [
	^ BlElement new
		constraintsDo: [ :c | 
			c linear horizontal alignCenter ]
]

{ #category : #accessing }
GtMondrianClassHierarchyExampleElement >> className: aClassName [
	self labelElement text: aClassName
]

{ #category : #initialization }
GtMondrianClassHierarchyExampleElement >> initialize [ 
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
GtMondrianClassHierarchyExampleElement >> labelElement [
	^ labelElement
]
