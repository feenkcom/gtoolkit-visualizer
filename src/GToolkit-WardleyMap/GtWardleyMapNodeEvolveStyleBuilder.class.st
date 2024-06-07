Class {
	#name : #GtWardleyMapNodeEvolveStyleBuilder,
	#superclass : #GtWardleyMapNodeStyleBuilder,
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #'api - hooks' }
GtWardleyMapNodeEvolveStyleBuilder >> onHovered [
	element border: (BlBorder paint: GtWardleyMapConstants hoverColor width: 1).
	element background: Color white.
	element labelElementDo: [ :aLabel | 
		aLabel aptitude foreground: GtWardleyMapConstants hoverColor ]
]

{ #category : #'api - hooks' }
GtWardleyMapNodeEvolveStyleBuilder >> onNodeColored [
	element border: (BlBorder paint: viewModel nodeColor width: 1).
	element background: Color white.
	element labelElementDo: [ :aLabel | 
		aLabel aptitude foreground: viewModel labelColor ]
]
