"
A colored source interval owned by a microprint. Its microprint view retains the full source shape and shows only this interval in its paint; every other source mark is neutral.
"
Class {
	#name : #GtMicroprintInterval,
	#superclass : #Object,
	#instVars : [
		'microprint',
		'interval',
		'paint'
	],
	#category : #'GToolkit-Microprint'
}

{ #category : #accessing }
GtMicroprintInterval class >> microprint: aMicroprint interval: anInterval paint: aPaint [
	^ self new
		initializeMicroprint: aMicroprint
		interval: anInterval
		paint: aPaint
]

{ #category : #'gt-extensions' }
GtMicroprintInterval >> gtMicroprintFor: aView [
	"Where is this interval in the otherwise unhighlighted source shape?"

	<gtView>
	^ aView forward
		title: 'Microprint';
		priority: 10;
		object: [ self highlightedMicroprint ];
		view: #gtMicroprintFor:
]

{ #category : #accessing }
GtMicroprintInterval >> highlightedMicroprint [
	^ GtMicroprint fromSource: microprint source intervals: {interval -> paint}
]

{ #category : #accessing }
GtMicroprintInterval >> initializeMicroprint: aMicroprint interval: anInterval paint: aPaint [
	microprint := aMicroprint.
	interval := anInterval copy.
	paint := aPaint.
	^ self
]

{ #category : #accessing }
GtMicroprintInterval >> interval [
	^ interval
]

{ #category : #accessing }
GtMicroprintInterval >> microprint [
	^ microprint
]

{ #category : #accessing }
GtMicroprintInterval >> paint [
	^ paint
]

{ #category : #accessing }
GtMicroprintInterval >> printOn: aStream [
	aStream
		nextPutAll: 'Interval ';
		print: self start;
		nextPutAll: '-';
		print: self stop
]

{ #category : #accessing }
GtMicroprintInterval >> sourceText [
	^ microprint source copyFrom: self start to: self stop
]

{ #category : #accessing }
GtMicroprintInterval >> start [
	^ interval first
]

{ #category : #accessing }
GtMicroprintInterval >> stop [
	^ interval last
]
