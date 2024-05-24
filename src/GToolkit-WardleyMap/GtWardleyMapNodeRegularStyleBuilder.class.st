Class {
	#name : #GtWardleyMapNodeRegularStyleBuilder,
	#superclass : #GtWardleyMapNodeStyleBuilder,
	#category : #'GToolkit-WardleyMap-Helpers - Node Type'
}

{ #category : #'api - hooks' }
GtWardleyMapNodeRegularStyleBuilder >> onHovered [
	element border: BlBorder empty.
	element background: GtWardleyMapConstants hoverColor.
	element labelElementDo: [ :aLabel | 
		aLabel aptitude foreground: GtWardleyMapConstants hoverColor ]
]

{ #category : #'api - hooks' }
GtWardleyMapNodeRegularStyleBuilder >> onNodeColored [
	element border: BlBorder empty.
	element background: viewModel nodeColor.
	element labelElementDo: [ :aLabel | 
		aLabel aptitude foreground: viewModel labelColor ]
]
