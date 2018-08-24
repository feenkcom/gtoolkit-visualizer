Class {
	#name : #GtGradLayoutExamples,
	#superclass : #GtGradExamples,
	#category : 'GToolkit-BlocGraph-Grad-Examples'
}

{ #category : #'examples - layout' }
GtGradLayoutExamples >> bigNodesN: num [
	<gtExample>
	
	^ num timesCollect: [ :index |
		| aNode |
		aNode := BlElement new
							background: (Color gray alpha: 0.5);
							border: (BlBorder builder width: 1; paint: Color black) build;
							geometry: BlEllipse new;
							size: 300@300.
		aNode graph beNode.
		aNode ]
]

{ #category : #'examples - instance creation' }
GtGradLayoutExamples >> container [
	<gtExample>

	^ BlElement new
]

{ #category : #'examples - layout' }
GtGradLayoutExamples >> createNNodesOfIncreasingSize: numberOfNodes [
	<gtExample>


	^ numberOfNodes timesCollect: [ :index |
		| anElement |
		anElement := BlElement new
							background: (Color gray alpha: 0.5);
							border: (BlBorder builder width: 1; paint: Color black) build;
							geometry: BlEllipse new;
							size: 10 asPoint * index.
		anElement graph beNode.
		anElement ]
]

{ #category : #'examples - instance creation' }
GtGradLayoutExamples >> defaultView [
	^ BlElement new
		background: (BlBackground paint: Color blue)
]

{ #category : #'examples - instance creation' }
GtGradLayoutExamples >> editor [
	<gtExample>
	| anEditorModel anEditorElement |

	anEditorModel := BrTextEditor new.
	anEditorModel text: 'a' asRopedText.

	anEditorElement := BrEditorElement new.
	anEditorElement editor: anEditorModel.
	anEditorElement size: 75@25.
	anEditorElement background: (Color random alpha: 0.2).
	anEditorElement geometry: (BlRectangle cornerRadius: 5).
	
	^ anEditorElement
]

{ #category : #'examples - instance creation' }
GtGradLayoutExamples >> line [
	<gtExample>

	^ BlLineElement new border: (BlBorder builder dashed paint: Color red; width: 2; build)
]

{ #category : #'examples - layout' }
GtGradLayoutExamples >> simpleNodes10 [
	<gtExample>

	^ 10 timesCollect: [
		| anEditor |
		anEditor := self rectangle.
		anEditor graph beNode.
		anEditor ]
]

{ #category : #'examples - layout' }
GtGradLayoutExamples >> simpleNodesN: num [
	<gtExample>

	^ num timesCollect: [
		| aNode |
		aNode := self rectangle.
		aNode graph beNode.
		aNode ]
]

{ #category : #'building - graph' }
GtGradLayoutExamples >> view [
	^ self defaultView
		constraintsDo: [ :constraints |
			constraints horizontal fitContent.
			constraints vertical fitContent.
			constraints padding: (BlInsets all: 10) ];
		background: (BlBackground paint: Color white)
]
