Class {
	#name : #GtWardleyMapNodeEvolveModel,
	#superclass : #Object,
	#traits : 'TGtAnnouncer + TGtWardleyMapWithParent + TGtWardleyMapWithColor + TGtWardleyMapWithSize + TGtWardleyMapExportable + TGtWardleyMapVisitable',
	#classTraits : 'TGtAnnouncer classTrait + TGtWardleyMapWithParent classTrait + TGtWardleyMapWithColor classTrait + TGtWardleyMapWithSize classTrait + TGtWardleyMapExportable classTrait + TGtWardleyMapVisitable classTrait',
	#instVars : [
		'announcer',
		'labelModel',
		'maturity'
	],
	#category : #'GToolkit-WardleyMap-! Models'
}

{ #category : #visiting }
GtWardleyMapNodeEvolveModel >> accept: aWardleyMapVisitor [
	^ aWardleyMapVisitor visitWardleyMapEvolve: self
]

{ #category : #announcer }
GtWardleyMapNodeEvolveModel >> announcer [
	<return: #Announcer>

	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #initialization }
GtWardleyMapNodeEvolveModel >> initialize [
	super initialize.

	labelModel := GtWardleyMapEvolveLabelModel new.
	labelModel parent: self.
	
	color := GtWardleyMapConstants evolveColor.
	maturity := GtWardleyMapConstants evolveMaturity.
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
	<return: #GtWardleyMapNodeLabelModel>
	^ labelModel
]

{ #category : #'api - label' }
GtWardleyMapNodeEvolveModel >> labelModel: aModel [
	labelModel := aModel
]

{ #category : #'api - maturity' }
GtWardleyMapNodeEvolveModel >> maturity [
	<return: #Number>

	^ maturity
]

{ #category : #'api - maturity' }
GtWardleyMapNodeEvolveModel >> maturity: aMaturity [
	self maturity = aMaturity
		ifTrue: [ ^ self ].

	maturity := aMaturity.
	self notifyMaturityChanged
]

{ #category : #'api - color' }
GtWardleyMapNodeEvolveModel >> notifyColored [
	self propagateAnnouncement: (GtWardleyMapEvolveModelColored new evolveModel: self)
]

{ #category : #'api - color' }
GtWardleyMapNodeEvolveModel >> notifyMaturityChanged [
	self propagateAnnouncement: (GtWardleyMapEvolveModelMaturityChanged new evolveModel: self)
]

{ #category : #'api - parent' }
GtWardleyMapNodeEvolveModel >> notifyParentChanged [
	
]

{ #category : #'api - size' }
GtWardleyMapNodeEvolveModel >> notifySizeChanged [
	self propagateAnnouncement: (GtWardleyMapEvolveModelResized new evolveModel: self)
]
