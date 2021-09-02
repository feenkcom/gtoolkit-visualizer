Class {
	#name : 'GtPlotterSingleScaleProportionalElement',
	#superclass : 'GtPlotterSingleScaleBasedElement',
	#instVars : [
		'scale',
		'scaleData',
		'elements',
		'weight',
		'shouldHideOverlapping'
	],
	#category : 'GToolkit-Plotter-Core - Elements'
}

{ #category : 'accessing' }
GtPlotterSingleScaleProportionalElement >> hideOverlapping [
	shouldHideOverlapping := true.
	self requestLayout
]

{ #category : 'initialization' }
GtPlotterSingleScaleProportionalElement >> initialize [
	super initialize.

	scale := GtPlotterLinearScale new.
	scaleData := [ :eachDomainObject | eachDomainObject ].
	elements := #().
	weight := 1.0.
	shouldHideOverlapping := false
]

{ #category : 'initialization' }
GtPlotterSingleScaleProportionalElement >> initializeElements [
	self subclassResponsibility
]

{ #category : 'layout' }
GtPlotterSingleScaleProportionalElement >> onLayout: aBounds context: aBlElementBoundsUpdater [
	| aFirstVisibleLabel aLastVisibleLabel aLeftHalfOfElements aRightHalfOfElements |
	super onLayout: aBounds context: aBlElementBoundsUpdater.

	elements
		ifEmpty: [ ^ self ].

	elements do: [ :each | each visibility: BlVisibility visible ].
	
	self shouldHideOverlapping
		ifFalse: [ ^ self ].
	
	aFirstVisibleLabel := elements first.
	aLastVisibleLabel := elements last.
	
	aLeftHalfOfElements := (2 to: 1 + ((elements size - 2) / 2) ceiling)
		collect: [ :anIndex | elements at: anIndex ].
	
	aRightHalfOfElements := ((elements size - 1) to: (elements size - ((elements size - 2) / 2) ceiling) by: -1)
		collect: [ :anIndex | elements at: anIndex ].
		
	aLeftHalfOfElements with: aRightHalfOfElements do: [ :aLeftElement :aRightElement |
		| isLeftVisible isRightVisible |
		
		isLeftVisible := aFirstVisibleLabel == aLeftElement or: [ 
			(aFirstVisibleLabel bounds inParent bounds
				intersects: aLeftElement bounds inParent bounds) not ].
		
		isLeftVisible
			ifTrue: [ aFirstVisibleLabel := aLeftElement ]
			ifFalse: [ aLeftElement visibility: BlVisibility hidden ].

		isRightVisible := aLastVisibleLabel == aRightElement or: [
			(aLastVisibleLabel bounds inParent bounds
				intersects: aRightElement bounds inParent bounds) not ].

		isRightVisible
			ifTrue: [ aLastVisibleLabel := aRightElement ]
			ifFalse: [ aRightElement visibility: BlVisibility hidden ].

		(aLeftElement == aRightElement or: [ (aLeftElement bounds inParent bounds
			intersects: aRightElement bounds inParent bounds) not ])
				ifFalse: [ aRightElement visibility: BlVisibility hidden ] ].
]

{ #category : 'accessing' }
GtPlotterSingleScaleProportionalElement >> scale [
	<return: #GtPlotterScale>

	^ scale
]

{ #category : 'api - scale' }
GtPlotterSingleScaleProportionalElement >> scale: aGtPlotterScale [
	scale := aGtPlotterScale.
	self initializeElements
]

{ #category : 'api - scale' }
GtPlotterSingleScaleProportionalElement >> scaleData: aBlock [
	scaleData := aBlock.
	self initializeElements
]

{ #category : 'layout' }
GtPlotterSingleScaleProportionalElement >> shouldHideOverlapping [
	<return: #Boolean>

	^ shouldHideOverlapping
]

{ #category : 'accessing' }
GtPlotterSingleScaleProportionalElement >> showOverlapping [
	shouldHideOverlapping := false.
	self requestLayout
]

{ #category : 'accessing' }
GtPlotterSingleScaleProportionalElement >> weight [
	^ weight
]

{ #category : 'api - scale' }
GtPlotterSingleScaleProportionalElement >> weight: aNumber [
	weight := aNumber
]
