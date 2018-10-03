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
					c vertical fitContent. c horizontal fitContent.
					c padding: (BlInsets all: 5) ] ]; 
		with: targetClass withAllSubclasses;
		forEach: [ :aClass |
			view nodes
				shape: [ :m | 
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
						size: 10@10;
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
	^ GLMFormatedPresentation
]
