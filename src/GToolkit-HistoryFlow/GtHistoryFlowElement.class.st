"
Canvas history-flow visualization. Thin source-order revision bars are connected by filled bands for surviving lines. Birth-version colors persist through revisions. Hovering a version emphasizes its connections and shows its title.
"
Class {
	#name : #GtHistoryFlowElement,
	#superclass : #BlElement,
	#instVars : [
		'flow',
		'bands',
		'bars',
		'versionWidth',
		'gapWidth',
		'lineHeight',
		'hoverTitle',
		'hoveredVersion'
	],
	#category : #'GToolkit-HistoryFlow'
}

{ #category : #drawing }
GtHistoryFlowElement >> alphaFor: aConnection [
	hoveredVersion ifNil: [ ^ 0.5 ].
	^ aConnection targetVersion index = hoveredVersion
		ifTrue: [ 0.8 ]
		ifFalse: [ 0.12 ]
]

{ #category : #drawing }
GtHistoryFlowElement >> alphaForVersion: anIndex [
	hoveredVersion ifNil: [ ^ 1 ].
	^ (anIndex = hoveredVersion or: [ anIndex = (hoveredVersion - 1) ])
		ifTrue: [ 1 ]
		ifFalse: [ 0.25 ]
]

{ #category : #accessing }
GtHistoryFlowElement >> bands [
	^ bands
]

{ #category : #accessing }
GtHistoryFlowElement >> bars [
	^ bars
]

{ #category : #accessing }
GtHistoryFlowElement >> connection: aConnection containsPoint: aPoint [
	| left right fraction top bottom |
	left := (self versionX: aConnection sourceVersion index) + versionWidth.
	right := self versionX: aConnection targetVersion index.
	(right <= left or: [ aPoint x < left or: [ aPoint x > right ] ])
		ifTrue: [ ^ false ].
	fraction := (aPoint x - left) / (right - left).
	top := self titleHeight
			+ ((aConnection sourceStart * (1 - fraction)
					+ (aConnection targetStart * fraction)) * lineHeight).
	bottom := top + (aConnection length * lineHeight).
	^ aPoint y >= top and: [ aPoint y < bottom ]
]

{ #category : #drawing }
GtHistoryFlowElement >> drawMeAndChildrenOnSpartaCanvas: aCanvas [
	super drawMeAndChildrenOnSpartaCanvas: aCanvas.
	self paintFlowOn: aCanvas
]

{ #category : #accessing }
GtHistoryFlowElement >> emphasizeAt: aPoint [
	(flow isNil or: [ flow versions isEmpty ])
		ifTrue: [ ^ self hoveredVersion: nil ].
	self
		hoveredVersion: (((aPoint x / self versionStep) rounded + 1 max: 1) min: flow versions size)
]

{ #category : #accessing }
GtHistoryFlowElement >> flow [
	^ flow
]

{ #category : #accessing }
GtHistoryFlowElement >> flow: aFlow [
	flow := aFlow.
	hoveredVersion := nil.
	hoverTitle visibility: BlVisibility hidden.
	self rebuildGeometry
]

{ #category : #accessing }
GtHistoryFlowElement >> gapWidth [
	^ gapWidth
]

{ #category : #accessing }
GtHistoryFlowElement >> gapWidth: aNumber [
	self assert: aNumber >= 0.
	gapWidth := aNumber.
	self rebuildGeometry
]

{ #category : #accessing }
GtHistoryFlowElement >> hoverTitle [
	^ hoverTitle
]

{ #category : #accessing }
GtHistoryFlowElement >> hoveredVersion [
	^ hoveredVersion
]

{ #category : #accessing }
GtHistoryFlowElement >> hoveredVersion: anIndex [
	hoveredVersion = anIndex ifTrue: [ ^ self ].
	hoveredVersion := anIndex.
	anIndex
		ifNil: [ hoverTitle visibility: BlVisibility hidden ]
		ifNotNil: [ hoverTitle text: (flow versions at: anIndex) title.
			hoverTitle visibility: BlVisibility visible.
			self updateTitlePosition ].
	self invalidate
]

{ #category : #initialization }
GtHistoryFlowElement >> initialize [
	super initialize.
	bands := #().
	bars := #().
	versionWidth := 8.
	gapWidth := 56.
	lineHeight := 2.
	self background: self theme default contentBackground.
	hoverTitle := BrLabel new
			aptitude: BrGlamorousLabelAptitude;
			fitContent;
			constraintsDo: [ :c | c ignoreByLayout ];
			preventMeAndChildrenMouseEvents;
			visibility: BlVisibility hidden.
	self addChild: hoverTitle.
	self
		when: BlMouseMoveEvent
		do: [ :event | self emphasizeAt: event localPosition ].
	self when: BlMouseLeaveEvent do: [ :event | self hoveredVersion: nil ].
	self when: BlClickEvent do: [ :event | self onClick: event ]
]

{ #category : #accessing }
GtHistoryFlowElement >> lineHeight [
	^ lineHeight
]

{ #category : #accessing }
GtHistoryFlowElement >> lineHeight: aNumber [
	self assert: aNumber > 0.
	lineHeight := aNumber.
	self rebuildGeometry
]

{ #category : #interaction }
GtHistoryFlowElement >> onClick: anEvent [
	| version |
	anEvent primaryButtonPressed ifFalse: [ ^ self ].
	version := self versionAtPoint: anEvent localPosition.
	version ifNil: [ ^ self ].
	anEvent consumed: true.
	self phlow spawnObject: version underlyingModel
]

{ #category : #accessing }
GtHistoryFlowElement >> onLayoutDone [
	super onLayoutDone.
	self updateTitlePosition
]

{ #category : #drawing }
GtHistoryFlowElement >> paintFlowOn: aCanvas [
	flow ifNil: [ ^ self ].
	bands
		do: [ :band | 
			aCanvas fill
				alpha: (self alphaFor: band key);
				paint: (flow colorForOrigin: band key originIndex);
				path: (band value pathOnSpartaCanvas: aCanvas of: self);
				draw ].
	bars
		do: [ :bar | 
			aCanvas fill
				alpha: (self alphaForVersion: bar third);
				paint: bar second;
				path: bar first;
				draw ]
]

{ #category : #accessing }
GtHistoryFlowElement >> paintMeAndChildrenOn: aPainter offset: anOffset [
	super paintMeAndChildrenOn: aPainter offset: anOffset.
	aPainter canvas transform
		by: [ :transform | transform translateBy: anOffset ]
		during: [ self paintFlowOn: aPainter canvas ]
]

{ #category : #accessing }
GtHistoryFlowElement >> rebuildGeometry [
	| rectangles height |
	flow ifNil: [ ^ self ].
	bands := flow connections
			collect: [ :connection | connection -> (BlPolylineGeometry vertices: (self verticesFor: connection)) ].
	rectangles := OrderedCollection new.
	height := 0.
	flow versions
		do: [ :version | 
			height := height max: version lines size * lineHeight.
			version
				originRunsDo: [ :start :stop :origin | 
					rectangles
						add: {(self versionX: version index) @ (self titleHeight + (start * lineHeight))
									corner: ((self versionX: version index) + self versionWidth)
											@ (self titleHeight + (stop * lineHeight)).
								flow colorForOrigin: origin.
								version index} ] ].
	bars := rectangles asArray.
	self
		size: ((flow versions size - 1 max: 0) * self versionStep + self versionWidth)
				@ (self titleHeight + (height max: 1)).
	self updateTitlePosition.
	self invalidate
]

{ #category : #accessing }
GtHistoryFlowElement >> titleHeight [
	"Vertical space reserved above the flow for the hover title."

	^ 28
]

{ #category : #accessing }
GtHistoryFlowElement >> updateTitlePosition [
	| desired |
	hoveredVersion ifNil: [ ^ self ].
	desired := (((self versionX: hoveredVersion) min: self width - hoverTitle width)
			max: 0) @ 2.
	hoverTitle position = desired ifFalse: [ hoverTitle position: desired ]
]

{ #category : #accessing }
GtHistoryFlowElement >> versionAtPoint: aPoint [
	flow ifNil: [ ^ nil ].
	flow versions
		do: [ :version | 
			| x |
			x := self versionX: version index.
			((aPoint x >= x and: [ aPoint x <= (x + versionWidth) ])
				and: [ aPoint y >= self titleHeight
						and: [ aPoint y < (self titleHeight + (version lines size * lineHeight)) ] ])
				ifTrue: [ ^ version ] ].
	flow connections
		do: [ :connection | 
			(self connection: connection containsPoint: aPoint)
				ifTrue: [ ^ connection targetVersion ] ].
	^ nil
]

{ #category : #accessing }
GtHistoryFlowElement >> versionStep [
	^ self versionWidth + self gapWidth
]

{ #category : #accessing }
GtHistoryFlowElement >> versionWidth [
	^ versionWidth
]

{ #category : #accessing }
GtHistoryFlowElement >> versionWidth: aNumber [
	self assert: aNumber > 0.
	versionWidth := aNumber.
	self rebuildGeometry
]

{ #category : #accessing }
GtHistoryFlowElement >> versionX: anIndex [
	^ (anIndex - 1) * self versionStep
]

{ #category : #accessing }
GtHistoryFlowElement >> verticesFor: aConnection [
	| left right lt lb rt rb |
	left := (self versionX: aConnection sourceVersion index) + self versionWidth.
	right := self versionX: aConnection targetVersion index.
	lt := self titleHeight + (aConnection sourceStart * lineHeight).
	lb := lt + (aConnection length * lineHeight).
	rt := self titleHeight + (aConnection targetStart * lineHeight).
	rb := rt + (aConnection length * lineHeight).
	^ {left @ lt.
		right @ rt.
		right @ rb.
		left @ lb.
		left @ lt}
]
