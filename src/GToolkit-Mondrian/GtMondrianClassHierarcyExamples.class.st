"
!Visualizing class hierarchies

This is a tutorial for using Mondrian to visualize a class hierarchy using a horizontal tree layout. It goes step by step thorugh different ways to render and connect classes, while discussing and exemplifying various design decisions in Mondrian. 

As a target class we use the class ${class:GtPhlowView}$. It subclasses can be used to create inspector views.

!!An initial canvas
When using Mondrian we start by instantiating a new canvas. A canvas is an instance of the class ${class:GtMondrian}$. Initially the canvas is empty and does not contain any graphical elements.
${example:GtMondrianClassHierarcyExamples>>#emptyView}$

!!Adding nodes to the canvas 
Next step is to place on the canvas each object that we want to visualize. For our example that consists in the class ${class:GtPhlowView}$ together with all of its subclassess. We can obtain a collection with these data by sending the message ${method:Behavior>>#withAllSubclasses}$ to the class.
 
To place the nodes we ask the canvas for a node builder (${class:GtMondrianNodeBuilder}$) to which we give the list of nodes that we want to display (${method:GtMondrianNodeBuilder>>#with:}$). By default all nodes are displayes as rectangles with a fixed size.
${example:GtMondrianClassHierarcyExamples>>#classHierarchyNodesOnly}$

!!Adding edges
To create a tree layout we need to add edges. We need to add edges between every class and all its direct subclases.

Like with nodes, we first ask the canvas for an edge builder (${class:GtMondrianEdgeBuilder}$). Then we can use the ${method:GtMondrianEdgeBuilder>>#connectToAll:}$. This method goes through every objects in our model and connects it to all the objects obtained by sending the given message to the object (the argument can also be a block). In this case it will connect a class with all its subclasses.

${example:GtMondrianClassHierarcyExamples>>#classHierarchyHorizontalTree}$

!!Specifying a layout

"
Class {
	#name : #GtMondrianClassHierarcyExamples,
	#superclass : #Object,
	#category : #'GToolkit-Mondrian-Examples'
}

{ #category : #examples }
GtMondrianClassHierarcyExamples >> assertEmptyView: aView [
	self assert: aView topStep root children isEmpty.
]

{ #category : #assertions }
GtMondrianClassHierarcyExamples >> assertNumberOfElementsIn: view [
	| mainElement expectedNumberOfElements |
	mainElement := view topStep root.
	"In the root space there should be an element and a line for each subclasses. 
	There is no line for the superclass."
	expectedNumberOfElements := self targetClass allSubclasses size * 2 + 1.
	self 
		assert: mainElement children size  
		equals: expectedNumberOfElements

	
]

{ #category : #assertions }
GtMondrianClassHierarcyExamples >> assertNumberOfNodesIn: view [
	| mainElement expectedNumberOfElements |
	mainElement := view topStep root.
	expectedNumberOfElements := self targetClass allSubclasses size + 1.
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

{ #category : #'tutorial - nesting' }
GtMondrianClassHierarcyExamples >> classHierarchyNodesOnly [
	<gtExample>
	| targetClass view |
	targetClass := self targetClass.
	view := self emptyView.
	view nodes
		with: targetClass withAllSubclasses.
	self assertNumberOfNodesIn: view.
	^ view
]

{ #category : #examples }
GtMondrianClassHierarcyExamples >> emptyView [
	<gtExample>
	| view |
	view := GtMondrian new.
	self assertEmptyView: view.
	^ view
]

{ #category : #accessing }
GtMondrianClassHierarcyExamples >> targetClass [ 
	^ GtPhlowView
]
