Class {
	#name : #GtPhlowMondrianViewExamples,
	#superclass : #Object,
	#category : #'GToolkit-Mondrian-Phlow-Examples'
}

{ #category : #'gt-extensions' }
GtPhlowMondrianViewExamples >> gtRandomNodesFor: aView [
	<gtView>
	^ aView mondrian
		title: 'Random';
		priority: 1;
		painting: [ :aMondrian | self randomNodesWithEllipsesWith: aMondrian ];
		actionButtonIcon: BrGlamorousVectorIcons refresh 
			action: [ :aButton :aTab | aTab viewContentElement phlow syncUpdate ]
]

{ #category : #accessing }
GtPhlowMondrianViewExamples >> itself [
	<gtExample>
	<return: #GtPhlowMondrianViewExamples>
	^ self
]

{ #category : #accessing }
GtPhlowMondrianViewExamples >> mondrianPhlowViewHandlesClickEventsOnCustomElements [
	<gtExample>
	<return: #BrFrame>
	| mondrianView mondrianViewElement nodeElement objectToSpawn |
	mondrianView := GtPhlowMondrianView new.
	mondrianView
		painting: [ :m | 
			m nodes
				stencil: [ :each | 
					BrLabel new
						aptitude: BrGlamorousLabelAptitude;
						text: each asString ];
				with: {42} ].
	mondrianView asElementDo: [ :e | mondrianViewElement := e ].
	mondrianViewElement
		allChildrenBreadthFirstDetect: [ :each | each isKindOf: BrLabel ]
		ifFound: [ :x | nodeElement := x ].
	self assert: nodeElement graph model = 42.
	mondrianViewElement
		when: GtPhlowObjectToSpawn
		do: [ :event | objectToSpawn := event ].
	nodeElement children first fireEvent: BlClickEvent new.
	self assert: objectToSpawn notNil.
	^ mondrianViewElement
]

{ #category : #'gt-extensions' }
GtPhlowMondrianViewExamples >> randomNodesWithEllipsesWith: view [
	<gtExample>
	view nodes
		shape: [ :x | 
			BlElement new 
				border: (BlBorder paint: Color black);
				geometry: BlEllipseGeometry new; 
				size: (x * 2) @ (x * 2) ];
		with: (1 to: (9 to: 50) atRandom).
	self assert: view topStep root graph nodeChildren size >= 9.
	^ view
]
