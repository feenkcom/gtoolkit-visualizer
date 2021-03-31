Class {
	#name : #GtWardleyMapEditorElement,
	#superclass : #BrVerticalPane,
	#instVars : [
		'canvas'
	],
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #initialization }
GtWardleyMapEditorElement >> canvas: aWardleyMapCanvasElement [
	canvas := aWardleyMapCanvasElement
]

{ #category : #accessing }
GtWardleyMapEditorElement >> initialize [
	| aContainer |
	super initialize.
	
	self 
		hFitContent;
		vFitContentLimited;
		padding: (BlInsets all: 3).

	aContainer := BrVerticalPane new
		hFitContent
		vFitContentLimited.
	
	aContainer addChildren: {
		
		BrButton new
			beSmallSize;
			aptitude: (BrGlamorousButtonWithLabelAptitude new);
			margin: (BlInsets top: 10 left: 10 bottom: 10 right: 10);
			label: 'Switch sections';
			action: [
				canvas parent hasEvolutionAxisLayer ifFalse: [
					canvas parent evolutionSections: {
						'genesis'.
						'custom built'.
						'product (+rental)'.
						'commodity'}] ifTrue: [
					canvas parent removeChildAt: 1] ] }.
	
	self addChild: (BrScrollPane new
		aptitude: BrScrollPaneAptitude + BrGlamorousWithVerticalScrollbarAptitude;
		vFitContentLimited;
		hFitContent;
		content: aContainer)
]
