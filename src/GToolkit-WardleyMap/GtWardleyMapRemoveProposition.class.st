Class {
	#name : #GtWardleyMapRemoveProposition,
	#superclass : #Object,
	#traits : 'TGtWardleyMapDecoratorModel',
	#classTraits : 'TGtWardleyMapDecoratorModel classTrait',
	#instVars : [
		'acceptAction',
		'rejectAction'
	],
	#category : #'GToolkit-WardleyMap-Helpers - Actions'
}

{ #category : #accessing }
GtWardleyMapRemoveProposition >> decorateNodeElement: aNodeElement [
	aNodeElement
		outskirts: BlOutskirts outside;
		border: (BlBorder paint: BrGlamorousColors errorBackgroundColor width: 2).

	aNodeElement labelElementDo: [ :aContainer | 
		aContainer
			geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
			background: (BrGlamorousColors errorBackgroundColor) ].
			
	acceptAction decorateNodeElement: aNodeElement.
	rejectAction decorateNodeElement: aNodeElement.
]

{ #category : #initialization }
GtWardleyMapRemoveProposition >> initialize [
	super initialize.

	acceptAction := GtWardleyMapAction new.
	acceptAction icon: BrGlamorousVectorIcons accept.
	rejectAction := GtWardleyMapAction new.
	rejectAction icon: BrGlamorousVectorIcons cancel.
]
