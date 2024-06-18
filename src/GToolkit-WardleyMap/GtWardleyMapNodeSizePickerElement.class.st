Class {
	#name : #GtWardleyMapNodeSizePickerElement,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable + TGtWithWardleyMapNodeViewModel',
	#classTraits : 'TBrLayoutResizable classTrait + TGtWithWardleyMapNodeViewModel classTrait',
	#instVars : [
		'nodeSizeEditor'
	],
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #initialization }
GtWardleyMapNodeSizePickerElement >> createDecreaseButton [
	^ GtWardleyMapUtility newButtonElement
		margin: (BlInsets right: 5);
		label: '-';
		action: [ self decreaseNodeSize ]
]

{ #category : #initialization }
GtWardleyMapNodeSizePickerElement >> createIncreaseButton [
	^ GtWardleyMapUtility newButtonElement
		margin: BlInsets empty;
		label: '+';
		action: [ self increaseNodeSize ]
]

{ #category : #'event handling' }
GtWardleyMapNodeSizePickerElement >> decreaseNodeSize [
	self hasWardleyMapNodeViewModel ifFalse: [ ^ self ].
	self wardleyMapNodeViewModel decreaseNodeSize
]

{ #category : #initialization }
GtWardleyMapNodeSizePickerElement >> defaultLayout [
	^ BlLinearLayout horizontal
]

{ #category : #'event handling' }
GtWardleyMapNodeSizePickerElement >> increaseNodeSize [
	self hasWardleyMapNodeViewModel ifFalse: [ ^ self ].
	self wardleyMapNodeViewModel increaseNodeSize
]

{ #category : #initialization }
GtWardleyMapNodeSizePickerElement >> initialize [
	super initialize.

	self fitContent.
	self addChild: self createDecreaseButton.
	self initializeEditorElement.
	self addChild: nodeSizeEditor.
	self addChild: self createIncreaseButton.

	self margin: GtWardleyMapUtility menuItemMarginInsets.
]

{ #category : #initialization }
GtWardleyMapNodeSizePickerElement >> initializeEditorElement [
	nodeSizeEditor := BrEditableLabel new
			aptitude: (BrGlamorousEditableLabelAptitude new fontSize: 0.9 fontEm);
			margin: (BlInsets right: 5);
			fitContent;
			text: '1.0';
			when: BrEditorAcceptWish
				do: [ :aWish | self onAcceptNewNodeSizeWish: aWish ]
]

{ #category : #'event handling' }
GtWardleyMapNodeSizePickerElement >> onAcceptNewNodeSizeWish: aWish [
	| aNewNodeSize |
	self hasWardleyMapNodeViewModel ifFalse: [ ^ self ].
	aNewNodeSize := aWish text asString asNumber.
	self wardleyMapNodeViewModel nodeSize: aNewNodeSize asPoint
]

{ #category : #'event handling' }
GtWardleyMapNodeSizePickerElement >> onNodeSizeChanged [
	nodeSizeEditor text: self wardleyMapNodeViewModel nodeSize min asString
]

{ #category : #'api - wardley map node view model' }
GtWardleyMapNodeSizePickerElement >> onWardleyMapNodeViewModelChanged [
	"Is sent when a new WardleyMapNode view model is assigned to the element"
	
	self onNodeSizeChanged
]

{ #category : #'api - wardley map node view model' }
GtWardleyMapNodeSizePickerElement >> subscribeToWardleyMapNodeViewModel [
	"Is sent after a new WardleyMapNode view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromWardleyMapNodeViewModel if elements subscribe to them"
	
	self wardleyMapNodeViewModel weak
		when: GtWardleyMapNodeViewModelResized
			send: #onNodeSizeChanged
			to: self.
]

{ #category : #'api - wardley map node view model' }
GtWardleyMapNodeSizePickerElement >> unsubscribeFromWardleyMapNodeViewModel [
	"Is sent before a new WardleyMapNode view model is assigned to the element.
	Elements that subscribe to WardleyMapNode view model in domain model are required to implement this methods"
	
	self wardleyMapNodeViewModel unsubscribe: self
]
