Class {
	#name : #GtPlotterBar,
	#superclass : #Object,
	#instVars : [
		'widthScale',
		'widthData',
		'heightScale',
		'heightData',
		'gap',
		'elementStencil'
	],
	#category : #'GToolkit-Plotter-Builder - Bar Chart'
}

{ #category : #accessing }
GtPlotterBar >> gap [
	^ gap
]

{ #category : #accessing }
GtPlotterBar >> gap: anObject [
	gap := anObject
]

{ #category : #accessing }
GtPlotterBar >> heightData [
	^ heightData
]

{ #category : #accessing }
GtPlotterBar >> heightData: anObject [
	heightData := anObject
]

{ #category : #accessing }
GtPlotterBar >> heightScale [
	^ heightScale
]

{ #category : #accessing }
GtPlotterBar >> heightScale: anObject [
	heightScale := anObject
]

{ #category : #accessing }
GtPlotterBar >> stencil [
	^ elementStencil
]

{ #category : #accessing }
GtPlotterBar >> stencil: aStencilBuilder [
	elementStencil := aStencilBuilder
]

{ #category : #accessing }
GtPlotterBar >> widthData [
	^ widthData
]

{ #category : #accessing }
GtPlotterBar >> widthData: anObject [
	widthData := anObject
]

{ #category : #accessing }
GtPlotterBar >> widthScale [
	^ widthScale
]

{ #category : #accessing }
GtPlotterBar >> widthScale: anObject [
	widthScale := anObject
]
