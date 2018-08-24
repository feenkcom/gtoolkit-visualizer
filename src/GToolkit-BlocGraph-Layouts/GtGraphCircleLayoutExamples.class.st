Class {
	#name : #GtGraphCircleLayoutExamples,
	#superclass : #GtGraphLayoutExamples,
	#category : 'GToolkit-BlocGraph-Layouts-Examples'
}

{ #category : #example }
GtGraphCircleLayoutExamples >> simple [
	<gtExample>
	<script: 'self new simple asSpartaForm asMorph openInWindow'>
	| view nodes |

	view := self view.
	nodes := self nodes: (1 to: 75).
	view addChildren: nodes.
	view layout: (GtGraphCircleLayout new radius: 150).

	self applyLayoutIn: view.

	^ view
]
