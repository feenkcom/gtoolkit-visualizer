Class {
	#name : #GtWardleyMapNodeRegularStyleBuilder,
	#superclass : #GtWardleyMapNodeStyleBuilder,
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #'api - hooks' }
GtWardleyMapNodeRegularStyleBuilder >> onHovered [
	element nodeElementDo: [ :anElement | 
		anElement border: BlBorder empty.
		anElement background: GtWardleyMapConstants hoverColor ].
	element labelElementDo: [ :aLabel | 
		aLabel aptitude foreground: GtWardleyMapConstants hoverColor ]
]

{ #category : #'api - hooks' }
GtWardleyMapNodeRegularStyleBuilder >> onNodeColored [
	element nodeElementDo: [ :anElement | 
		anElement  border: BlBorder empty.
		anElement background: viewModel nodeColor ].
	element labelElementDo: [ :aLabel | 
		aLabel aptitude foreground: viewModel labelColor ]
]
