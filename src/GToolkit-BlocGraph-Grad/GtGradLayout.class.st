Class {
	#name : #GtGradLayout,
	#superclass : #BlFitLayout,
	#category : #'GToolkit-BlocGraph-Grad'
}

{ #category : #measure }
GtGradLayout >> measure: aParentLayoutNode [
	self subclassResponsibility
]

{ #category : #measure }
GtGradLayout >> measurePositions: anElement with: anExtentSpec [
	| aParentNode |

	aParentNode := (BlLayoutParentNode alreadyMeasured: anElement) extentSpec: anExtentSpec.
	aParentNode filter: [ :eachNode | eachNode constraints graph isNode ].

	self measure: aParentNode withGraphEdges.
	
	aParentNode children do: [ :eachChildNode |
		eachChildNode element measuredBounds position: eachChildNode measurement position.
		eachChildNode element measuredBounds extent: eachChildNode measurement extent ]
]
