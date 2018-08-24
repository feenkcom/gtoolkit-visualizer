Class {
	#name : #GtGraphRectanglePackLayoutExamples,
	#superclass : #GtGraphLayoutExamples,
	#category : 'GToolkit-BlocGraph-Layouts-Examples'
}

{ #category : #private }
GtGraphRectanglePackLayoutExamples >> centeredString: aString in: aNode [
	| label |
	label := BlTextElement new.
	label text: aString asRopedText.
	label constraintsDo: [ :constraints |
		constraints frame horizontal alignCenter.
		constraints frame vertical alignCenter.
		constraints padding: (BlInsets all: 1) ].
	aNode addChild: label.
	aNode layout: BlFrameLayout new.
	^ label
]

{ #category : #example }
GtGraphRectanglePackLayoutExamples >> circles [
	<gtExample>
	<script: 'self new circles asSpartaForm asMorph openInWindow'>
	| view nodes data |

	data := self circlesData.

	view := self view.
	nodes := self nodes: data.
	nodes do: [ :node |
		| model label |
		model := node userData at: #model.
		node
			geometry: BlEllipse new;
			size: model value asPoint;
			background: Color random.
		label := BlTextElement new.
		label text: (model key asRopedText
			attributes: { 
				BrTextForegroundAttribute paint: Color black .
				BrFontSizeAttribute size: 10 } ).
		label constraintsDo: [ :constraints |
			constraints frame horizontal alignCenter.
			constraints frame vertical alignCenter ].
		node addChild: label.
		node layout: BlFrameLayout new ].
	
	view addChildren: nodes.
	view layout: (GtGraphRectanglePackLayout new gap: 0).
	self applyLayoutIn: view.

	^ view
]

{ #category : #private }
GtGraphRectanglePackLayoutExamples >> circlesData [
	^ GLMPresentation withAllSubclasses collect: [ :aClass | 
		aClass name  -> (30*( (aClass numberOfMethods max: 1) ln asInteger)) ]
]

{ #category : #example }
GtGraphRectanglePackLayoutExamples >> circlesRaw [
	<gtExample>
	<script: 'self new circlesRaw asSpartaForm asMorph openInWindow'>
	| view data |

	data := self circlesData.

	view := BlElement new.
	data do: [ :model |
		| node label |
		node := BlElement new 
			geometry: BlEllipse new;
			size: model value asPoint;
			background: Color random.
		label := BlTextElement new.
		label text: (model key asRopedText
			attributes: {
				BrTextForegroundAttribute paint: Color black .
				BrFontSizeAttribute size: 10 } ).
		label constraintsDo: [ :constraints |
			constraints frame horizontal alignCenter.
			constraints frame vertical alignCenter ].
		node addChild: label.
		node layout: BlFrameLayout new.
		
		view addChild: node ].
	
	view layout: (GtGraphRectanglePackLayout new gap: 0).
	view constraintsDo: [ :constraints |
		constraints horizontal fitContent.
		constraints vertical fitContent.
		constraints padding: (BlInsets all: 10) ].

	self applyLayoutIn: view.

	^ view
]

{ #category : #example }
GtGraphRectanglePackLayoutExamples >> circlesSimplified [
	<gtExample>
	<script: 'self new circles asSpartaForm asMorph openInWindow'>
	| view data |

	data := self circlesData.

	view := self view.
	self nodes: data inView: view forEach: [ :node |
		| model label |
		model := self modelFor: node.
		node
			geometry: BlEllipse new;
			size: model value asPoint;
			background: Color random.
		label := self centeredString: model key in: node.
		label text attributes: { 
			BrTextForegroundAttribute paint: Color black .
			BrFontSizeAttribute size: 10 } ].
	
	view layout: (GtGraphRectanglePackLayout new gap: 0).
	self applyLayoutIn: view.

	^ view
]

{ #category : #private }
GtGraphRectanglePackLayoutExamples >> modelFor: aNode [
	^ aNode userData at: #model
]

{ #category : #private }
GtGraphRectanglePackLayoutExamples >> nodes: aDataCollection inView: aView forEach: aBlock [
	| nodes |
	nodes := self nodes: aDataCollection.
	nodes do: aBlock.
	aView addChildren: nodes.
]

{ #category : #example }
GtGraphRectanglePackLayoutExamples >> simple [
	<gtExample>
	<script: 'self new simple asSpartaForm asMorph openInWindow'>
	| view nodes |

	view := self view.
	nodes := self nodes: (1 to: 50).
	nodes do: [ :node | node size: (100 atRandom @ 100 atRandom) ].
	
	view addChildren: nodes.
	view layout: GtGraphRectanglePackLayout new.

	self applyLayoutIn: view.

	^ view
]
