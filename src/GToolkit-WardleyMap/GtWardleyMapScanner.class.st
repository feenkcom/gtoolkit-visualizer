Class {
	#name : #GtWardleyMapScanner,
	#superclass : #SmaCCScanner,
	#category : #'GToolkit-WardleyMap-Parser'
}

{ #category : #'generated-initialization' }
GtWardleyMapScanner class >> initializeKeywordMap [
	keywordMap := Dictionary new.
	#(#(20 '+''' #(6 #(#default #name))))
		do: [ :each | 
			(keywordMap at: each first ifAbsentPut: [ Dictionary new ])
				at: (each at: 2)
				put: each last ].
	^ keywordMap
]

{ #category : #generated }
GtWardleyMapScanner >> emptySymbolTokenId [
	^ 94
]

{ #category : #generated }
GtWardleyMapScanner >> errorTokenId [
	^ 95
]

{ #category : #generated }
GtWardleyMapScanner >> floatId [
	^ 18
]

{ #category : #generated }
GtWardleyMapScanner >> nameId [
	^ 93
]

{ #category : #private }
GtWardleyMapScanner >> nodeName [
	| ids peekChar |
	ids := {self nameId}.
	self recordMatch: ids.
	self step.
	[ [ currentCharacter isSeparator ]
		whileTrue:
			[ (String crlf includes: currentCharacter) ifTrue: [ ^ self reportLastMatch ].
			self step ].
			
	[ currentCharacter = $[ ifTrue: [ ^ self reportLastMatch ].
	currentCharacter = $+
		ifTrue:
			[ peekChar := stream peek.
			('<>''' includes: peekChar) ifTrue: [ ^ self reportLastMatch ] ].
	currentCharacter = $- ifTrue: [ stream peek = $> ifTrue: [ ^ self reportLastMatch ] ].
	self recordMatch: ids.
	self step.
	(String crlf includes: currentCharacter) ifTrue: [ ^ self reportLastMatch ].
	currentCharacter isSeparator ] whileFalse.
	true ] whileTrue
]

{ #category : #generated }
GtWardleyMapScanner >> scan1 [
	self step.
	currentCharacter == $' ifTrue: [ ^ self scan2 ].
	currentCharacter == $( ifTrue: [ ^ self recordAndReportMatch: #(4 20) ].
	currentCharacter == $) ifTrue: [ ^ self recordAndReportMatch: #(5 20) ].
	currentCharacter == $+ ifTrue: [ ^ self scan3 ].
	currentCharacter == $, ifTrue: [ ^ self recordAndReportMatch: #(10 20) ].
	currentCharacter == $- ifTrue: [ ^ self scan1X5 ].
	currentCharacter == $/ ifTrue: [ ^ self scan1X2 ].
	currentCharacter == $[ ifTrue: [ ^ self recordAndReportMatch: #(12) ].
	currentCharacter == $] ifTrue: [ ^ self recordAndReportMatch: #(13) ].
	^ self scan1X20
]

{ #category : #generated }
GtWardleyMapScanner >> scan1X1 [
	self recordMatch: #(20).
	self step.
	currentCharacter == $c
		ifTrue: [ (self scanForString: 'osystem') ifTrue: [ ^ self recordAndReportMatch: #(31) ].
			^ self reportLastMatch ].
	currentCharacter == $v
		ifTrue: [ (self scanForString: 'ol')
				ifTrue: [ self step.
					currentCharacter == $u
						ifTrue: [ (self scanForString: 'tion') ifTrue: [ ^ self recordAndReportMatch: #(32) ].
							^ self reportLastMatch ].
					currentCharacter == $v
						ifTrue: [ self step.
							currentCharacter == $e ifTrue: [ ^ self recordAndReportMatch: #(33) ] ] ] ].
	^ self reportLastMatch
]

{ #category : #generated }
GtWardleyMapScanner >> scan1X10 [
	self recordMatch: #(20).
	self step.
	currentCharacter == $u
		ifTrue: [ (self scanForString: 'tsource') ifTrue: [ ^ self recordAndReportMatch: #(38) ] ].
	^ self reportLastMatch
]

{ #category : #generated }
GtWardleyMapScanner >> scan1X11 [
	self recordMatch: #(20).
	self step.
	currentCharacter == $o
		ifTrue: [ (self scanForString: 'te') ifTrue: [ ^ self recordAndReportMatch: #(37) ] ].
	^ self reportLastMatch
]

{ #category : #generated }
GtWardleyMapScanner >> scan1X12 [
	self recordMatch: #(20).
	self step.
	currentCharacter == $a
		ifTrue: [ (self scanForString: 'rket') ifTrue: [ ^ self recordAndReportMatch: #(36) ] ].
	^ self reportLastMatch
]

{ #category : #generated }
GtWardleyMapScanner >> scan1X13 [
	self recordMatch: #(20).
	self step.
	currentCharacter == $a
		ifTrue: [ (self scanForString: 'bel') ifTrue: [ ^ self recordAndReportMatch: #(35) ] ].
	^ self reportLastMatch
]

{ #category : #generated }
GtWardleyMapScanner >> scan1X14 [
	self recordMatch: #(20).
	self step.
	currentCharacter == $n
		ifTrue: [ (self scanForString: 'ertia') ifTrue: [ ^ self recordAndReportMatch: #(34) ] ].
	^ self reportLastMatch
]

{ #category : #generated }
GtWardleyMapScanner >> scan1X15 [
	self recordMatch: #(20).
	self step.
	currentCharacter == $o
		ifTrue: [ (self scanForString: 'mponent') ifTrue: [ ^ self recordAndReportMatch: #(30) ] ].
	^ self reportLastMatch
]

{ #category : #generated }
GtWardleyMapScanner >> scan1X16 [
	[ self recordMatch: #(17).
	self step.
	currentCharacter == Character tab
		or: [ currentCharacter == Character pageUp
				or: [ currentCharacter == Character space ] ] ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
GtWardleyMapScanner >> scan1X17 [
	self recordMatch: #(20).
	self step.
	currentCharacter == $r
		ifTrue: [ self step.
			currentCharacter == $l ifTrue: [ ^ self recordAndReportMatch: #(46) ] ].
	^ self reportLastMatch
]

{ #category : #generated }
GtWardleyMapScanner >> scan1X18 [
	[ self recordMatch: #(22).
	self step.
	currentCharacter == Character lf or: [ currentCharacter == Character cr ] ]
		whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
GtWardleyMapScanner >> scan1X19 [
	currentCharacter == $u ifTrue: [ ^ self scan1X17 ].
	currentCharacter == $y ifTrue: [ ^ self scan1X9 ].
	currentCharacter == ${ ifTrue: [ ^ self recordAndReportMatch: #(14 20) ].
	currentCharacter == $} ifTrue: [ ^ self recordAndReportMatch: #(15 20) ].
	currentCharacter isDigit ifTrue: [ ^ self scan4 ].
	(currentCharacter == Character lf or: [ currentCharacter == Character cr ])
		ifTrue: [ ^ self scan1X18 ].
	((currentCharacter between: Character tab and: Character pageUp)
		or: [ currentCharacter == Character space ]) ifTrue: [ ^ self scan1X16 ].
	(currentCharacter <= Character backspace
		or: [ currentCharacter >= (Character value: 14) ])
		ifTrue: [ ^ self recordAndReportMatch: #(20) ].
	^ self reportLastMatch
]

{ #category : #generated }
GtWardleyMapScanner >> scan1X2 [
	self recordMatch: #(20).
	self step.
	currentCharacter == $/
		ifTrue: [ [ self recordMatch: #(21).
			self step.
			currentCharacter <= Character tab
				or: [ (currentCharacter between: Character pageUp and: Character newPage)
						or: [ currentCharacter >= (Character value: 14) ] ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GtWardleyMapScanner >> scan1X20 [
	currentCharacter == $a ifTrue: [ ^ self scan1X4 ].
	currentCharacter == $b ifTrue: [ ^ self scan1X8 ].
	currentCharacter == $c ifTrue: [ ^ self scan1X15 ].
	currentCharacter == $e ifTrue: [ ^ self scan1X1 ].
	currentCharacter == $i ifTrue: [ ^ self scan1X14 ].
	currentCharacter == $l ifTrue: [ ^ self scan1X13 ].
	currentCharacter == $m ifTrue: [ ^ self scan1X12 ].
	currentCharacter == $n ifTrue: [ ^ self scan1X11 ].
	currentCharacter == $o ifTrue: [ ^ self scan1X10 ].
	currentCharacter == $p ifTrue: [ ^ self scan1X6 ].
	currentCharacter == $s ifTrue: [ ^ self scan1X3 ].
	currentCharacter == $t ifTrue: [ ^ self scan1X7 ].
	^ self scan1X19
]

{ #category : #generated }
GtWardleyMapScanner >> scan1X3 [
	self recordMatch: #(20).
	self step.
	currentCharacter == $e
		ifTrue: [ (self scanForString: 'ttlers') ifTrue: [ ^ self recordAndReportMatch: #(41) ].
			^ self reportLastMatch ].
	currentCharacter == $t
		ifTrue: [ (self scanForString: 'yle') ifTrue: [ ^ self recordAndReportMatch: #(42) ].
			^ self reportLastMatch ].
	currentCharacter == $u
		ifTrue: [ (self scanForString: 'bmap') ifTrue: [ ^ self recordAndReportMatch: #(43) ] ].
	^ self reportLastMatch
]

{ #category : #generated }
GtWardleyMapScanner >> scan1X4 [
	self recordMatch: #(20).
	self step.
	currentCharacter == $n
		ifTrue: [ self step.
			currentCharacter == $c
				ifTrue: [ (self scanForString: 'hor') ifTrue: [ ^ self recordAndReportMatch: #(25) ].
					^ self reportLastMatch ].
			currentCharacter == $n
				ifTrue: [ (self scanForString: 'otation')
						ifTrue: [ self recordMatch: #(26).
							self step.
							currentCharacter == $s ifTrue: [ ^ self recordAndReportMatch: #(27) ] ] ] ].
	^ self reportLastMatch
]

{ #category : #generated }
GtWardleyMapScanner >> scan1X5 [
	self step.
	currentCharacter == $> ifTrue: [ ^ self recordAndReportMatch: #(11) ].
	currentCharacter isDigit ifTrue: [ ^ self scan4 ].
	(currentCharacter <= $Z
		or: [ currentCharacter == $\ or: [ currentCharacter >= $^ ] ])
		ifTrue: [ ^ self recordAndReportMatch: #(20) ].
	^ self reportLastMatch
]

{ #category : #generated }
GtWardleyMapScanner >> scan1X6 [
	self recordMatch: #(20).
	self step.
	currentCharacter == $i
		ifTrue: [ self step.
			currentCharacter == $o
				ifTrue: [ (self scanForString: 'neers') ifTrue: [ ^ self recordAndReportMatch: #(39) ].
					^ self reportLastMatch ].
			currentCharacter == $p
				ifTrue: [ (self scanForString: 'eline') ifTrue: [ ^ self recordAndReportMatch: #(40) ] ] ].
	^ self reportLastMatch
]

{ #category : #generated }
GtWardleyMapScanner >> scan1X7 [
	self recordMatch: #(20).
	self step.
	currentCharacter == $i
		ifTrue: [ (self scanForString: 'tle') ifTrue: [ ^ self recordAndReportMatch: #(44) ].
			^ self reportLastMatch ].
	currentCharacter == $o
		ifTrue: [ (self scanForString: 'wnplanners')
				ifTrue: [ ^ self recordAndReportMatch: #(45) ] ].
	^ self reportLastMatch
]

{ #category : #generated }
GtWardleyMapScanner >> scan1X8 [
	self recordMatch: #(20).
	self step.
	currentCharacter == $u
		ifTrue: [ self step.
			currentCharacter == $i
				ifTrue: [ (self scanForString: 'ld') ifTrue: [ ^ self recordAndReportMatch: #(28) ].
					^ self reportLastMatch ].
			currentCharacter == $y ifTrue: [ ^ self recordAndReportMatch: #(29) ] ].
	^ self reportLastMatch
]

{ #category : #generated }
GtWardleyMapScanner >> scan1X9 [
	self recordMatch: #(20).
	self step.
	currentCharacter == $-
		ifTrue: [ (self scanForString: 'axis') ifTrue: [ ^ self recordAndReportMatch: #(47) ] ].
	^ self reportLastMatch
]

{ #category : #generated }
GtWardleyMapScanner >> scan2 [
	self recordMatch: #(20).
	self step.
	currentCharacter == $<
		ifTrue: [ self recordMatch: #(1).
			self step.
			currentCharacter == $> ifTrue: [ ^ self recordAndReportMatch: #(2) ].
			^ self reportLastMatch ].
	currentCharacter == $> ifTrue: [ ^ self recordAndReportMatch: #(3) ].
	^ self reportLastMatch
]

{ #category : #generated }
GtWardleyMapScanner >> scan3 [
	self recordMatch: #(20).
	self step.
	currentCharacter == $<
		ifTrue: [ self recordMatch: #(7).
			self step.
			currentCharacter == $> ifTrue: [ ^ self recordAndReportMatch: #(8) ].
			^ self reportLastMatch ].
	currentCharacter == $> ifTrue: [ ^ self recordAndReportMatch: #(9) ].
	(currentCharacter <= $Z
		or: [ currentCharacter == $\ or: [ currentCharacter >= $^ ] ])
		ifTrue: [ ^ self recordAndReportMatch: #(20) ].
	^ self reportLastMatch
]

{ #category : #generated }
GtWardleyMapScanner >> scan4 [
	self recordMatch: #(18 20).
	self step.
	currentCharacter == $. ifTrue: [ ^ self scan5 ].
	currentCharacter isDigit
		ifTrue: [ [ self recordMatch: #(18).
			self step.
			currentCharacter == $. ifTrue: [ ^ self scan5 ].
			currentCharacter isDigit ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GtWardleyMapScanner >> scan5 [
	self step.
	currentCharacter isDigit
		ifTrue: [ [ self recordMatch: #(18).
			self step.
			currentCharacter isDigit ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GtWardleyMapScanner >> scan6 [
	[ self recordMatch: #(19).
	self step.
	(currentCharacter isSeparator or: [ currentCharacter == Character pageUp ])
		ifTrue: [ ^ self scan7 ].
	true ] whileTrue
]

{ #category : #generated }
GtWardleyMapScanner >> scan7 [
	[ self step.
	currentCharacter == $-
		ifTrue: [ self step.
			currentCharacter ~~ $> ifTrue: [ ^ self scan6 ].
			^ self reportLastMatch ].
	currentCharacter isSeparator or: [ currentCharacter == Character pageUp ] ]
		whileTrue.
	(currentCharacter <= $/ or: [ currentCharacter >= $: ])
		ifTrue: [ [ self recordMatch: #(19).
			self step.
			(currentCharacter isSeparator or: [ currentCharacter == Character pageUp ])
				ifTrue: [ ^ self scan7 ].
			currentCharacter <= $= or: [ currentCharacter >= $? ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GtWardleyMapScanner >> scan8 [
	[ self recordMatch: #(23).
	self step.
	(currentCharacter == Character tab
		or: [ (currentCharacter between: Character pageUp and: Character newPage)
				or: [ currentCharacter == Character space ] ])
		ifTrue: [ [ self step.
			currentCharacter == Character tab
				or: [ (currentCharacter between: Character pageUp and: Character newPage)
						or: [ currentCharacter == Character space ] ] ] whileTrue.
			(currentCharacter <= Character backspace
				or: [ (currentCharacter between: (Character value: 14) and: $.)
						or: [ (currentCharacter between: $0 and: $:) or: [ currentCharacter >= $< ] ] ])
				ifTrue: [ ^ self scan8 ].
			^ self reportLastMatch ].
	currentCharacter <= Character backspace
		or: [ (currentCharacter between: (Character value: 14) and: $.)
				or: [ (currentCharacter between: $0 and: $:) or: [ currentCharacter >= $< ] ] ] ]
		whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
GtWardleyMapScanner >> scanForToken [
	scope == #nameWithoutSemicolon ifTrue: [ ^ self scanForTokenX1 ].
	scope == #nameWithoutNumberAndArrow ifTrue: [ ^ self scanForTokenX3 ].
	scope == #title ifTrue: [ ^ self scanForTokenX2 ].
	scope == #default ifTrue: [ ^ self scan1 ].
	scope == #name
		ifTrue: [ self step.
			currentCharacter == $' ifTrue: [ ^ self scan2 ].
			currentCharacter == $( ifTrue: [ ^ self recordAndReportMatch: #(4 20) ].
			currentCharacter == $) ifTrue: [ ^ self recordAndReportMatch: #(5 20) ].
			currentCharacter == $+ ifTrue: [ ^ self scan3 ].
			currentCharacter == $, ifTrue: [ ^ self recordAndReportMatch: #(10 20) ].
			currentCharacter == $- ifTrue: [ ^ self scanForTokenX4 ].
			currentCharacter == $[ ifTrue: [ ^ self recordAndReportMatch: #(12) ].
			currentCharacter == $] ifTrue: [ ^ self recordAndReportMatch: #(13) ].
			currentCharacter == ${ ifTrue: [ ^ self recordAndReportMatch: #(14 20) ].
			currentCharacter == $} ifTrue: [ ^ self recordAndReportMatch: #(15 20) ].
			(currentCharacter == Character lf or: [ currentCharacter == Character cr ])
				ifTrue: [ ^ self scanForTokenX6 ].
			((currentCharacter between: Character tab and: Character pageUp)
				or: [ currentCharacter == Character space ])
				ifTrue: [ ^ self scanForTokenX5 ].
			(currentCharacter <= Character backspace
				or: [ currentCharacter >= (Character value: 14) ])
				ifTrue: [ ^ self recordAndReportMatch: #(20) ] ].
	^ self reportLastMatch
]

{ #category : #generated }
GtWardleyMapScanner >> scanForTokenX1 [
	self step.
	currentCharacter == $/
		ifTrue: [ self step.
			currentCharacter == $/
				ifTrue: [ [ self recordMatch: #(21).
					self step.
					currentCharacter <= Character tab
						or: [ (currentCharacter between: Character pageUp and: Character newPage)
								or: [ currentCharacter >= (Character value: 14) ] ] ] whileTrue ].
			^ self reportLastMatch ].
	currentCharacter == $; ifTrue: [ ^ self recordAndReportMatch: #(24) ].
	(currentCharacter == Character lf or: [ currentCharacter == Character cr ])
		ifTrue: [ [ self recordMatch: #(22).
			self step.
			currentCharacter == Character lf or: [ currentCharacter == Character cr ] ]
				whileTrue.
			^ self reportLastMatch ].
	((currentCharacter between: Character tab and: Character pageUp)
		or: [ currentCharacter == Character space ])
		ifTrue: [ [ self recordMatch: #(17).
			self step.
			currentCharacter == Character tab
				or: [ currentCharacter == Character pageUp
						or: [ currentCharacter == Character space ] ] ] whileTrue.
			^ self reportLastMatch ].
	(currentCharacter <= Character backspace
		or: [ currentCharacter >= (Character value: 14) ]) ifTrue: [ ^ self scan8 ].
	^ self reportLastMatch
]

{ #category : #generated }
GtWardleyMapScanner >> scanForTokenX2 [
	self step.
	(currentCharacter == Character lf or: [ currentCharacter == Character cr ])
		ifTrue: [ [ self recordMatch: #(22).
			self step.
			currentCharacter == Character lf or: [ currentCharacter == Character cr ] ]
				whileTrue.
			^ self reportLastMatch ].
	((currentCharacter between: Character tab and: Character pageUp)
		or: [ currentCharacter == Character space ])
		ifTrue: [ [ self recordMatch: #(17).
			self step.
			currentCharacter == Character tab
				or: [ currentCharacter == Character pageUp
						or: [ currentCharacter == Character space ] ] ] whileTrue.
			^ self reportLastMatch ].
	(currentCharacter <= Character backspace
		or: [ currentCharacter >= (Character value: 14) ])
		ifTrue: [ [ self recordMatch: #(16).
			self step.
			currentCharacter <= Character tab
				or: [ (currentCharacter between: Character pageUp and: Character newPage)
						or: [ currentCharacter >= (Character value: 14) ] ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GtWardleyMapScanner >> scanForTokenX3 [
	self step.
	(currentCharacter == Character lf or: [ currentCharacter == Character cr ])
		ifTrue: [ [ self recordMatch: #(22).
			self step.
			currentCharacter == Character lf or: [ currentCharacter == Character cr ] ]
				whileTrue.
			^ self reportLastMatch ].
	((currentCharacter between: Character tab and: Character pageUp)
		or: [ currentCharacter == Character space ])
		ifTrue: [ [ self recordMatch: #(17).
			self step.
			currentCharacter == Character tab
				or: [ currentCharacter == Character pageUp
						or: [ currentCharacter == Character space ] ] ] whileTrue.
			^ self reportLastMatch ].
	(currentCharacter <= Character backspace
		or: [ currentCharacter >= (Character value: 14) ]) ifTrue: [ ^ self scan6 ].
	^ self reportLastMatch
]

{ #category : #generated }
GtWardleyMapScanner >> scanForTokenX4 [
	self step.
	currentCharacter == $> ifTrue: [ ^ self recordAndReportMatch: #(11) ].
	(currentCharacter <= $Z
		or: [ currentCharacter == $\ or: [ currentCharacter >= $^ ] ])
		ifTrue: [ ^ self recordAndReportMatch: #(20) ].
	^ self reportLastMatch
]

{ #category : #generated }
GtWardleyMapScanner >> scanForTokenX5 [
	[ self recordMatch: #(17).
	self step.
	currentCharacter == Character tab
		or: [ currentCharacter == Character pageUp
				or: [ currentCharacter == Character space ] ] ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
GtWardleyMapScanner >> scanForTokenX6 [
	[ self recordMatch: #(22).
	self step.
	currentCharacter == Character lf or: [ currentCharacter == Character cr ] ]
		whileTrue.
	^ self reportLastMatch
]

{ #category : #private }
GtWardleyMapScanner >> scanNameAt: anInteger [
	returnMatchBlock := [ :token | ^ token ].
	stream position: anInteger - 1.
	self resetScanner.
	^ self nodeName
]

{ #category : #generated }
GtWardleyMapScanner >> tokenActions [
	^ #(nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil #whitespace nil nil #nodeName #comment)
]
