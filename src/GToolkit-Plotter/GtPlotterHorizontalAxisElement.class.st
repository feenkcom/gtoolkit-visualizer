"
[[[
GtPlotterHorizontalAxisElement new
	labelStencil: [ :aLabel | BrLabel new look: BrGlamorousLabelLook; text: aLabel ];
	scale: (GtPlotterDurationScale new domainFrom: 0 years to: 4 years)
	ticks: 4
]]]
"
Class {
	#name : #GtPlotterHorizontalAxisElement,
	#superclass : #GtPlotterAxisElement,
	#category : #'GToolkit-Plotter-Axis - Element'
}

{ #category : #private }
GtPlotterHorizontalAxisElement >> updateTicks [
	| theTicks theTickLabels |
	self removeChildren.
	
	theTicks := scale ticks: amountOfTicks.
	theTickLabels := theTicks collect: [ :eachTick |
		(labelStencil
			scale: self scale;
			tick: eachTick) asElement
				constraintsDo: [ :c | c frame horizontal alignCenterAt: (scale map: (scale valuedTick: eachTick)) ] ].

	self addChildren: theTickLabels
]
