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
	^ self
]

{ #category : #'gt-extensions' }
GtPhlowMondrianViewExamples >> randomNodesWithEllipsesWith: view [
	<gtExample>
	view nodes
		shape: [ :x | 
			BlElement new 
				border: (BlBorder paint: Color black);
				geometry: BlEllipse new; 
				size: (x * 2) @ (x * 2) ];
		with: (1 to: (9 to: 50) atRandom).
	self assert: view topStep root graph nodeChildren size >= 9.
	^ view
]
