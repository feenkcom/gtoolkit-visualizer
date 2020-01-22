Class {
	#name : #GtPlotterScaleBasedElement,
	#superclass : #BlElement,
	#category : #'GToolkit-Plotter-Core - Elements'
}

{ #category : #initialization }
GtPlotterScaleBasedElement >> initialize [
	super initialize.
	
	self layout: BlFrameLayout new.
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
]
