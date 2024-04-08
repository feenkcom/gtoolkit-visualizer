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
			c horizontal matchParent ].

	isStacking
		ifTrue: [ aContainer layout: BlFrameLayout new ]
		ifFalse: [ aContainer layout: BlLinearLayout horizontal ].

	aContainer addChildren: (self group values collect: [ :eachValue |
		(barStencil
			group: self group;
			value: eachValue;
			bar: self bar) asElement
				constraintsDo: [:c | 
					c horizontal matchParent ];
				when: BlClickEvent do: [ :anEvent |
					anEvent consumed: true.
					anEvent currentTarget phlow spawnObject: eachValue ]
			]) flattened.
	aContainer withAllChildren do: [:c | c constraintsDo: [:m | m horizontal matchParent ] ].
	^ aContainer
]
