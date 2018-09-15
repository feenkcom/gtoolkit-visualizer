Class {
	#name : #GtGradVerticalDominanceTreeLayoutExamples,
	#superclass : #GtGradDominanceTreeLayoutExamples,
	#category : #'GToolkit-BlocGraph-Grad-Examples'
}

{ #category : #'examples - instance creation' }
GtGradVerticalDominanceTreeLayoutExamples >> dominanceTreeLayout [
	<gtExample>
	|  aTreeLayout |

	aTreeLayout := GtGradVerticalDominanceTreeLayout new.
	self assert: aTreeLayout levelDistance equals: 10.
	self assert: aTreeLayout nodeDistance equals: 1.

	^ aTreeLayout
]

{ #category : #'examples - instance creation' }
GtGradVerticalDominanceTreeLayoutExamples >> dominanceTreeWithMultiplePathsToANodesWith8Nodes [
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
GtGradVerticalDominanceTreeLayoutExamples >> dominanceTreeWithMultiplePathsToANodesWith9Nodes [
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
GtGradVerticalDominanceTreeLayoutExamples >> simpleDominanceTreeWith5Nodes [
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
