"
1. Domain-specific examples

Mondrian is useful for creating custom views that are specific to a given domain.


1. ## Package dependencies


In this example, we see a list of packages arranged in a circle, with nested classes and the inheritance dependencies between the classes grouped at package level. One interesting thing is that the label of the packages shrinks to the available space offered by the size of the boxes. Another particularity is the use of parabolla arcs and heads.

{{gtExample:GtMondrianDomainExamples>>#packageDependencies|previewExpanded}}


1. ## Examples dependencies


This examples shows a tree of dependencies between example methods. We can see here that the visualization can embed arbitrary elements, such as an editor element with syntax highlighting.

{{gtExample:GtMondrianDomainExamples>>#exampleDependencies|previewExpanded}}


1. # The inner structure of an element editor


Visualization can be applied to any object or set objects. For example, the following visualization helps us understand how the editor element is composed out of smaller elements by showing the tree of the elements, each depicted with a label and a picture of the actual element.

{{gtExample:GtMondrianDomainExamples>>#editorElements|previewExpanded}}


"
Class {
	#name : #GtMondrianDomainExamples,
	#superclass : #Object,
	#category : #'GToolkit-Mondrian-Examples'
}

{ #category : #examples }
GtMondrianDomainExamples >> buttonLabelLookEventPropagation [
	<gtExample>
	<return: #GtMondrian>
	| aView aButtonElement theNodes |
	aButtonElement := BrButtonLabelAptitudeExamples new
			buttonWithModelAndLookWithoutConstraints.
	theNodes := {aButtonElement.
			aButtonElement aptitude.
			aButtonElement viewModel.
			aButtonElement children first.
			aButtonElement children first children first}.

	aView := self emptyView.

	aView nodes
		stencil: [ :aTarget | 
			| text |
			text := aTarget gtDisplayString asRopedText.
			text attributes: {BlTextForegroundAttribute paint: Color lightGray}.
			BlTextElement new
				text: text;
				padding: (BlInsets all: 5) ];
		with: theNodes.

	aView edges
		fromRightCenter;
		toLeftCenter;
		shape: [ :x | BlLineElement new border: (BlBorder paint: (Color lightGray alpha: 0.4)) ];
		connect: (theNodes select: [ :each | each hasOwner ])
			from: [ :aTarget | aTarget owner ].

	aView layout horizontalTree levelDistance: 40.

	^ aView
]

{ #category : #utility }
GtMondrianDomainExamples >> classHierarchyFor: classes [
	"This is a simpler visualization than the umlClasses one, with just class names."

	| m |
	m := GtMondrian new.
	m nodes
		stencil: [ :c | 
			BrLabel new
				border: (BlBorder paint: Color lightGray);
				text: c name;
				aptitude: (BrGlamorousLabelAptitude new + (BrStyleCommonAptitude new hovered: [:aStyle | aStyle background: (Color blue alpha: 0.5) ]));
				when: BlClickEvent
					do: [ :e | e target phlow spawnTool: (GtClassCoderTool forClass: c). e consumed: true ];
				padding: (BlInsets all: 5) ];
		with: classes.
	m edges
		stencil: [ :c | 
			BlLineElement new
				border: (BlBorder paint: Color gray);
				fromHead: (BlArrowheadTriangle new
						scale: 4;
						border: (BlBorder paint: Color gray)) ];
		connectFrom: #superclass.
	m layout tree levelDistance: 20.
	^ m
]

{ #category : #examples }
GtMondrianDomainExamples >> collectionHierarchy [
	<gtExample>
	<return: #GtMondrian>
	^ self
		classHierarchyFor: {Object.
				Collection.
				SequenceableCollection.
				ArrayedCollection.
				Array.
				String.
				ByteString.
				Symbol.
				Text.
				OrderedCollection.
				SortedCollection.
				LinkedList.
				Interval.
				Heap.
				HashedCollection.
				Set.
				Dictionary.
				IdentityDictionary.
				Bag}
]

{ #category : #examples }
GtMondrianDomainExamples >> collectionSetBagHierarchy [
	<gtExample>
	<return: #GtMondrian>
	^ self
		classHierarchyFor: {Collection.
				HashedCollection.
				Set.
				Dictionary.
				IdentityDictionary.
				Bag}
]

{ #category : #examples }
GtMondrianDomainExamples >> editorElementWithPreviews [
	<gtExample>
	<return: #BlElement>
	| root element editor ropeMondrian elementsMondrian block |
	block := [ | view toAdd |
		view := GtMondrian new.
		element forceLayout.
		element editor text rope paintTreeWith: view.
		toAdd := view asScalableElement.
		ropeMondrian removeChildren.
		ropeMondrian addChild: toAdd.

		view := GtMondrian new.
		GtMondrianDomainExamples new editorElementsOf: element on: view.
		toAdd := view asScalableElement.
		elementsMondrian removeChildren.
		elementsMondrian addChild: toAdd ].

	root := BlElement new.
	root
		constraintsDo: [ :c | 
			c vertical matchParent.
			c horizontal matchParent ].
	root
		layout: (BlGridLayout new
				cellSpacing: 20;
				columnCount: 1).
	element := BrEditorElement new.
	editor := BrTextEditorModel new.
	editor text: BlRopedTextExamples new textWithAttributes.
	editor when: BrTextEditorInsertedEvent do: block.
	editor when: BrTextEditorDeletedEvent do: block.
	editor when: BrTextEditorCursorMovedEvent do: block.
	editor when: BrTextEditorCursorAddedEvent do: block.
	editor when: BrTextEditorCursorRemovedEvent do: block.
	element
		background: Color white;
		effect: (BlGaussianShadowEffect
				color: Color lightGray
				width: 5
				offset: 10 @ 10);
		editor: editor;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent.
			c grid vertical weight: 0.5 ].

	root addChild: element.

	elementsMondrian := BlElement new.
	elementsMondrian
		background: Color white;
		effect: (BlGaussianShadowEffect
				color: Color lightGray
				width: 5
				offset: 10 @ 10);
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
	root addChild: elementsMondrian.

	ropeMondrian := BlElement new.
	ropeMondrian
		background: Color white;
		effect: (BlGaussianShadowEffect
				color: Color lightGray
				width: 5
				offset: 10 @ 10);
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
	root addChild: ropeMondrian.
	block value.
	^ root
]

{ #category : #examples }
GtMondrianDomainExamples >> editorElements [
	<gtExample>
	<return: #GtMondrian>
	| text element editor view |
	text := BlRopedTextExamples new textWithAttributes.
	element := BrEditorElement new.
	editor := BrTextEditorModel new.
	editor text: text.
	editor moveCursorTo: 30.
	element editor: editor.
	element
		constraintsDo: [ :c | 
			c vertical fitContent.
			c horizontal fitContent ].
	element forceLayout.
	view := GtMondrian new.
	view nodes
		stencil: [ :each | 
			| form content container label labelText |
			container := BlElement new
					constraintsDo: [ :c | 
						c vertical fitContent.
						c horizontal fitContent.
						c padding: (BlInsets top: 5 bottom: 5) ];
					layout: (BlGridLayout vertical cellSpacing: 1).
			labelText := ((each class name withoutPrefix: 'Br') withoutPrefix: 'Bl')
					withoutSuffix: 'Element'.
			labelText ifEmpty: [ labelText := 'Element' ].
			labelText := labelText asRopedText.
			labelText fontSize: 9.
			labelText foreground: Color lightGray.
			label := BlTextElement new text: labelText.
			label constraintsDo: [ :c | c grid horizontal alignCenter ].
			container addChild: label.
			form := each asSpartaForm.
			content := BlElement new
					size: form extent;
					background: form;
					constraintsDo: [ :c | c grid horizontal alignCenter ].
			container addChild: content.
			container ];
		with: element withAllChildrenBreadthFirst.
	view edges
		fromCenterBottom;
		toCenterTop;
		shape: [ :each | BlLineElement new border: (BlBorder paint: (Color gray alpha: 0.3) width: 2) ];
		connectFrom: #parent.
	view layout tree
		nodeDistance: 10;
		levelDistance: 40.
	^ view
]

{ #category : #examples }
GtMondrianDomainExamples >> editorElementsOf: element on: view [
	view nodes
		shape: [ :each | 
			| form content container label labelText |
			container := BlElement new 
				constraintsDo: [:c | 
					c vertical fitContent. 
					c horizontal fitContent.
					c padding: (BlInsets top: 5 bottom: 5)];
				layout: (BlGridLayout vertical cellSpacing: 1).
			labelText := (((each class name withoutPrefix: 'Br') withoutPrefix: 'Bl') withoutSuffix: 'Element').
			labelText ifEmpty: [ labelText := 'Element' ].
			labelText := labelText asRopedText.
			labelText fontSize: 9.
			labelText foreground: Color lightGray.
			label := BlTextElement new text: labelText. 
			label constraintsDo: [ :c | c grid horizontal alignCenter ].
			container addChild: label.
			form := each asSpartaForm.
			content := BlElement new
				size: form extent;
				background: form;
				constraintsDo: [ :c | c grid horizontal alignCenter ].
			container addChild: content.
			container ];
		with: element withAllChildrenBreadthFirst.
	view edges 
		fromCenterBottom;
		toCenterTop;
		shape: [ :each | BlLineElement new border: (BlBorder paint: (Color gray alpha: 0.3) width: 2) ];
		connectFrom: #parent.
	view layout tree nodeDistance: 10; levelDistance: 40.
]

{ #category : #examples }
GtMondrianDomainExamples >> emptyView [
	<gtExample>
	<return: #GtMondrian>
	^ GtMondrian new
]

{ #category : #examples }
GtMondrianDomainExamples >> exampleDependencies [
	<gtExample>
	<return: #GtMondrian>
	| view |
	view := self emptyView.
	view nodes
		stencil: [ :each | 
			(GtPharoMethodCoder forMethod: each method) asElement
				constraintsDo: [ :c | 
					c horizontal exact: 200.
					c vertical exact: 200 ] ];
		with: ((BlBezierElementExamples >> #quadraticCurveWithAnchors) gtExample
				withDeepCollect: #directDependencies) asSet.
	view edges
		fromNearestCircle;
		toNearestCircle;
		shape: [ :each | 
			BlLineElement new
				border: (BlBorder paint: (Color gray alpha: 0.4) width: 3);
				toHead: (BlArrowheadSimpleArrow new
						border: (BlBorder builder
								paint: (Color gray alpha: 0.4);
								width: 3;
								build)) ];
		connectToAll: #directDependencies.
	view layout horizontalTree
		levelDistance: 200;
		nodeDistance: 40.
	^ view
]

{ #category : #'examples - layout' }
GtMondrianDomainExamples >> forceBasedCollectionHierarchy [
	<gtExample>
	<return: #GtMondrian>
	| m |
	m := GtMondrian new.
	m nodes with: Collection withAllSubclasses.
	m edges connectFrom: #superclass.
	m layout force.
	^ m
]

{ #category : #examples }
GtMondrianDomainExamples >> packageDependencies [
	<gtExample>
	<return: #GtMondrian>
	| view packages dependencies |
	view := self emptyView.	"packages := {'Glamour-Core' . 'Glamour-Presentations'.
	'Glamour-Morphic-Renderer' . 'Glamour-Browsers'} collect: #asPackage.
	"
	packages := self packageOrganizer packages
			select: [ :each | each name beginsWith: 'GToolkit-' ].
	dependencies := packages
			flatCollect: [ :p | 
				((p definedClasses flatCollect: #subclasses) groupedBy: #package) associations
					collect: [ :each | 
						{p.
							each key.
							each value} ]
					thenSelect: [ :tuple | tuple first ~= tuple second ] ].
	view nodes
		stencil: [ :p | 
			| shape text label defaultContainer |
			shape := BlElement new.
			shape layout: (BlGridLayout vertical cellSpacing: 0).
			shape
				constraintsDo: [ :c | 
					c vertical fitContent.
					c horizontal fitContent ].
			text := p name asRopedText.
			label := BlShrinkingTextElement new text: text.
			label
				constraintsDo: [ :c | 
					c vertical fitContent.
					c horizontal matchParent ].
			shape addChild: label.
			defaultContainer := BlElement new
					layout: BlLinearLayout horizontal;
					constraintsDo: [ :c | 
						c vertical fitContent.
						c horizontal fitContent ];
					background: Color white;
					padding: (BlInsets all: 5).
			defaultContainer graph beChildrenContainer: #default.
			shape addChild: defaultContainer ];
		with: packages
			forEach: [ :each | 
				view nodes
					shape: [ :c | 
						BlElement new
							size: c methods size asPoint;
							background: Color gray ];
					with: each definedClasses.
				view layout rectanglePack ].
	view edges
		fromNearestCircle;
		toNearestCircle;
		shape: [ :dep | 
			BlParabollaArcElement new
				curvatureFraction: 0.2;
				border: (BlBorder paint: (Color gray alpha: 0.2) width: dep third size);
				fromHead: (BlArrowheadSimpleArrow new
						arrowLengthFraction: 5;
						arrowNoseAngle: 60;
						border: (BlBorder builder
								paint: (Color gray alpha: 0.2);
								width: dep third size;
								build)) ];
		connect: dependencies
			from: #first
			to: #second.
	view layout horizontalDominanceTree.
	^ view
]

{ #category : #examples }
GtMondrianDomainExamples >> sequenceableCollectionHierarchy [
	<gtExample>
	<return: #GtMondrian>
	^ self
		classHierarchyFor: {SequenceableCollection.
				ArrayedCollection.
				Array.
				String.
				ByteString.
				Symbol.
				Text.
				OrderedCollection.
				SortedCollection.
				LinkedList.
				Interval}
]

{ #category : #examples }
GtMondrianDomainExamples >> structureOfAnElement [
	<gtExample>
	<return: #GtMondrian>
	| m root |
	m := GtMondrian new.
	root := BlElement new.
	root
		withDeep: [ :each | 
			(each class instVarNames collectAsSet: [ :iv | each instVarNamed: iv ])
				select: [ :object | object class name beginsWith: 'Bl' ] ]
		do: [ :each | 
			m nodes
				stencil: [ BlElement new
						geometry: BlCircleGeometry new;
						size: 10 @ 10;
						background: (each = root
								ifTrue: [ Color red darker ]
								ifFalse: [ each = root border ifTrue: [ Color blue ] ifFalse: [ Color gray ] ]) ];
				with: {each} ]
		relationDo: [ :a :b | 
			m edges
				connect: {a -> b}
				from: #key
				to: #value ].
	m layout force charge: -100.
	^ m
]

{ #category : #examples }
GtMondrianDomainExamples >> umlClasses [
	<gtExample>
	<return: #GtMondrian>
	| view |
	view := self emptyView.
	view nodes
		umlClassShapeWithName: [ :each | each name ];
		with: BlElementVectorGeometry withAllSubclasses;
		forEach: [ :class | 
			view nodes
				stencil: [ :method | 
					BlTextElement new
						text: method selector asRopedText;
						padding: (BlInsets
								top: 5
								right: 5
								bottom: 5
								left: 5) ];
				with: class methods.
			view layout custom: BlLinearLayout vertical ].
	view edges
		fromCenterBottom;
		toCenterTop;
		connectFrom: #superclass.
	view layout tree levelDistance: 100.
	^ view
]
