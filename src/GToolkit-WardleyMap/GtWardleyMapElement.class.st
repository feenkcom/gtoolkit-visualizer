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
		'canvasElement'
	],
	#category : #'GToolkit-WardleyMap-! Views'
}

{ #category : #initialization }
GtWardleyMapElement >> createCanvasElement [
	^ GtWardleyMapCanvasElement new
]

{ #category : #accessing }
GtWardleyMapElement >> evolutionSections: aCollectionOfSections [	
	self addChildFirst: (GtWardleyMapEvolutionAxisLayer new sections: aCollectionOfSections)
]

{ #category : #accessing }
GtWardleyMapElement >> hasEvolutionAxisLayer [
	^(self childAt: 1) class = GtWardleyMapEvolutionAxisLayer
]

{ #category : #initialization }
GtWardleyMapElement >> initialize [
	super initialize.
	
	self matchParent.
	self addChild: (canvasElement := self createCanvasElement)
]

{ #category : #'api - wardley map view model' }
GtWardleyMapElement >> onWardleyMapViewModelChanged [
	"Is sent when a new WardleyMap view model is assigned to the element"
	
	canvasElement wardleyMapViewModel: self wardleyMapViewModel
]
