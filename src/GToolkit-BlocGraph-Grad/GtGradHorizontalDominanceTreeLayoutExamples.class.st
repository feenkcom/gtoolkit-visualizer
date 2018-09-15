Class {
	#name : #GtGradHorizontalDominanceTreeLayoutExamples,
	#superclass : #GtGradDominanceTreeLayoutExamples,
	#category : #'GToolkit-BlocGraph-Grad-Examples'
}

{ #category : #'examples - instance creation' }
GtGradHorizontalDominanceTreeLayoutExamples >> dominanceTreeLayout [
	<gtExample>
	|  aTreeLayout |

	aTreeLayout := GtGradHorizontalDominanceTreeLayout new.
	self assert: aTreeLayout levelDistance equals: 10.
	self assert: aTreeLayout nodeDistance equals: 1.

	^ aTreeLayout
]

{ #category : #'examples - instance creation' }
GtGradHorizontalDominanceTreeLayoutExamples >> dominanceTreeWithMultiplePathsToANodesWith8Nodes [
	<gtExample>
	| view theNodes aTreeLayout |
	
	view := self view.
	theNodes := self constructDominanceTreeWithMultiplePathsToANodesWith8Nodes key. 
	view addChildren: theNodes. 
	aTreeLayout := self dominanceTreeLayout.
	view layout: aTreeLayout.
	view forceLayout. 
		
	^ view

]

{ #category : #'examples - instance creation' }
GtGradHorizontalDominanceTreeLayoutExamples >> dominanceTreeWithMultiplePathsToANodesWith9Nodes [
	<gtExample>
	| view theNodes aTreeLayout |
	
	view := self view.
	theNodes := self constructDominanceTreeWithMultiplePathsToANodesWith9Nodes key. 
	view addChildren: theNodes.
	aTreeLayout := self dominanceTreeLayout.
	view layout: aTreeLayout.
	view forceLayout. 
		
	^ view

]

{ #category : #'examples - instance creation' }
GtGradHorizontalDominanceTreeLayoutExamples >> simpleDominanceTreeWith5Nodes [
	<gtExample>
	| view theNodes aTreeLayout |
	
	view := self view.
	theNodes := self constructDominanceTreeWith5Nodes key.
	view addChildren: theNodes. 
	aTreeLayout := self dominanceTreeLayout.
	view layout: aTreeLayout.
	view forceLayout. 
		
	^ view

]
