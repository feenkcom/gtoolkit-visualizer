"
A compact colored text representation. Owns GtMicroprintInterval objects with one-based inclusive character ranges, paints and links back to this microprint. Construct from source and interval-to-paint associations, or derive intervals from foreground runs of attributed text. Spaces and tabs remain blank; tabs occupy two columns. Consecutive marks of the same paint are batched into rectangles. Rendering uses no text editors.
"
Class {
	#name : #GtMicroprint,
	#superclass : #Object,
	#instVars : [
		'source',
		'intervals',
		'marks',
		'extent'
	],
	#category : #'GToolkit-Microprint'
}

{ #category : #'instance creation' }
GtMicroprint class >> fromRopedText: aText [
	| coloredIntervals text |
	text := aText asRopedText.
	coloredIntervals := OrderedCollection new.
	text
		attributeRunsDo: [ :start :stop :attributes | 
			| foreground first last |
			first := start max: 1.
			last := stop min: text size.
			foreground := attributes reversed
					detect: [ :each | each isKindOf: BlTextForegroundAttribute ]
					ifNone: [ nil ].
			(foreground notNil and: [ last >= first ])
				ifTrue: [ (coloredIntervals notEmpty
						and: [ coloredIntervals last key last + 1 = first
								and: [ coloredIntervals last value = foreground paint ] ])
						ifTrue: [ | previous |
							previous := coloredIntervals removeLast.
							coloredIntervals add: (previous key first to: last) -> foreground paint ]
						ifFalse: [ coloredIntervals add: (first to: last) -> foreground paint ] ] ].
	^ self fromSource: text asString intervals: coloredIntervals
]

{ #category : #'instance creation' }
GtMicroprint class >> fromSource: aString intervals: coloredIntervals [
	^ self new initializeSource: aString intervals: coloredIntervals
]

{ #category : #accessing }
GtMicroprint >> asElement [
	^ BlSpartaElement new
		size: extent;
		background: Color white;
		rendering: [ :canvas :element | self drawOn: canvas ];
		yourself
]

{ #category : #private }
GtMicroprint >> buildMarks [
	| rectangles intervalIndex width row |
	rectangles := OrderedCollection new.
	intervalIndex := 1.
	width := 0.
	row := 0.
	source
		lineIndicesDo: [ :start :end :endWithSeparators | 
			| column runStart runPaint flush |
			column := 0.
			runStart := nil.
			flush := [ runStart
					ifNotNil: [ rectangles add: (runStart @ row corner: column @ (row + 1)) -> runPaint.
						runStart := nil ] ].
			start
				to: end
				do: [ :index | 
					| character paint |
					character := source at: index.
					[ intervalIndex <= intervals size
						and: [ (intervals at: intervalIndex) stop < index ] ]
						whileTrue: [ intervalIndex := intervalIndex + 1 ].
					paint := (intervalIndex <= intervals size
							and: [ (intervals at: intervalIndex) start <= index ])
							ifTrue: [ (intervals at: intervalIndex) paint ]
							ifFalse: [ Color veryLightGray ].
					(character = Character space or: [ character = Character tab ])
						ifTrue: [ flush value.
							column := column
									+ (character = Character tab ifTrue: [ 2 ] ifFalse: [ 1 ]) ]
						ifFalse: [ (runStart notNil and: [ runPaint ~= paint ])
								ifTrue: [ flush value ].
							runStart
								ifNil: [ runStart := column.
									runPaint := paint ].
							column := column + 1 ] ].
			flush value.
			width := width max: column.
			row := row + 1 ].
	marks := rectangles asArray.
	extent := (width max: 1) @ (row max: 1)
]

{ #category : #accessing }
GtMicroprint >> drawOn: aCanvas [
	marks
		do: [ :mark | 
			aCanvas fill
				antialiasNone;
				path: mark key;
				paint: mark value;
				draw ]
]

{ #category : #accessing }
GtMicroprint >> extent [
	^ extent
]

{ #category : #'gt-extensions' }
GtMicroprint >> gtIntervalsFor: aView [
	"Which source character intervals supply the microprint colors?"

	<gtView>
	^ aView columnedList
		title: 'Intervals';
		priority: 20;
		items: [ intervals ];
		column: 'Interval' text: #interval;
		column: 'Paint' text: #paint
]

{ #category : #'gt-extensions' }
GtMicroprint >> gtMicroprintFor: aView [
	"What shape and color distribution does this source have?"

	<gtView>
	^ aView explicit
		title: 'Microprint';
		priority: 10;
		stencil: [ self asElement asScalableElement ]
]

{ #category : #initialization }
GtMicroprint >> initializeSource: aString intervals: coloredIntervals [
	source := aString asString copy.
	intervals := (coloredIntervals
			collect: [ :each | 
				GtMicroprintInterval
					microprint: self
					interval: each key
					paint: each value ]) asArray
			sorted: [ :left :right | left start < right start ].
	intervals
		withIndexDo: [ :each :index | 
			self assert: each interval notEmpty.
			self assert: (each start >= 1 and: [ each stop <= source size ]).
			index > 1
				ifTrue: [ self assert: (intervals at: index - 1) stop < each start ] ].
	self buildMarks.
	^ self
]

{ #category : #accessing }
GtMicroprint >> intervals [
	^ intervals
]

{ #category : #accessing }
GtMicroprint >> marks [
	^ marks
]

{ #category : #accessing }
GtMicroprint >> source [
	^ source
]
