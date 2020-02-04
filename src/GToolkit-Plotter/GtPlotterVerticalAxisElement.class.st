Class {
	#name : #GtPlotterVerticalAxisElement,
	#superclass : #GtPlotterAxisElement,
	#category : #'GToolkit-Plotter-Axis - Element'
}

{ #category : #private }
GtPlotterVerticalAxisElement >> updateTicks [
	| theTicks theTickLabels |
	self removeChildren.
	
	theTicks := scale ticks: amountOfTicks.
	theTickLabels := theTicks collect: [ :eachTick |
		(labelStencil
			scale: self scale;
			tick: eachTick) asElement
				constraintsDo: [ :c | c frame vertical alignCenterAt: (scale map: (scale valuedTick: eachTick)) ] ].

	self addChildren: theTickLabels
]
