"
[[[example=GtMondrianDomainExamples>>#umlClassesOn:|noCode|show=gtBlocPropagationIn:]]]
"
Class {
	#name : #GtMondrianDomainExamples,
	#superclass : #Object,
	#category : 'GToolkit-Mondrian-Examples'
}

{ #category : #examples }
GtMondrianDomainExamples >> buttonLabelLookEventPropagation [
	<gtExample>
	| aView aButtonElement theNodes |

	aButtonElement := BrButtonLabelLookExamples new buttonWithModelAndLookWithoutConstraints.
	theNodes := {
		aButtonElement.
		aButtonElement look.
		aButtonElement viewModel.
		aButtonElement children first.
		aButtonElement children first children first.
	}.

	aView := self emptyView.

	aView nodes
		shape: [ :aTarget |
			| text |
			text := aTarget gtDisplayString asRopedText.
			text attributes: {BrTextForegroundAttribute paint: Color lightGray}.
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

{ #category : #examples }
GtMondrianDomainExamples >> editorElementWithPreviews [
	<gtExample>
	| root element editor ropeMondrian elementsMondrian block |
	block := [
		| view toAdd |
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
	root constraintsDo: [ :c | 
			c vertical matchParent.
			c horizontal matchParent ].
	root layout: (BlGridLayout new cellSpacing: 20; columnCount: 1).
	element := BrEditorElement new.
	editor := BrTextEditor new.
	editor text: BrRopedTextExamples new textWithAttributes.
	editor when: BrTextEditorInsertedEvent do: block.
	element 
		background: Color white;
		effect: (BlDropShadowEffect color: Color lightGray width: 10 offset: 10@10);
		editor: editor;
		constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical matchParent.
				c grid vertical weight: 0.5 ].
	root addChild: element.

	elementsMondrian := BlElement new.
	elementsMondrian 
		background: Color white;
		effect: (BlDropShadowEffect color: Color lightGray width: 10 offset: 10@10);
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent.].
	root addChild: elementsMondrian.

	ropeMondrian := BlElement new.
	ropeMondrian 
		background: Color white;
		effect: (BlDropShadowEffect color: Color lightGray width: 10 offset: 10@10);
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent.].
	root addChild: ropeMondrian.
	block value.
	^ root
]

{ #category : #examples }
GtMondrianDomainExamples >> editorElements [
	<gtExample>
	| text element editor view |
	text := BrRopedTextExamples new textWithAttributes.
	element := BrEditorElement new.
	editor := BrTextEditor new.
	editor text: text.
	editor moveCursorTo: 30.
	element editor: editor.
	element constraintsDo: [ :c | c vertical fitContent. c horizontal fitContent ].
	element forceLayout.
	view := GtMondrian new.
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
				background: (BlBackground image: form);
				constraintsDo: [ :c | c grid horizontal alignCenter ].
			container addChild: content.
			container ];
		with: element withAllChildrenBreadthFirst.
	view edges 
		fromCenterBottom;
		toCenterTop;
		shape: [ :each | BlLineElement new border: (BlBorder paint: (Color gray alpha: 0.3) width: 2) ];
		connectFrom: #parent.
	view layout tree horizontalGap: 10; verticalGap: 40.
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
				background: (BlBackground image: form);
				constraintsDo: [ :c | c grid horizontal alignCenter ].
			container addChild: content.
			container ];
		with: element withAllChildrenBreadthFirst.
	view edges 
		fromCenterBottom;
		toCenterTop;
		shape: [ :each | BlLineElement new border: (BlBorder paint: (Color gray alpha: 0.3) width: 2) ];
		connectFrom: #parent.
	view layout tree.
	^ view
		
]

{ #category : #examples }
GtMondrianDomainExamples >> emptyView [
	<gtExample>
	^ GtMondrian new
]

{ #category : #examples }
GtMondrianDomainExamples >> exampleDependencies [
	<gtExample>
	| view |
	view := self emptyView.
	view nodes 
		shape: [ :each | 
			| text styler editor editorElement |
			text := each method sourceCode asRopedText.
			styler := GtExamplesStyler new classOrMetaClass: each methodClass.
			editor := BrTextEditor new.
			editor styler: styler.
			editor text: text.
			editorElement := BrEditorElement new.
			editorElement constraintsDo: [ :c |
			    c horizontal matchParent.
			    c vertical matchParent ].
			editorElement editor: editor.
			editorElement ];
		with: ((BlBezierExamples>>#quadraticCurveWithAnchors) gtExample withDeepCollect: #directDependencies) asSet.
	view edges 
		fromRightCenter; toLeftCenter;
		connectToAll: #directDependencies.
	view layout horizontalDominanceTree layered horizontalGap: 100.
	^ view
]

{ #category : #examples }
GtMondrianDomainExamples >> packageDependencies [
	<gtExample>
	| view packages dependencies |
	view := self emptyView.
	"packages := {'Glamour-Core' . 'Glamour-Presentations'.
	'Glamour-Morphic-Renderer' . 'Glamour-Browsers'} collect: #asPackage.
	"
	packages := RPackageOrganizer default packages select: [ :each | each name beginsWith: 'GToolkit-' ].
	dependencies := packages
		flatCollect: [ :p | 
			((p definedClasses flatCollect: #subclasses) groupedBy: #package)
				associations
				collect: [ :each | 
					{p.
					each key.
					each value} ]
				thenSelect: [ :tuple | tuple first ~= tuple second ] ].
	view nodes
		shape: [ :p | 
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
			shape 	addChild: defaultContainer ];
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
				fromHead:
					(BlArrowheadSimpleArrow new
						arrowLengthFraction: 5;
						arrowNoseAngle: 60;
						border:
							(BlBorder builder
								paint: (Color gray alpha: 0.2);
								width: dep third size;
								build)) ];
		connect: dependencies from: #first to: #second.
	view layout circle radius: 300.
	^ view
]

{ #category : #examples }
GtMondrianDomainExamples >> umlClasses [
	<gtExample>
	| view |
	view := self emptyView.
	view nodes
		umlClassShapeWithName: [ :each | each name ];
		with: OrderedCollection withAllSubclasses;
		forEach: [ :class | 
			view nodes
				shape: [ :method | 
					BlTextElement new
						text: method selector asRopedText;
						padding:
							(BlInsets
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
