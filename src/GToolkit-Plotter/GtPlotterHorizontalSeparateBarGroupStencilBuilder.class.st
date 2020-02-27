Class {
	#name : #GtPlotterHorizontalSeparateBarGroupStencilBuilder,
	#superclass : #GtPlotterHorizontalBarGroupStencilBuilder,
	#category : #'GToolkit-Plotter-Builder - Bar Chart'
}

{ #category : #'api - instantiation' }
GtPlotterHorizontalSeparateBarGroupStencilBuilder >> buildDefault [
	<return: #BrStencil or: #BlElement>
	"Create non composite bars"
	|  isStacking aContainer |

	isStacking := self group stacking.

	aContainer := BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent ].

	isStacking
		ifTrue: [ aContainer layout: BlFrameLayout new ]
		ifFalse: [ aContainer layout: BlLinearLayout vertical ].

	aContainer addChildren: (self group values collect: [ :eachValue |
		(barStencil
			group: self group;
			value: eachValue;
			bar: self bar) asElement
				when: BlClickEvent do: [ :anEvent |
					anEvent consumed: true.
					anEvent currentTarget phlow spawnObject: eachValue ]
			]) flattened.

	^ aContainer
]
