Class {
	#name : #GtGraphGridLayoutExamples,
	#superclass : #GtGraphLayoutExamples,
	#category : 'GToolkit-BlocGraph-Layouts-Examples'
}

{ #category : #example }
GtGraphGridLayoutExamples >> simple [
	<gtExample>
	<script: 'self new simple asSpartaForm asMorph openInWindow'>
	| view nodes |

	view := self view.
	nodes := self nodes: (1 to: 100).
	self connect: nodes from: [ :x | x // 10 ].
	view addChildren: nodes.
	view layout: GtGraphGridLayout new.
	
	self applyLayoutIn: view.
	
	^ view
]
