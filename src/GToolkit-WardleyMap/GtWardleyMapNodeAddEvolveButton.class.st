Class {
	#name : #GtWardleyMapNodeAddEvolveButton,
	#superclass : #BrButton,
	#traits : 'TGtWithWardleyMapNodeViewModel',
	#classTraits : 'TGtWithWardleyMapNodeViewModel classTrait',
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #initialization }
GtWardleyMapNodeAddEvolveButton >> initialize [
	super initialize.

	self
		fitContent;
		beSmallSize;
		aptitude: BrGlamorousButtonWithLabelAptitude new;
		margin: GtWardleyMapUtility menuItemMarginInsets;
		label: 'Add evolve node';
		action: [ self onButtonClick ]
]

{ #category : #'event handling' }
GtWardleyMapNodeAddEvolveButton >> onButtonClick [
	self hasWardleyMapNodeViewModel ifFalse: [ ^ self ].
	self wardleyMapNodeViewModel addEvolve.
	self fireEvent: BrContextMenuHideWish new
]

{ #category : #'event handling' }
GtWardleyMapNodeAddEvolveButton >> onEvolveVisibilityChanged [
	self enabled: self wardleyMapNodeViewModel canAddEvolveNode
]

{ #category : #'event handling' }
GtWardleyMapNodeAddEvolveButton >> onEvolveVisibilityChanged: anAnnouncement [
	BlTaskAction enqueueElement: self action: [ self onEvolveVisibilityChanged ]
]

{ #category : #'api - wardley map node view model' }
GtWardleyMapNodeAddEvolveButton >> onWardleyMapNodeViewModelChanged [
	"Is sent when a new WardleyMapNode view model is assigned to the element"
	
	self onEvolveVisibilityChanged
]

{ #category : #'api - wardley map node view model' }
GtWardleyMapNodeAddEvolveButton >> subscribeToWardleyMapNodeViewModel [
	"Is sent after a new WardleyMapNode view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromWardleyMapNodeViewModel if elements subscribe to them"

	self wardleyMapNodeViewModel weak
		when: GtWardleyMapNodeViewModelEvolveVisibilityChanged
		send: #onEvolveVisibilityChanged:
		to: self
]

{ #category : #'api - wardley map node view model' }
GtWardleyMapNodeAddEvolveButton >> unsubscribeFromWardleyMapNodeViewModel [
	"Is sent before a new WardleyMapNode view model is assigned to the element.
	Elements that subscribe to WardleyMapNode view model in domain model are required to implement this methods"

	self wardleyMapNodeViewModel unsubscribe: self
]
