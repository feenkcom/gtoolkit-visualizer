Class {
	#name : #GtWardleyMapActionEdgeButton,
	#superclass : #GtWardleyMapActionButton,
	#traits : 'TGtWithWardleyMapEdgeViewModel',
	#classTraits : 'TGtWithWardleyMapEdgeViewModel classTrait',
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #'api - wardley map edge view model' }
GtWardleyMapActionEdgeButton >> decoratorViewModelRemovedAnnouncementClass [
	^ GtWardleyMapEdgeDecoratorViewModelRemoved
]

{ #category : #'private - updating' }
GtWardleyMapActionEdgeButton >> edgeElementDo: aBlock [
	self allParentsDo: [ :aParent | 
		aParent graph isEdge ifTrue: [ 
			aBlock value: aParent ] ]
]

{ #category : #'private - updating' }
GtWardleyMapActionEdgeButton >> moveNextToLabelElement [
	self
		edgeElementDo: [ :anEdgeElement | 
			anEdgeElement
				labelContainerDo: [ :aLabelContainer | 
					| anActionContainer |
					anActionContainer := GtWardleyMapUtility
							ensureCenterRightOuterDecoratorContainerFor: aLabelContainer.
					anActionContainer == self parent ifFalse: [
						self removeFromParent.
						anActionContainer addChild: self ] ] ]
]

{ #category : #'private - updating' }
GtWardleyMapActionEdgeButton >> moveToTheCenterOfEdgeElement [
	self
		edgeElementDo: [ :anEdgeElement | 
			| anActionContainer |
			anActionContainer := GtWardleyMapUtility
					ensureCenterDecoratorContainerFor: anEdgeElement.
			anActionContainer == self parent ifFalse: [ 
				self removeFromParent.
				anActionContainer addChild: self ] ]
]

{ #category : #'event handling' }
GtWardleyMapActionEdgeButton >> onEdgeRemoved [
	self removeFromParent
]

{ #category : #'event handling' }
GtWardleyMapActionEdgeButton >> onEdgeRemoved: anAnnouncement [
	BlTaskAction enqueueElement: self action: [ self onEdgeRemoved ]
]

{ #category : #'event handling' }
GtWardleyMapActionEdgeButton >> onEdgeVisibilityChanged [
	self wardleyMapEdgeViewModel isLabelVisible
		ifTrue: [ self moveNextToLabelElement ]
		ifFalse: [ self moveToTheCenterOfEdgeElement ]
]

{ #category : #'event handling' }
GtWardleyMapActionEdgeButton >> onEdgeVisibilityChanged: anAnnouncement [
	BlTaskAction enqueueElement: self action: [ self onEdgeVisibilityChanged ]
]

{ #category : #'api - wardley map edge view model' }
GtWardleyMapActionEdgeButton >> onWardleyMapEdgeViewModelChanged [
	"Is sent when a new wardleyMapEdge view model is assigned to the element"

	self onEdgeVisibilityChanged
]

{ #category : #'api - wardley map edge view model' }
GtWardleyMapActionEdgeButton >> subscribeToWardleyMapEdgeViewModel [
	"Is sent after a new wardleyMapEdge view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromWardleyMapEdgeViewModel if elements subscribe to them"
	
	self wardleyMapEdgeViewModel weak
		when: GtWardleyMapEdgeViewModelRemoved
		send: #onEdgeRemoved:
		to: self;
		when: GtWardleyMapEdgeViewModelLabelVisibilityChanged
		send: #onEdgeVisibilityChanged:
		to: self
]

{ #category : #'api - wardley map edge view model' }
GtWardleyMapActionEdgeButton >> unsubscribeFromWardleyMapEdgeViewModel [
	"Is sent before a new wardleyMapEdge view model is assigned to the element.
	Elements that subscribe to wardleyMapEdge view model in domain model are required to implement this methods"
	
	self wardleyMapEdgeViewModel unsubscribe: self
]
