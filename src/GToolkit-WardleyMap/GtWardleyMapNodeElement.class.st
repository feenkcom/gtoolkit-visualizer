Class {
	#name : #GtWardleyMapNodeElement,
	#superclass : #BlElement,
	#traits : 'TGtWithWardleyMapNodeViewModel',
	#classTraits : 'TGtWithWardleyMapNodeViewModel classTrait',
	#instVars : [
		'labelElement',
		'labelContainer'
	],
	#category : #'GToolkit-WardleyMap-! Views'
}

{ #category : #initialization }
GtWardleyMapNodeElement >> initialize [
	super initialize.

	self geometry: BlEllipseGeometry new.
	self clipChildren: false.
	
	self layout: BlFrameLayout new.
	
	labelElement := BrEditableLabel new
		look: (BrGlamorousRegularEditorLook new);
		text: 'Label'.

	"we have to wrap the editable label in a pullable element to allow text selection with drag"
	labelContainer := BrHorizontalPane new
		fitContent;
		addEventHandler: (GtWardleyMapPullHandler new
			containerElement: self;
			whenPulled: [ :aPulledElement :aNormalizedPosition | self wardleyMapNodeViewModel moveNodeLabelTo: aNormalizedPosition ]);
		addChild: labelElement.

	self addChild: labelContainer
]

{ #category : #'event handling' }
GtWardleyMapNodeElement >> onNodeLabelMoved: anAnnouncement [
	labelContainer constraintsDo: [ :c |
		c frame horizontal alignCenterAt: self wardleyMapNodeViewModel labelCoordinateX.
		c frame vertical alignCenterAt: self wardleyMapNodeViewModel labelCoordinateY ]
]

{ #category : #'api - wardley map node view model' }
GtWardleyMapNodeElement >> onWardleyMapNodeViewModelChanged [
	"Is sent when a new WardleyMapNode view model is assigned to the element"
	
	self size: self wardleyMapNodeViewModel extent.
	self background: self wardleyMapNodeViewModel color.
	
	labelElement text: self wardleyMapNodeViewModel label.
	labelContainer constraintsDo: [ :c |
		c frame horizontal alignCenterAt: self wardleyMapNodeViewModel labelCoordinateX.
		c frame vertical alignCenterAt: self wardleyMapNodeViewModel labelCoordinateY ]
]

{ #category : #'api - wardley map node view model' }
GtWardleyMapNodeElement >> subscribeToWardleyMapNodeViewModel [
	"Is sent after a new WardleyMapNode view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromWardleyMapNodeViewModel if elements subscribe to them"
	
	self wardleyMapNodeViewModel weak when: GtWardleyMapNodeLabelViewModelMoved send: #onNodeLabelMoved: to: self
]

{ #category : #'api - wardley map node view model' }
GtWardleyMapNodeElement >> unsubscribeFromWardleyMapNodeViewModel [
	"Is sent before a new WardleyMapNode view model is assigned to the element.
	Elements that subscribe to WardleyMapNode view model in domain model are required to implement this methods"
	
	self wardleyMapNodeViewModel unsubscribe: self
]
