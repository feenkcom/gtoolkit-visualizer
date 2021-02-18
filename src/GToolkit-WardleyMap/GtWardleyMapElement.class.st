"
! Wardley map
This is a renderer, visual editor adn exporter of Wardley Maps.
See https://en.wikipedia.org/wiki/Wardley_map to learn more.


"
Class {
	#name : #GtWardleyMapElement,
	#superclass : #BrFrame,
	#traits : 'TGtWithWardleyMapViewModel',
	#classTraits : 'TGtWithWardleyMapViewModel classTrait',
	#instVars : [
		'canvasLayer'
	],
	#category : #'GToolkit-WardleyMap-! Views'
}

{ #category : #accessing }
GtWardleyMapElement >> evolutionSections: aCollectionOfSections [	
	self addChildFirst: (GtWardleyMapEvolutionAsixLayer new sections: aCollectionOfSections)
]

{ #category : #initialization }
GtWardleyMapElement >> initialize [
	super initialize.
	
	self matchParent.
	self addChild: (canvasLayer := GtWardleyMapCanvasLayer new)
]

{ #category : #'api - wardley map view model' }
GtWardleyMapElement >> onWardleyMapViewModelChanged [
	"Is sent when a new WardleyMap view model is assigned to the element"
	
	canvasLayer wardleyMapViewModel: self wardleyMapViewModel
]
