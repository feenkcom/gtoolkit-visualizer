Class {
	#name : #GtPlotterVerticalSeparateBarGroupStencilBuilder,
	#superclass : #GtPlotterVerticalBarGroupStencilBuilder,
	#category : #'GToolkit-Plotter-Builder - Bar Chart'
}

{ #category : #accessing }
GtPlotterVerticalSeparateBarGroupStencilBuilder >> buildDefault [
	<return: #BrStencil or: #BlElement>
	"Create non composite bars"
	|  isStacking aContainer |

	isStacking := self group stacking.

	aContainer := BlElement new
		constraintsDo: [ :c |
			c vertical matchParent.
			c horizontal fitContent ].

	isStacking
		ifTrue: [ aContainer layout: BlFrameLayout new ]
		ifFalse: [ aContainer layout: BlLinearLayout horizontal ].

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
