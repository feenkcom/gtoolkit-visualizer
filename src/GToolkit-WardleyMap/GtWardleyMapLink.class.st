Class {
	#name : #GtWardleyMapLink,
	#superclass : #GtWardleyMapAction,
	#category : #'GToolkit-WardleyMap-! Models - Decorators'
}

{ #category : #private }
GtWardleyMapLink >> newButton [
	^ GtWardleyMapLinkButtonStencil new
		icon: self icon;
		label: self label;
		tooltip: self tooltip;
		aptitude: self aptitude;
		action: self action;
		model: self model;
		asElement
]
