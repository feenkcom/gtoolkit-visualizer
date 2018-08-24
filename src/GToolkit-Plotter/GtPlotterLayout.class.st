Class {
	#name : #GtPlotterLayout,
	#superclass : #BlLayout,
	#instVars : [
		'verticalAxisElement',
		'horizontalAxis',
		'verticalAxis',
		'horizontalAxisElement',
		'domainElements',
		'domainObjects',
		'horizontalProjections',
		'verticalProjections'
	],
	#category : 'GToolkit-Plotter-Layout'
}

{ #category : #constraints }
GtPlotterLayout class >> constraints [
	^ GtPlotterLayoutConstraints new
]

{ #category : #layout }
GtPlotterLayout >> layout: anElement in: aRectangle [
	| verticalAxisBounds horizontalAxisBounds |
		
	self layoutIgnored: anElement.
	
	verticalAxisBounds := verticalAxisElement measuredBounds bounds.
	horizontalAxisBounds := horizontalAxisElement measuredBounds bounds.
	horizontalAxisBounds translateX: 0 Y: (verticalAxisBounds height - horizontalAxisBounds height).

	verticalAxisElement applyLayoutIn: verticalAxisBounds.
	horizontalAxisElement applyLayoutIn: horizontalAxisBounds.

	domainElements
		ifEmpty: [ ^ self ].
	
	domainElements do: [ :aChildElement | self layoutDomainChild: aChildElement ]
]

{ #category : #layout }
GtPlotterLayout >> layoutDomainChild: anElement [
	| aDomainObject normalizedHorizontal normalizedVertical horizontalPosition verticalPosition |
	
	aDomainObject := anElement constraints plotter domainObject.
		
	normalizedHorizontal := horizontalAxis normalize: aDomainObject.
	normalizedVertical := verticalAxis normalize: aDomainObject.
		
	horizontalPosition := (horizontalAxisElement measuredWidth - verticalAxisElement measuredWidth) * normalizedHorizontal.
	verticalPosition := (verticalAxisElement measuredHeight - horizontalAxisElement measuredHeight) * (1 - normalizedVertical).
	
	horizontalPosition := horizontalPosition + verticalAxisElement measuredWidth.
	verticalPosition := verticalPosition - horizontalAxisElement measuredHeight.

	anElement measuredBounds position: (horizontalPosition @ verticalPosition) - (anElement measuredExtent / 2.0) rounded.
	
	anElement applyLayoutIn: anElement measuredBounds bounds
]

{ #category : #measure }
GtPlotterLayout >> measure: anElement with: anExtentSpec [
	self measureIgnored: anElement with: anExtentSpec.

	horizontalAxisElement := anElement children
		detect: [ :aChildElement | aChildElement constraints plotter isHorizonalAxis ]
		ifNone: [ ^ self ].

	verticalAxisElement := anElement children
		detect: [ :aChildElement | aChildElement constraints plotter isVerticalAxis ]
		ifNone: [ ^ self ].

	horizontalAxis := horizontalAxisElement constraints plotter horizontal axis.
	verticalAxis := verticalAxisElement constraints plotter vertical axis.

	domainElements := anElement children
		select: [ :aChildElement | aChildElement constraints plotter isPoint ].

	domainObjects := domainElements
		collect: [ :aChildElement | aChildElement constraints plotter domainObject ].

	horizontalProjections := horizontalAxis initializeOn: domainObjects.
	verticalProjections := verticalAxis initializeOn: domainObjects.

	self
		measuredChildren: anElement
		do: [ :aChildElement | self measureChild: aChildElement parentSpec: anExtentSpec ].
		
	anElement measuredExtent: (anExtentSpec sizeFor: anElement extent)
]
