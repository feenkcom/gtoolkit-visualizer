Class {
	#name : #GtWardleyMapEvolutionAsixLayer,
	#superclass : #BrHorizontalGrid,
	#category : #'GToolkit-WardleyMap-! Views'
}

{ #category : #initialization }
GtWardleyMapEvolutionAsixLayer >> createHorizontalAxis [
	^ BlElement new
		constraintsDo: [ :c |
			c vertical exact: 1.
			c horizontal matchParent ];
		background: Color veryLightGray
]

{ #category : #initialization }
GtWardleyMapEvolutionAsixLayer >> createLabel [
	^ BrLabel new
		beSmallSize;
		look: (BrGlamorousLabelLook new foreground: Color gray)
]

{ #category : #initialization }
GtWardleyMapEvolutionAsixLayer >> createVerticalGridLine [
	^ BlElement new
		constraintsDo: [ :c |
			c horizontal exact: 1.
			c vertical matchParent ];
		background: Color veryLightGray
]

{ #category : #initialization }
GtWardleyMapEvolutionAsixLayer >> initialize [
	super initialize.
	
	self matchParent
]

{ #category : #accessing }
GtWardleyMapEvolutionAsixLayer >> sections: aCollectionOfSectionNames [
	| theColumnCount  theLabels theGridLines theGridEmptySpace theDivider |

	theColumnCount := aCollectionOfSectionNames size * 2.
	self columnCount: theColumnCount.

	theGridLines := (1 to: aCollectionOfSectionNames size)
		collect: [ :i | self createVerticalGridLine ].
	theGridLines ifNotEmpty: [ theGridLines last visibility: BlVisibility hidden ].

	theGridEmptySpace := (1 to: aCollectionOfSectionNames size)
		collect: [ :ti |
			BlElement new
				constraintsDo: [ :c |
					c horizontal matchParent.
					c vertical matchParent ] ].

	theLabels := aCollectionOfSectionNames collect: [ :eachSectionName |
		self createLabel
			text: eachSectionName;
			constraintsDo: [ :c |
				c grid horizontal span: 2.
				c grid horizontal alignCenter ] ].
		
	theDivider := self createHorizontalAxis
		constraintsDo: [ :c |
			c grid horizontal span: theColumnCount ].

	theGridEmptySpace with: theGridLines do: [ :eachSpace :eachLine |
		self addChild: eachSpace.
		eachLine ifNotNil: [ self addChild: eachLine ] ].
	
	self addChild: theDivider.
	self addChildren: theLabels
]
