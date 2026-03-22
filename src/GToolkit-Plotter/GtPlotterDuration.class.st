Class {
	#name : #GtPlotterDuration,
	#superclass : #Object,
	#instVars : [
		'amount'
	],
	#category : #'GToolkit-Plotter-Time'
}

{ #category : #accessing }
GtPlotterDuration class >> amount: aNumber [
	^ self new amount: aNumber
]

{ #category : #'instance creation' }
GtPlotterDuration class >> days: aNumber [
	^ GtPlotterDurationDay amount: aNumber
]

{ #category : #'instance creation' }
GtPlotterDuration class >> hours: aNumber [
	^ GtPlotterDurationHour amount: aNumber
]

{ #category : #'instance creation' }
GtPlotterDuration class >> milliSeconds: aNumber [
	^ GtPlotterDurationMillisecond amount: aNumber
]

{ #category : #'instance creation' }
GtPlotterDuration class >> minutes: aNumber [
	^ GtPlotterDurationMinute amount: aNumber
]

{ #category : #'instance creation' }
GtPlotterDuration class >> months: aNumber [
	^ GtPlotterDurationMonth amount: aNumber
]

{ #category : #'instance creation' }
GtPlotterDuration class >> seconds: aNumber [
	^ GtPlotterDurationSecond amount: aNumber
]

{ #category : #'instance creation' }
GtPlotterDuration class >> weeks: aNumber [
	^ GtPlotterDurationWeek amount: aNumber
]

{ #category : #'instance creation' }
GtPlotterDuration class >> years: aNumber [
	^ GtPlotterDurationYear amount: aNumber
]

{ #category : #accessing }
GtPlotterDuration >> amount [
	^ amount
]

{ #category : #accessing }
GtPlotterDuration >> amount: anObject [
	amount := anObject
]

{ #category : #converting }
GtPlotterDuration >> asDuration [
	^ self subclassResponsibility
]

{ #category : #initialization }
GtPlotterDuration >> initialize [
	super initialize.
	
	amount := 0
]

{ #category : #printing }
GtPlotterDuration >> name [
	^ self subclassResponsibility
]

{ #category : #printing }
GtPlotterDuration >> printOn: aStream [
	aStream
		print: self amount;
		space;
		nextPutAll: self name.
		
	self amount ~= 1
		ifTrue: [ aStream nextPut: $s ]
]
