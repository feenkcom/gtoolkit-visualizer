"
I am an abstract builder of either nodes or edges.
I know how to specify a shape through an `elementBlock`.


"
Class {
	#name : #GtMondrianGraphBuilder,
	#superclass : #GtMondrianBuilder,
	#instVars : [
		'elementStencilBuilder'
	],
	#category : #'GToolkit-Mondrian'
}

{ #category : #accessing }
GtMondrianGraphBuilder >> elementStencilBuilder [
	^ elementStencilBuilder
]

{ #category : #accessing }
GtMondrianGraphBuilder >> elementStencilBuilder: aBlock [ 
	elementStencilBuilder := aBlock
]

{ #category : #scripting }
GtMondrianGraphBuilder >> shape: aBlock [
	"self
		deprecated: 'Use stencil: instead'
		transformWith: '`@rcv shape: `@arg' -> '`@rcv stencil: `@arg'.
	"self stencil: aBlock
]

{ #category : #scripting }
GtMondrianGraphBuilder >> stencil: aBlock [
	self elementStencilBuilder: aBlock
]
