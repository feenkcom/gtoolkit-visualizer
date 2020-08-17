"
!Visualizing class hierarchies
This is a tutorial for using Mondrian to visualize a class hierarchy using a horizontal tree layout. It goes step by step thorugh rendering and connecting classes, while discussing and exemplifying various design decisions in Mondrian. 

As a target class we use the class ${class:GtPhlowView}$. It subclasses can be used to create inspector views.
!!An initial canvas
When using Mondrian we start by instantiating a new canvas. A canvas is an instance of the class ${class:GtMondrian}$. Initially the canvas is empty and does not contain any graphical elements.
${example:GtMondrianClassHierarchyExamples>>#emptyView}$
!!Adding nodes to the canvas 
Next step is to place on the canvas each object that we want to visualize. For our example, that consists in the class ${class:GtPhlowView}$ together with all of its subclassess. We can obtain a collection with these data by sending the message ${method:Behavior>>#withAllSubclasses}$ to the class.
 
To place the nodes we ask the canvas for a node builder (${class:GtMondrianNodeBuilder}$) to which we give the list of objects that we want to display. The builder creates a node in the view for each of those objects. By default all nodes are displayes as rectangles with a fixed size.
${example:GtMondrianClassHierarchyExamples>>#classHierarchyNodesOnly}$
!!Adding edges
To create a tree layout we need to add edges between nodes. For our example, we need to add edges from a class to all its direct subclases.

Like with nodes, we first ask the canvas for an edge builder (${class:GtMondrianEdgeBuilder}$) using the method ${method:GtMondrian>>#edges}$. Then we can use ${method:GtMondrianEdgeBuilder>>#connectToAll:}$ to specify the edges. This method goes through every node in our view, and connects it to all the nodes obtained using the given argument (the argument can also be a block). In this case it will connect a class nodes with all the nodes that represent its subclasses.

${example:GtMondrianClassHierarchyExamples>>#classHierarchyNodesAndEdges}$
!!Specifying a layout
Our view does not have an explicit layout at the moment. By default a grid layout is used. To set an explicit layout we ask the canvas for a layout builder (${class:GtMondrianLayoutBuilder}$) using the method  ${method:GtMondrian>>#layout}$. The builder has various methods for configuring different types of layouts. For a horizontal tree layout we need to use ${method:GtMondrianLayoutBuilder>>#horizontalTree}$
${example:GtMondrianClassHierarchyExamples>>#classHierarchyHorizontalTree}$
!!Customising shapes
We connected now classes with subclasses, but all nodes are displayed using the default shape. We can change that by configuring the node builder with a custom logic for creating shapes for nodes using ${method:GtMondrianGraphBuilder>>#shape:}$. The order in which messages are sent matters in Mondrian. We need to customize the shape before configuring the nodes. 

${example:GtMondrianClassHierarchyExamples>>#classHierarchyHorizontalTreeWithBasicShape}$

We can see above that the ==shape:== method gets as parameter a block that returns an instance of the class ${class:BlElement}$. Hence, shapes are not special elements in Mondrian. Any graphical element can be a shape. 
!!Controlling edges
Currently edges do not look right, as by default they connect the center of elements. To fix this we can use dedicated methods in the endge builder to indicate that we want edges to connect the right side with the left side.

${example:GtMondrianClassHierarchyExamples>>#classHierarchyHorizontalTreeWithInBetweenEdges}$
!!More custom shapes
Up until now we used identical shapes for all classes. When building views we often want to show nodes differently based on the object that  they represent. To support this the block passed to the ${method:GtMondrianGraphBuilder>>#shape:}$ method gets as parameter the model object for which that shape is being created. 

In our example we use this to set the size of of a shape based on the number of methods in a class. We can customise any other property of the graphical element this way.
${example:GtMondrianClassHierarchyExamples>>#classHierarchyHorizontalTreeWithBasicShapeWithSize}$

Another way in which we could customise shapes, is by returning a different graphical element. For example, below we use a ${class:BlTextElement}$ to show the name of each class.
${example:GtMondrianClassHierarchyExamples>>#classHierarchyHorizontalTreeWithClassNames}$
!!Composing shapes 
The previous examples started from a set of classes and created shapes to represent those classes. Next we would like to show for each class the methods that it contains. For that we can use composition: for each class we specify a script using Mondrian that creates the content of that shape.

${example:GtMondrianClassHierarchyExamples>>#classHierarchyHorizontalTreeWithNestedMethods}$

In the example above ${method:GtMondrianNodeBuilder>>#forEach:}$ is applied for each class and creates the content of the corresponding shape. Within the block passed to this method we can a specify a Mondrian script, just like we did when creating shapes for classes. 

We can customize the shape of a method in the same way as we customized the shape of a class. Below we set the the size of a method based on the number of lines of code in that method.
${example:GtMondrianClassHierarchyExamples>>#classHierarchyHorizontalTreeWithNestedMethodsWithSize}$
!!Guiding composition
When composing shapes we might want to have more complex graphical elements. A problem that arrises in this case is where within a shape to place the the child shapes. In the example below we have a more complex shape for displaying a class; this shape has a label and an element that should contain the methods. Just because we named the element ==methodsElement==, Mondrian cannot guess that methods should be placed there. We have to explicitly tell Mondrian where to place the child shapes. For that we can use ${method:GtGraphElementContext>>#beChildrenContainer}$. Using this method tells Mondrian where to place the shapes for methodss within the class shape.

${example:GtMondrianClassHierarchyExamples>>#classHierarchyHorizontalTreeWithNestedMethodsAndClassNames}$

The example above starts to become quite long. Often when this happens we can introduce custom graphical elements. Here we can take the logic for creating a shape for a class and put in into a dedicated graphical element, ${class:GtMondrianClassHierarchyExampleElement}$. In this way we can simply use composition and dedicated elements for enabling more custom views, instead of increasing the code API offered by Mondrian.

${example:GtMondrianClassHierarchyExamples>>#classHierarchyHorizontalTreeWithCustomShapeForClasses}$
"
Class {
	#name : #GtMondrianClassHierarchyExamples,
	#superclass : #Object,
	#category : #'GToolkit-Mondrian-Examples'
}

{ #category : #examples }
GtMondrianClassHierarchyExamples >> assertEmptyView: aView [
	self assert: aView topStep root children isEmpty.
]

{ #category : #assertions }
GtMondrianClassHierarchyExamples >> assertNumberOfElementsIn: view [
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
GtMondrianClassHierarchyExamples >> assertNumberOfNodesIn: view [
	| mainElement expectedNumberOfElements |
	mainElement := view topStep root.
	expectedNumberOfElements := self targetClass allSubclasses size + 1.
	self 
		assert: mainElement children size  
		equals: expectedNumberOfElements

	
]

{ #category : #'tutorial - nesting' }
GtMondrianClassHierarchyExamples >> classHierarchyHorizontalTree [
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
GtMondrianClassHierarchyExamples >> classHierarchyHorizontalTreeWithBasicShape [
	<gtExample>
	| targetClass view |
	targetClass := self targetClass.
	view := self emptyView.
	view nodes
		shape: [
		    "Any graphical element can be used a shape."
			BlElement new
				border: (BlBorder paint: Color gray width: 1) ]; 
		with: targetClass withAllSubclasses.
	view edges
		connectToAll: #subclasses.
	view layout horizontalTree.
	^ view
]

{ #category : #'tutorial - nesting' }
GtMondrianClassHierarchyExamples >> classHierarchyHorizontalTreeWithBasicShapeWithSize [
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
GtMondrianClassHierarchyExamples >> classHierarchyHorizontalTreeWithClassNames [
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
GtMondrianClassHierarchyExamples >> classHierarchyHorizontalTreeWithCustomShapeForClasses [
	<gtExample>
	| targetClass view |
	targetClass := self targetClass.
	view := self emptyView.
	view nodes
		shape: [ :aClass |
			GtMondrianClassHierarchyExampleElement new 
				className: aClass name ]; 
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
GtMondrianClassHierarchyExamples >> classHierarchyHorizontalTreeWithInBetweenEdges [
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
		fromRightCenter; "Start from the center of the right side "
		toLeftCenter;    "End at the the center of the left"
		connectToAll: #subclasses.
	view layout horizontalTree.
	^ view
]

{ #category : #'tutorial - nesting' }
GtMondrianClassHierarchyExamples >> classHierarchyHorizontalTreeWithNestedMethods [
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
		"Builds the content of each class shape."
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
GtMondrianClassHierarchyExamples >> classHierarchyHorizontalTreeWithNestedMethodsAndClassNames [
	<gtExample>
	| targetClass view |
	targetClass := self targetClass.
	view := self emptyView.
	view nodes
		shape: [ :aClass |
			| containerElement labelElement methodsElement |
			"We create a container to hold the label and the methods."
			containerElement := BlElement new
				layout: BlLinearLayout vertical;
				border: (BlBorder paint: Color gray width: 1);
				constraintsDo: [ :c |
					c padding: (BlInsets all: 5).
					c horizontal fitContent.
					c vertical fitContent ].
			labelElement := BrLabel new
				text: aClass name;
				look: (BrLabelLook new 
					fontSize: 10);
				constraintsDo: [ :c | 
					c padding: (BlInsets all: 5).
					c linear horizontal alignCenter ].
			"We create the element that will hold the methods."
			methodsElement := BlElement new
				constraintsDo: [ :c | 
					c linear horizontal alignCenter ].
			"We tell mMndrian to add all child shapes to this element."
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
GtMondrianClassHierarchyExamples >> classHierarchyHorizontalTreeWithNestedMethodsWithSize [
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
GtMondrianClassHierarchyExamples >> classHierarchyNodesAndEdges [
	<gtExample>
	| targetClass view |
	targetClass := self targetClass.
	view := self emptyView.
	view nodes
		with: targetClass withAllSubclasses.
	view edges
		connectToAll: #subclasses.
	self assertNumberOfElementsIn: view.
	^ view
]

{ #category : #'tutorial - nesting' }
GtMondrianClassHierarchyExamples >> classHierarchyNodesOnly [
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
GtMondrianClassHierarchyExamples >> emptyView [
	<gtExample>
	| view |
	view := GtMondrian new.
	self assertEmptyView: view.
	^ view
]

{ #category : #accessing }
GtMondrianClassHierarchyExamples >> targetClass [ 
	^ GtPhlowView
]
