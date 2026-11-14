"
Examples of history-flow provenance, insertions, deletions, repeated lines, geometry and pointer interaction.
"
Class {
	#name : #GtHistoryFlowExamples,
	#superclass : #Object,
	#category : #'GToolkit-HistoryFlow-Examples'
}

{ #category : #examples }
GtHistoryFlowExamples >> clickNavigation [
	<gtExample>
	| flow element viewport scripter spawned |
	flow := self insertDeleteAndRewrite.
	element := flow asElement.
	spawned := OrderedCollection new.
	element
		when: GtPhlowObjectToSpawn
		do: [ :event | 
			spawned add: event object.
			event consumed: true ].
	viewport := element asScrollableElement.
	scripter := BlScripter new element: viewport.
	scripter pulseUntilReady.
	scripter mouseMove
		to: 4 @ 29;
		play.
	scripter mouseDown play.
	scripter mouseUp play.
	scripter pulseUntilReady.
	self assert: spawned size equals: 1.
	self assert: spawned last == flow versions first.
	scripter mouseMove
		to: 36 @ 29;
		play.
	scripter mouseDown play.
	scripter mouseUp play.
	scripter pulseUntilReady.
	self assert: spawned size equals: 2.
	self assert: spawned last == flow versions second.
	scripter mouseMove
		to: 132 @ 29;
		play.
	scripter mouseDown play.
	scripter mouseUp play.
	scripter pulseUntilReady.
	self assert: spawned size equals: 3.
	self assert: spawned last == flow versions third.
	scripter mouseMove
		to: 10 @ 20;
		play.
	scripter mouseDown play.
	scripter mouseUp play.
	scripter pulseUntilReady.
	self assert: spawned size equals: 3.
	^ flow
]

{ #category : #examples }
GtHistoryFlowExamples >> compilerPipelineHistory [
	"A larger synthetic document history with long-lived sections and localized edits."

	<gtExample>
	| intro parser lowering optimizer codegen diagnostics types profiling guards deopt metadata sections versions save flow final |
	intro := self sectionLines: 'Overview' count: 10.
	parser := self sectionLines: 'Parsing' count: 24.
	lowering := self sectionLines: 'Lowering' count: 32.
	optimizer := self sectionLines: 'Optimization' count: 44.
	codegen := self sectionLines: 'Code generation' count: 28.
	diagnostics := self sectionLines: 'Diagnostics' count: 14.
	sections := {intro.
			parser.
			lowering.
			optimizer.
			codegen.
			diagnostics} asOrderedCollection.
	versions := OrderedCollection new.
	save := [ :title | 
		| lines text |
		lines := sections flatCollect: [ :section | section ].
		text := String
				streamContents: [ :stream | lines do: [ :line | stream nextPutAll: line ] separatedBy: [ stream cr ] ].
		versions add: (GtHistoryFlowVersion title: title text: text) ].
	save value: '01 Initial compiler guide'.
	types := self sectionLines: 'Type checking' count: 20.
	sections add: types before: lowering.
	save value: '02 Add type checking'.
	1
		to: 8
		do: [ :index | parser at: index put: 'Revised parsing / paragraph ' , index asString ].
	save value: '03 Revise parser introduction'.
	profiling := self sectionLines: 'Profiling experiment' count: 24.
	sections add: profiling before: optimizer.
	save value: '04 Add profiling experiment'.
	sections remove: diagnostics.
	save value: '05 Remove obsolete diagnostics'.
	optimizer addAll: (self sectionLines: 'New optimization rules' count: 30).
	save value: '06 Expand optimization rules'.
	sections
		at: (sections indexOf: lowering)
		put: (self sectionLines: 'SSA lowering' count: 22).
	save value: '07 Replace lowering with SSA'.
	guards := self sectionLines: 'Guard simplification' count: 18.
	sections add: guards before: codegen.
	save value: '08 Introduce guard simplification'.
	sections remove: profiling.
	save value: '09 Abandon profiling experiment'.
	codegen addAll: (self sectionLines: 'Register allocation' count: 12).
	save value: '10 Extend code generation'.
	deopt := self sectionLines: 'Deoptimization' count: 30.
	sections add: deopt before: codegen.
	save value: '11 Add deoptimization'.
	30 timesRepeat: [ optimizer removeLast ].
	save value: '12 Prune experimental optimization rules'.
	sections remove: guards.
	save value: '13 Fold guard section into optimizer'.
	sections
		at: (sections indexOf: parser)
		put: (self sectionLines: 'Compact parser guide' count: 16).
	save value: '14 Rewrite parser guide'.
	metadata := self sectionLines: 'Runtime metadata' count: 26.
	sections add: metadata before: deopt.
	save value: '15 Document runtime metadata'.
	sections at: 1 put: (self sectionLines: 'Final overview' count: 8).
	save value: '16 Finalize overview'.
	flow := GtHistoryFlow fromVersions: versions.
	self assert: flow versions size equals: 16.
	self assert: flow versions first lines size equals: 152.
	final := flow versions last.
	self assert: final lines size equals: 206.
	self assert: (final origins at: (final lines indexOf: codegen first)) equals: 1.
	self assert: (final origins at: (final lines indexOf: types first)) equals: 2.
	self
		assert: (final origins at: (final lines indexOf: metadata first))
		equals: 15.
	self assert: final origins first equals: 16.
	self assert: (final lines includes: diagnostics first) not.
	self assert: (final lines includes: profiling first) not.
	self assert: (final lines includes: guards first) not.
	^ flow
]

{ #category : #examples }
GtHistoryFlowExamples >> configurableDimensions [
	<gtExample>
	| flow element connection vertices viewport scripter |
	flow := self insertDeleteAndRewrite.
	element := GtHistoryFlowElement new
			lineHeight: 5;
			versionWidth: 24;
			gapWidth: 90;
			flow: flow.
	viewport := element asScrollableElement.
	scripter := BlScripter new element: viewport.
	scripter pulseUntilReady.
	self assert: element lineHeight equals: 5.
	self assert: element versionWidth equals: 24.
	self assert: element gapWidth equals: 90.
	self assert: element extent equals: 366 @ 48.
	self assert: element bars first first width equals: 24.
	connection := flow connections first.
	vertices := element verticesFor: connection.
	self assert: vertices first x equals: 24.
	self assert: vertices second x equals: 114.
	self assert: vertices second x - vertices first x equals: 90.
	self assert: vertices third y - vertices second y equals: connection length * 5.
	scripter mouseMove
		to: 114 @ 30;
		play.
	scripter pulseUntilReady.
	self assert: element hoveredVersion equals: 2.
	element gapWidth: 20.
	scripter pulseUntilReady.
	self assert: element versionWidth equals: 24.
	self assert: element bars first first width equals: 24.
	self assert: element extent equals: 156 @ 48.
	element
		versionWidth: 4;
		lineHeight: 3.
	scripter pulseUntilReady.
	self assert: element flow == flow.
	self assert: element hoveredVersion equals: 2.
	self assert: element gapWidth equals: 20.
	self assert: element extent equals: 76 @ 40.
	self assert: (element versionX: 2) equals: 24.
	self assert: element bars first first width equals: 4.
	element gapWidth: 0.
	scripter pulseUntilReady.
	self assert: element extent equals: 16 @ 40.
	self
		assert: ([ element lineHeight: 0.
			false ] on: AssertionFailure do: [ :error | true ]).
	self
		assert: ([ element versionWidth: 0.
			false ] on: AssertionFailure do: [ :error | true ]).
	self
		assert: ([ element gapWidth: -1.
			false ] on: AssertionFailure do: [ :error | true ]).
	^ flow
]

{ #category : #examples }
GtHistoryFlowExamples >> emptyAndReintroduced [
	<gtExample>
	| empty flow |
	empty := GtHistoryFlow fromVersions: #().
	self assert: empty versions isEmpty.
	self assert: empty connections isEmpty.
	flow := GtHistoryFlow
			fromVersions: {GtHistoryFlowVersion title: 'First' text: 'x'.
					GtHistoryFlowVersion title: 'Empty' text: ''.
					GtHistoryFlowVersion title: 'Reintroduced' text: 'x'}.
	self assert: flow connections isEmpty.
	self assert: flow versions second origins isEmpty.
	self assert: flow versions third origins equals: #(3).
	^ flow
]

{ #category : #examples }
GtHistoryFlowExamples >> geometryAndHover [
	<gtExample>
	| flow element viewport scripter connection vertices |
	flow := self insertDeleteAndRewrite.
	element := flow asElement.
	viewport := element asScrollableElement.
	scripter := BlScripter new element: viewport.
	scripter pulseUntilReady.
	self assert: element extent equals: 200 @ 36.
	self assert: element bands size equals: flow connections size.
	self assert: element hoverTitle visibility isHidden.
	connection := flow connections first.
	vertices := element verticesFor: connection.
	self assert: vertices first equals: vertices last.
	self assert: vertices second x > vertices first x.
	self assert: vertices third y - vertices second y equals: connection length * 2.
	scripter mouseMove
		to: 64 @ 30;
		play.
	scripter pulseUntilReady.
	self assert: element hoveredVersion equals: 2.
	self assert: element hoverTitle text asString equals: 'Insert'.
	self assert: element hoverTitle visibility isVisible.
	scripter mouseMove
		to: 10 @ 200;
		play.
	scripter pulseUntilReady.
	self assert: element hoverTitle visibility isHidden.
	^ flow
]

{ #category : #examples }
GtHistoryFlowExamples >> identicalAndRepeatedLines [
	<gtExample>
	| flow |
	flow := GtHistoryFlow
			fromVersions: {GtHistoryFlowVersion
						title: 'First'
						text: 'a' , String crlf , 'a' , String crlf , 'b'.
					GtHistoryFlowVersion
						title: 'Identical'
						text: 'a' , String cr , 'a' , String cr , 'b'.
					GtHistoryFlowVersion title: 'Shorter' text: 'a' , String lf , 'b'}.
	self assert: flow versions second origins equals: #(1 1 1).
	self assert: flow versions third origins equals: #(1 1).
	self assert: flow connections first length equals: 3.
	self assert: flow connections first originIndex equals: 1.
	self
		assert: ((flow connections select: [ :c | c targetVersion index = 3 ]) sum: #length)
		equals: 2.
	^ flow
]

{ #category : #examples }
GtHistoryFlowExamples >> incomingTransitionHover [
	<gtExample>
	| flow element viewport scripter |
	flow := self insertDeleteAndRewrite.
	element := flow asElement.
	viewport := element asScrollableElement.
	scripter := BlScripter new element: viewport.
	scripter pulseUntilReady.
	2
		to: flow versions size
		do: [ :index | 
			scripter mouseMove
				to: (element versionX: index) @ 30;
				play.
			scripter pulseUntilReady.
			self assert: element hoveredVersion equals: index.
			self
				assert: ((flow versions
						select: [ :version | (element alphaForVersion: version index) = 1 ])
						collect: #index)
				equals: {index - 1.
						index}.
			self
				assert: (flow connections
						allSatisfy: [ :connection | 
							(element alphaFor: connection)
								= (connection targetVersion index = index ifTrue: [ 0.8 ] ifFalse: [ 0.12 ]) ]) ].
	scripter mouseMove
		to: 2 @ 30;
		play.
	scripter pulseUntilReady.
	self assert: element hoveredVersion equals: 1.
	self assert: element hoverTitle visibility isVisible.
	self assert: element hoverTitle text asString equals: flow versions first title.
	self
		assert: ((flow versions
				select: [ :version | (element alphaForVersion: version index) = 1 ])
				collect: #index)
		equals: #(1).
	self
		assert: (flow connections
				allSatisfy: [ :connection | (element alphaFor: connection) = 0.12 ]).
	scripter mouseMove
		to: 10 @ 200;
		play.
	scripter pulseUntilReady.
	self assert: element hoveredVersion isNil.
	self assert: element hoverTitle visibility isHidden.
	self
		assert: (flow connections
				allSatisfy: [ :connection | (element alphaFor: connection) = 0.5 ]).
	self
		assert: (flow versions
				allSatisfy: [ :version | (element alphaForVersion: version index) = 1 ]).
	^ flow
]

{ #category : #examples }
GtHistoryFlowExamples >> insertDeleteAndRewrite [
	<gtExample>
	| flow |
	flow := GtHistoryFlow
			fromVersions: {GtHistoryFlowVersion
						title: 'Initial'
						text: 'alpha' , String cr , 'beta' , String cr , 'gamma'.
					GtHistoryFlowVersion
						title: 'Insert'
						text: 'alpha' , String cr , 'inserted' , String cr , 'beta' , String cr , 'gamma'.
					GtHistoryFlowVersion
						title: 'Delete'
						text: 'alpha' , String cr , 'inserted' , String cr , 'gamma'.
					GtHistoryFlowVersion
						title: 'Rewrite'
						text: 'alpha' , String cr , 'revised' , String cr , 'gamma'}.
	self assert: flow versions first origins equals: #(1 1 1).
	self assert: flow versions second origins equals: #(1 2 1 1).
	self assert: flow versions third origins equals: #(1 2 1).
	self assert: flow versions fourth origins equals: #(1 4 1).
	self assert: (flow versions allSatisfy: [ :version | version flow == flow ]).
	self assert: flow connections size equals: 7.
	flow connections
		do: [ :connection | 
			1
				to: connection length
				do: [ :offset | 
					self
						assert: (connection sourceVersion lines at: connection sourceStart + offset)
						equals: (connection targetVersion lines at: connection targetStart + offset).
					self
						assert: (connection sourceVersion origins at: connection sourceStart + offset)
						equals: connection originIndex.
					self
						assert: (connection targetVersion origins at: connection targetStart + offset)
						equals: connection originIndex ] ].
	^ flow
]

{ #category : #private }
GtHistoryFlowExamples >> sectionLines: aName count: aCount [
	^ ((1 to: aCount)
		collect: [ :index | aName , ' / paragraph ' , index asString ])
		asOrderedCollection
]

{ #category : #examples }
GtHistoryFlowExamples >> underlyingModels [
	<gtExample>
	| first second flow element |
	first := Object new.
	second := Object new.
	flow := GtHistoryFlow
			fromVersions: {GtHistoryFlowVersion
						title: 'First'
						text: 'same'
						underlyingModel: first.
					GtHistoryFlowVersion
						title: 'Second'
						text: 'same'
						underlyingModel: second}.
	self assert: flow versions first underlyingModel == first.
	self assert: flow versions second underlyingModel == second.
	element := flow asElement.
	self assert: (element versionAtPoint: 4 @ 29) underlyingModel == first.
	self assert: (element versionAtPoint: 36 @ 29) underlyingModel == second.
	self assert: (element versionAtPoint: 68 @ 29) underlyingModel == second.
	self assert: (element versionAtPoint: 36 @ 40) isNil.
	^ flow
]
