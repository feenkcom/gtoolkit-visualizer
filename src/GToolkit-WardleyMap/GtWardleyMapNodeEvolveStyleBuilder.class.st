Class {
	#name : #GtWardleyMapNodeEvolveStyleBuilder,
	#superclass : #GtWardleyMapNodeStyleBuilder,
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #'api - hooks' }
GtWardleyMapNodeEvolveStyleBuilder >> onHovered [
	element nodeElementDo: [ :anElement | 
		anElement border: (BlBorder paint: GtWardleyMapConstants hoverColor width: 1).
		anElement background: Color white ].
	element labelElementDo: [ :aLabel | 
		aLabel aptitude foreground: GtWardleyMapConstants hoverColor ]
]

{ #category : #'api - hooks' }
GtWardleyMapNodeEvolveStyleBuilder >> onNodeColored [
	element nodeElementDo: [ :anElement | 
		anElement border: (BlBorder paint: viewModel nodeColor width: 1).
		anElement background: Color white ].
	element labelElementDo: [ :aLabel | 
		aLabel aptitude foreground: viewModel labelColor ]
]
