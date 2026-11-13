"
History flow of ordered text revisions. Adjacent line matches propagate the index of the version that introduced each line. Connections join surviving contiguous runs, preserving their birth color. Insertions introduce a color and deletions terminate bands. Text matches describe textual continuity, not semantic instruction identity.
"
Class {
	#name : #GtHistoryFlow,
	#superclass : #Object,
	#instVars : [
		'versions',
		'connections'
	],
	#category : #'GToolkit-HistoryFlow'
}

{ #category : #accessing }
GtHistoryFlow class >> fromVersions: textVersions [
	^ self new initializeVersions: textVersions
]

{ #category : #accessing }
GtHistoryFlow >> asElement [
	^ GtHistoryFlowElement new flow: self
]

{ #category : #accessing }
GtHistoryFlow >> colorForOrigin: anIndex [
	^ Color
		h: (((anIndex - 1) * 137.508 + 210) / 360) fractionPart * 360
		s: 0.6
		v: 0.85
]

{ #category : #accessing }
GtHistoryFlow >> connect: previous to: current [
	| left right origins active diff |
	left := 0.
	right := 0.
	origins := OrderedCollection new.
	active := nil.
	diff := TextDiffBuilder from: previous text asString to: current text asString.
	diff
		patchSequenceDoIfMatch: [ :line | 
			| origin |
			origin := previous origins at: left + 1.
			origins add: origin.
			(active notNil and: [ active originIndex = origin ])
				ifTrue: [ active extend ]
				ifFalse: [ active := GtHistoryFlowConnection new
							source: previous
							target: current
							sourceStart: left
							targetStart: right
							origin: origin.
					connections add: active ].
			left := left + 1.
			right := right + 1 ]
		ifInsert: [ :line | 
			origins add: current index.
			right := right + 1.
			active := nil ]
		ifRemove: [ :line | 
			left := left + 1.
			active := nil ].
	self assert: left = previous lines size.
	self assert: right = current lines size.
	current origins: origins
]

{ #category : #accessing }
GtHistoryFlow >> connections [
	^ connections
]

{ #category : #'gt-extensions' }
GtHistoryFlow >> gtConnectionsFor: aView [
	"Which source and target line runs are connected?"

	<gtView>
	^ aView columnedList
		title: 'Connections';
		priority: 30;
		items: [ connections ];
		column: 'From' text: [ :connection | connection sourceVersion title ];
		column: 'To' text: [ :connection | connection targetVersion title ];
		column: 'Source start' text: #sourceStart;
		column: 'Target start' text: #targetStart;
		column: 'Lines' text: #length;
		column: 'Origin' text: #originIndex
]

{ #category : #'gt-extensions' }
GtHistoryFlow >> gtHistoryFlowFor: aView [
	"Which text survives, appears or disappears across revisions?"

	<gtView>
	^ aView explicit
		title: 'History flow';
		priority: 10;
		stencil: [ self asElement asScalableElement ]
]

{ #category : #'gt-extensions' }
GtHistoryFlow >> gtVersionsFor: aView [
	"Which revisions and line origins make up the history?"

	<gtView>
	^ aView columnedList
		title: 'Versions';
		priority: 20;
		items: [ versions ];
		column: 'Version' text: #index;
		column: 'Title' text: #title;
		column: 'Lines' text: [ :version | version lines size ];
		column: 'Introduced'
			text: [ :version | version origins count: [ :origin | origin = version index ] ]
]

{ #category : #initialization }
GtHistoryFlow >> initializeVersions: textVersions [
	versions := (textVersions
			collect: [ :version | 
				| owned |
				owned := GtHistoryFlowVersion title: version title text: version text.
				version underlyingModel == version
					ifFalse: [ owned underlyingModel: version underlyingModel ].
				owned ]) asArray.
	connections := OrderedCollection new.
	versions
		withIndexDo: [ :version :position | 
			version
				flow: self
				index: position
				origins: #() ].
	versions
		ifNotEmpty: [ versions first origins: (Array new: versions first lines size withAll: 1).
			2
				to: versions size
				do: [ :position | self connect: (versions at: position - 1) to: (versions at: position) ] ].
	connections := connections asArray.
	^ self
]

{ #category : #accessing }
GtHistoryFlow >> versions [
	^ versions
]
