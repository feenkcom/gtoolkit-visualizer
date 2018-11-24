Class {
	#name : #GtMondrianClassHierarcyExamples,
	#superclass : #Object,
	#category : #'GToolkit-Mondrian-Examples'
}

{ #category : #assertions }
GtMondrianClassHierarcyExamples >> assertNumberOfElementsIn: view [
	| mainElement expectedNumberOfElements |
	mainElement := view topStep root.
	"In he root space there should be an element and a line for each subclasses. 
	There is no line for the superclass."
	expectedNumberOfElements := self targetClass allSubclasses size * 2 + 1.
	self 
		assert: mainElement children size  
		equals: expectedNumberOfElements

	
]

{ #category : #'tutorial - nesting' }
GtMondrianClassHierarcyExamples >> classHierarchyHorizontalTree [
	<gtExample>
	| targetClass view |
	targetClass := self targetClass.
	view := self emptyView.
	view nodes
		with: targetClass withAllSubclasses.
	view edges
		connectToAll: #subclasses.
	view layout horizontalTree.
	self assertNumberOfElementsIn: view.
	^ view
]

{ #category : #'tutorial - nesting' }
GtMondrianClassHierarcyExamples >> classHierarchyHorizontalTreeWithBasicShape [
	<gtExample>
	| targetClass view |
	targetClass := self targetClass.
	view := self emptyView.
	view nodes
		shape: [ 
			BlElement new
				border: (BlBorder paint: Color gray width: 1) ]; 
		with: targetClass withAllSubclasses.
	view edges
		connectToAll: #subclasses.
	view layout horizontalTree.
	^ view
]

{ #category : #'tutorial - nesting' }
GtMondrianClassHierarcyExamples >> classHierarchyHorizontalTreeWithBasicShapeWithSize [
	<gtExample>
	| targetClass view |
	targetClass := self targetClass.
	view := self emptyView.
	view nodes
		shape: [ :aClass |
			BlElement new
				border: (BlBorder paint: Color gray width: 1);
				size: (aClass numberOfMethods min: 50 max: 5) asPoint ]; 
		with: targetClass withAllSubclasses.
	view edges
		fromRightCenter;
		toLeftCenter;
		connectToAll: #subclasses.
	view layout horizontalTree.
	^ view
]

{ #category : #'tutorial - nesting' }
GtMondrianClassHierarcyExamples >> classHierarchyHorizontalTreeWithClassNames [
	<gtExample>
	| targetClass view |
	targetClass := self targetClass.
	view := self emptyView.
	view nodes
		shape: [ :aClass |
			BlTextElement new
				text: aClass name asRopedText;
				border: (BlBorder paint: Color gray width: 1);
				constraintsDo: [ :c |
					c padding: (BlInsets all: 10) ] ]; 
		with: targetClass withAllSubclasses.
	view edges
		fromRightCenter;
		toLeftCenter;
		connectToAll: #subclasses.
	view layout horizontalTree.
	^ view
]

{ #category : #'tutorial - nesting' }
GtMondrianClassHierarcyExamples >> classHierarchyHorizontalTreeWithCustomShapeForClasses [
	<gtExample>
	| targetClass view |
	targetClass := self targetClass.
	view := self emptyView.
	view nodes
		shape: [ :aClass |
			GtMondrianClassHierarcyExampleElement new 
				className: aClass ]; 
		with: targetClass withAllSubclasses;
		forEach: [ :aClass |
			view nodes
				shape: [ :aMethod |
					BlElement new
						size: (aMethod linesOfCode min: 50 max: 5) asPoint;
						border: (BlBorder paint: Color blue width: 1) ];
				with: aClass methods.
			view layout grid ].
	view edges
		fromRightCenter;
		toLeftCenter;
		connectToAll: #subclasses.
	view layout horizontalTree.
	^ view 
]

{ #category : #'tutorial - nesting' }
GtMondrianClassHierarcyExamples >> classHierarchyHorizontalTreeWithInBetweenEdges [
	<gtExample>
	| targetClass view |
	targetClass := self targetClass.
	view := self emptyView.
	view nodes
		shape: [ 
			BlElement new
				border: (BlBorder paint: Color gray width: 1) ]; 
		with: targetClass withAllSubclasses.
	view edges
		fromRightCenter;
		toLeftCenter;
		connectToAll: #subclasses.
	view layout horizontalTree.
	^ view
]

{ #category : #'tutorial - nesting' }
GtMondrianClassHierarcyExamples >> classHierarchyHorizontalTreeWithNestedMethods [
	<gtExample>
	| targetClass view |
	targetClass := self targetClass.
	view := self emptyView.
	view nodes
		shape: [ 
			BlElement new
				border: (BlBorder paint: Color gray width: 1);
				constraintsDo: [ :c |
					c padding: (BlInsets all: 5) ] ]; 
		with: targetClass withAllSubclasses;
		forEach: [ :aClass |
			view nodes
				shape: [ 
					BlElement new
						size: 10 @ 10;
						border: (BlBorder paint: Color blue width: 1) ];
				with: aClass methods.
			view layout grid].
	view edges
		fromRightCenter;
		toLeftCenter;
		connectToAll: #subclasses.
	view layout horizontalTree.
	^ view 
]

{ #category : #'tutorial - nesting' }
GtMondrianClassHierarcyExamples >> classHierarchyHorizontalTreeWithNestedMethodsAndClassNames [
	<gtExample>
	| targetClass view |
	targetClass := self targetClass.
	view := self emptyView.
	view nodes
		shape: [ :aClass ||classNameText containerElement labelElement methodsElement|
			containerElement := BlElement new
				layout: BlLinearLayout vertical;
				border: (BlBorder paint: Color gray width: 1);
				constraintsDo: [ :c |
					c padding: (BlInsets all: 5).
					c horizontal fitContent.
					c vertical fitContent ].
			classNameText := aClass name asRopedText.
			classNameText attributes: {
				BlFontSizeAttribute size: 10 }.
			labelElement := BlTextElement new
				text: classNameText;
				constraintsDo: [ :c | 
					c padding: (BlInsets all: 5).
					c linear horizontal alignCenter ].
			methodsElement := BlElement new
				constraintsDo: [ :c | 
					c linear horizontal alignCenter ].
			methodsElement graph beChildrenContainer.
			containerElement
				addChild: labelElement;
				addChild: methodsElement.
			containerElement ]; 
		with: targetClass withAllSubclasses;
		forEach: [ :aClass |
			view nodes
				shape: [ :aMethod |
					BlElement new
						size: (aMethod linesOfCode min: 50 max: 5) asPoint;
						border: (BlBorder paint: Color blue width: 1) ];
				with: aClass methods.
			view layout grid ].
	view edges
		fromRightCenter;
		toLeftCenter;
		connectToAll: #subclasses.
	view layout horizontalTree.
	^ view 
]

{ #category : #'tutorial - nesting' }
GtMondrianClassHierarcyExamples >> classHierarchyHorizontalTreeWithNestedMethodsWithSize [
	<gtExample>
	| targetClass view |
	targetClass := self targetClass.
	view := self emptyView.
	view nodes
		shape: [ 
			BlElement new
				border: (BlBorder paint: Color gray width: 1);
				constraintsDo: [ :c |
					c padding: (BlInsets all: 5) ] ]; 
		with: targetClass withAllSubclasses;
		forEach: [ :aClass |
			view nodes
				shape: [ :aMethod |
					BlElement new
						size: (aMethod linesOfCode min: 50 max: 5) asPoint;
						border: (BlBorder paint: Color blue width: 1) ];
				with: aClass methods.
			view layout grid].
	view edges
		fromRightCenter;
		toLeftCenter;
		connectToAll: #subclasses.
	view layout horizontalTree.
	^ view 
]

{ #category : #examples }
GtMondrianClassHierarcyExamples >> emptyView [
	<gtExample>
	| view |
	view := GtMondrian new.
	self assert: view topStep root children isEmpty.
	^ view
]

{ #category : #accessing }
GtMondrianClassHierarcyExamples >> targetClass [ 
	^ GtPhlowView
]
