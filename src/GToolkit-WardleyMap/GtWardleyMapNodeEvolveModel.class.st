Class {
	#name : #GtWardleyMapNodeEvolveModel,
	#superclass : #Object,
	#traits : 'TGtAnnouncer + TGtWardleyMapWithParent + TGtWardleyMapWithColor + TGtWardleyMapWithSize + TGtWardleyMapExportable + TGtWardleyMapVisitable',
	#classTraits : 'TGtAnnouncer classTrait + TGtWardleyMapWithParent classTrait + TGtWardleyMapWithColor classTrait + TGtWardleyMapWithSize classTrait + TGtWardleyMapExportable classTrait + TGtWardleyMapVisitable classTrait',
	#instVars : [
		'announcer',
		'labelModel',
		'evolution'
	],
	#category : #'GToolkit-WardleyMap-! Models'
}

{ #category : #comparing }
GtWardleyMapNodeEvolveModel >> = anObject [
	self == anObject ifTrue: [ ^ true ].

	self class = anObject class ifFalse: [ ^ false ].

	^ self color = anObject color
		and: [ self evolution = anObject evolution
				and: [ self labelModel = anObject labelModel and: [ self size = anObject size ] ] ]
]

{ #category : #visiting }
GtWardleyMapNodeEvolveModel >> accept: aWardleyMapVisitor [
	^ aWardleyMapVisitor visitWardleyMapEvolve: self
]

{ #category : #announcer }
GtWardleyMapNodeEvolveModel >> announcer [
	<return: #Announcer>

	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #'api - maturity' }
GtWardleyMapNodeEvolveModel >> evolution [
	<return: #Number>

	^ evolution
]

{ #category : #'api - maturity' }
GtWardleyMapNodeEvolveModel >> evolution: aMaturity [
	self evolution = aMaturity
		ifTrue: [ ^ self ].

	evolution := aMaturity.
	self notifyEvolutionChanged
]

{ #category : #comparing }
GtWardleyMapNodeEvolveModel >> hash [
	^ self color hash
		bitXor: (self maturity hash 
		bitXor: (self labelModel hash 
		bitXor: self size hash))
]

{ #category : #initialization }
GtWardleyMapNodeEvolveModel >> initialize [
	super initialize.

	labelModel := GtWardleyMapEvolveLabelModel new.
	labelModel parent: self.
	
	color := GtWardleyMapConstants evolveColor.
	evolution := GtWardleyMapConstants evolveMaturity.
	size := GtWardleyMapConstants nodeSize.
]

{ #category : #'api - label' }
GtWardleyMapNodeEvolveModel >> isLabelVisible [
	<return: #Boolean>

	^ self labelModel isVisible
]

{ #category : #'api - label' }
GtWardleyMapNodeEvolveModel >> isLabelVisible: aBoolean [
	self labelModel isVisible: aBoolean
]

{ #category : #'api - label' }
GtWardleyMapNodeEvolveModel >> label [
	<return: #String>

	^ self labelModel label
]

{ #category : #'api - label' }
GtWardleyMapNodeEvolveModel >> label: aString [
	self labelModel label: aString
]

{ #category : #'api - label' }
GtWardleyMapNodeEvolveModel >> labelCoordinate [
	<return: #Point>

	^ self labelModel coordinate
]

{ #category : #'api - label' }
GtWardleyMapNodeEvolveModel >> labelCoordinate: aPoint [
	self labelModel coordinate: aPoint
]

{ #category : #'api - label' }
GtWardleyMapNodeEvolveModel >> labelModel [
	<return: #GtWardleyMapEvolveLabelModel>
	^ labelModel
]

{ #category : #'api - label' }
GtWardleyMapNodeEvolveModel >> labelModel: aModel [
	labelModel := aModel.
	aModel parent: self.
]

{ #category : #'api - maturity' }
GtWardleyMapNodeEvolveModel >> maturity [
	self
		deprecated: 'Use #evolution instead. Check https://swardley.medium.com/map-evolution-not-maturity-bae6ea1a2743'
		transformWith: '`@receiver maturity' -> '`@receiver evolution'.
	
	^ self evolution
]

{ #category : #'api - maturity' }
GtWardleyMapNodeEvolveModel >> maturity: aNumber [
	self
		deprecated: 'Please use evolution: instead. Check https://swardley.medium.com/map-evolution-not-maturity-bae6ea1a2743'
		transformWith: '`@receiver maturity: `@statements1' -> '`@receiver evolution: `@statements1'.
	
	self evolution: aNumber
]

{ #category : #'api - color' }
GtWardleyMapNodeEvolveModel >> notifyColored [
	self propagateAnnouncement: (GtWardleyMapEvolveModelColored new evolveModel: self)
]

{ #category : #'api - color' }
GtWardleyMapNodeEvolveModel >> notifyEvolutionChanged [
	self propagateAnnouncement: (GtWardleyMapEvolveModelEvolutionChanged new evolveModel: self)
]

{ #category : #'api - parent' }
GtWardleyMapNodeEvolveModel >> notifyParentChanged [
	
]

{ #category : #'api - size' }
GtWardleyMapNodeEvolveModel >> notifySizeChanged [
	self propagateAnnouncement: (GtWardleyMapEvolveModelResized new evolveModel: self)
]

{ #category : #printing }
GtWardleyMapNodeEvolveModel >> printOn: aStream [
	"Append a sequence of characters to aStream that identify the receiver."

	aStream
		nextPutAll: 'Evolve {';
		nextPutAll: ' label: ';
		print: self label;
		nextPutAll: '; maturity: ';
		print: self maturity;
		nextPutAll: '; size: ';
		print: self size;
		nextPutAll: '; color: ';
		print: self color;
		nextPutAll: ' }'
]
