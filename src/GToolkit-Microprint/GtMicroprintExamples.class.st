"
Examples of attributed-text microprints, interval boundaries, whitespace and empty input.
"
Class {
	#name : #GtMicroprintExamples,
	#superclass : #Object,
	#category : #'GToolkit-Microprint-Examples'
}

{ #category : #examples }
GtMicroprintExamples >> emptyAndUncolored [
	<gtExample>
	| empty uncolored |
	empty := GtMicroprint fromRopedText: '' asRopedText.
	self assert: empty intervals isEmpty.
	self assert: empty marks isEmpty.
	self assert: empty extent equals: 1 @ 1.
	uncolored := GtMicroprint fromRopedText: 'abc' asRopedText.
	self assert: uncolored intervals isEmpty.
	self assert: uncolored marks size equals: 1.
	self assert: uncolored marks first value equals: Color veryLightGray.
	^ uncolored
]

{ #category : #examples }
GtMicroprintExamples >> intervalAcrossLines [
	<gtExample>
	| microprint selected isolated colored |
	microprint := GtMicroprint
			fromSource: 'abc' , String cr , 'def' , String cr , 'ghi'
			intervals: {(2 to: 6) -> Color blue.
					(9 to: 11) -> Color red}.
	selected := microprint intervals first.
	isolated := selected highlightedMicroprint.
	colored := isolated marks select: [ :each | each value = Color blue ].
	self assert: selected microprint == microprint.
	self assert: isolated extent equals: 3 @ 3.
	self
		assert: (colored collect: #key)
		equals: {1 @ 0 corner: 3 @ 1.
				0 @ 1 corner: 2 @ 2}.
	self assert: (isolated marks noneSatisfy: [ :each | each value = Color red ]).
	^ selected
]

{ #category : #examples }
GtMicroprintExamples >> isolatedInterval [
	<gtExample>
	| microprint interval isolated neutral |
	microprint := self multilineMulticolor.
	self
		assert: (microprint intervals
				allSatisfy: [ :each | each class = GtMicroprintInterval and: [ each microprint == microprint ] ]).
	interval := microprint intervals fourth.
	self assert: interval sourceText equals: 'orange'.
	isolated := interval highlightedMicroprint.
	neutral := GtMicroprint fromSource: microprint source intervals: #().
	self assert: isolated extent equals: microprint extent.
	self assert: isolated source equals: microprint source.
	self assert: isolated intervals size equals: 1.
	self assert: isolated intervals first interval equals: interval interval.
	self assert: isolated intervals first paint equals: interval paint.
	self assert: isolated intervals first microprint == isolated.
	self
		assert: (isolated marks select: [ :each | each value ~= Color veryLightGray ]) size
		equals: 1.
	self
		assert: (isolated marks detect: [ :each | each value = Color orange ]) key
		equals: (6 @ 1 corner: 12 @ 2).
	self
		assert: (isolated marks sum: [ :each | each key area ])
		equals: (neutral marks sum: [ :each | each key area ]).
	self assert: microprint intervals size equals: 5.
	^ interval
]

{ #category : #examples }
GtMicroprintExamples >> multilineMulticolor [
	<gtExample>
	| text microprint |
	text := ('red blue' , String cr , 'green orange' , String cr , String cr
			, 'violet') asRopedText.
	(text from: 1 to: 3) foreground: Color red.
	(text from: 5 to: 8) foreground: Color blue.
	(text from: 10 to: 14) foreground: Color green.
	(text from: 16 to: 21) foreground: Color orange.
	(text from: 24 to: 29) foreground: Color magenta.
	microprint := GtMicroprint fromRopedText: text.
	self assert: microprint extent x equals: 12.
	self assert: microprint extent y equals: 4.
	self assert: microprint intervals size equals: 5.
	self assert: microprint marks size equals: 5.
	self
		assert: (microprint marks collect: #value)
		equals: {Color red.
				Color blue.
				Color green.
				Color orange.
				Color magenta}.
	self assert: microprint marks last key equals: (0 @ 3 corner: 6 @ 4).
	^ microprint
]

{ #category : #examples }
GtMicroprintExamples >> ropedText [
	<gtExample>
	| text microprint |
	text := ('alpha beta' , String cr , 'gamma 42') asRopedText.
	(text from: 1 to: 5) foreground: Color blue.
	(text from: 1 to: 2) bold.
	(text from: 7 to: 10) foreground: Color red.
	(text from: 17 to: 18) foreground: Color green.
	microprint := GtMicroprint fromRopedText: text.
	self assert: microprint source equals: text asString.
	self assert: microprint intervals size equals: 3.
	self assert: microprint intervals first interval equals: (1 to: 5).
	self assert: microprint intervals first paint equals: Color blue.
	self assert: microprint intervals last interval equals: (17 to: 18).
	self assert: microprint marks first key equals: (0 @ 0 corner: 5 @ 1).
	self assert: microprint marks first value equals: Color blue.
	self assert: microprint extent equals: 10 @ 2.
	^ microprint
]

{ #category : #examples }
GtMicroprintExamples >> whitespaceAndLineEndings [
	<gtExample>
	| source microprint text |
	source := 'a' , String tab , 'b' , String crlf , 'c' , String lf , 'd'.
	text := source asRopedText foreground: Color blue.
	microprint := GtMicroprint fromRopedText: text.
	self assert: microprint extent equals: 4 @ 3.
	self assert: microprint marks size equals: 4.
	self assert: microprint marks second key equals: (3 @ 0 corner: 4 @ 1).
	self assert: microprint marks third key equals: (0 @ 1 corner: 1 @ 2).
	self assert: (microprint marks allSatisfy: [ :each | each value = Color blue ]).
	^ microprint
]
