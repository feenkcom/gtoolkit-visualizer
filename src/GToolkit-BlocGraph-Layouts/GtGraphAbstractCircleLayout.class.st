"
A ROAbstractCircleLayout is xxxxxxxxx.

Instance Variables
	factor:		<Object>
	initialAngle:		<Object>
	initialIncrementalAngle:		<Object>
	initialRadius:		<Object>

factor
	- xxxxx

initialAngle
	- xxxxx

initialIncrementalAngle
	- xxxxx

initialRadius
	- xxxxx


"
Class {
	#name : #GtGraphAbstractCircleLayout,
	#superclass : #GtGraphLayout,
	#instVars : [
		'initialAngle',
		'initialIncrementalAngle',
		'initialRadius',
		'factor'
	],
	#category : #'GToolkit-BlocGraph-Layouts-Layouts'
}

{ #category : #public }
GtGraphAbstractCircleLayout class >> isAbstract [
	^ self name = #GtGraphAbstractCircleLayout
]

{ #category : #hook }
GtGraphAbstractCircleLayout >> computeIncrementalAngleFor: elements [
	"Return the value _in radian_ of the incremental angle"
	
	^ initialIncrementalAngle = 0
		ifTrue: [ 2 * Float pi / elements size ]
		ifFalse: [ initialIncrementalAngle ]
]

{ #category : #hook }
GtGraphAbstractCircleLayout >> computeRadiusFor: elements [
	"Return the radius of the circle. If none has been set (i.e., initialRadius = 0), then it is computed as the scale factor times the number of elements"
	^ initialRadius = 0 
		ifTrue: [ elements size * self scaleFactor ]
		ifFalse: [ initialRadius ]
]

{ #category : #accessing }
GtGraphAbstractCircleLayout >> initialAngle [
	"Return the initial angle, in radian"
	^ initialAngle
]

{ #category : #accessing }
GtGraphAbstractCircleLayout >> initialAngle: aFloat [
	"aFloat is an angle in Radian."
	initialAngle := aFloat
]

{ #category : #accessing }
GtGraphAbstractCircleLayout >> initialAngleInDegree [ 
	"Return the initial angle in degree"
	^ self initialAngle * 180 / Float pi
]

{ #category : #accessing }
GtGraphAbstractCircleLayout >> initialAngleInDegree: aNumber [
	"Set the initial angle in radian"
	self initialAngle: aNumber * Float pi / 180
]

{ #category : #accessing }
GtGraphAbstractCircleLayout >> initialIncrementalAngle [
	"Return the initial incremental angle"
	^ initialIncrementalAngle
]

{ #category : #accessing }
GtGraphAbstractCircleLayout >> initialIncrementalAngle: aNumberInRadian [
	initialIncrementalAngle := aNumberInRadian
]

{ #category : #accessing }
GtGraphAbstractCircleLayout >> initialIncrementalAngleInDegree: aNumberInDegree [
	self initialIncrementalAngle: aNumberInDegree * Float pi / 180
]

{ #category : #accessing }
GtGraphAbstractCircleLayout >> initialRadius [
	"Return the radius in pixels of the circle"
	^ initialRadius
]

{ #category : #accessing }
GtGraphAbstractCircleLayout >> initialRadius: aNumber [
	"Set the radius of the circle"
	initialRadius := aNumber
]

{ #category : #'initialize-release' }
GtGraphAbstractCircleLayout >> initialize [
	"Initialize a newly created instance. This method must answer the receiver."
	
	super initialize.
	self scaleBy: 11.
	
	"Represent the initial angle to place the elements"
	initialAngle := 0.
	
	"Distance of the circle. If it is 0 when entering doExecute, then it is computed"
	initialRadius := 0.
	
	"0 means that it is computed, and not set by the user"
	initialIncrementalAngle := 0.
]

{ #category : #accessing }
GtGraphAbstractCircleLayout >> radius: aNumber [
	^ self initialRadius: aNumber
]

{ #category : #accessing }
GtGraphAbstractCircleLayout >> scaleBy: aNumber [
	
	factor := aNumber
]

{ #category : #accessing }
GtGraphAbstractCircleLayout >> scaleFactor [
	^ factor
]
