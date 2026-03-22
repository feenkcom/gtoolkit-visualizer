Class {
	#name : #GtWardleyMapTitleVisibilityCheckbox,
	#superclass : #GtWardleyMapCheckbox,
	#traits : 'TGtWithWardleyMapViewModel',
	#classTraits : 'TGtWithWardleyMapViewModel classTrait',
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #initialization }
GtWardleyMapTitleVisibilityCheckbox >> initialize [
	super initialize.

	self
		enabled: true;
		checked: false;
		enabledLabel: 'visible title';
		disabledLabel: 'Cannot change title visibility';
		tooltipLabel: 'Toggle map title visibility';
		whenCheckedDo: [ :anEvent | self onCheckedDo: anEvent ];
		whenUncheckedDo: [ :anEvent | self onUncheckedDo: anEvent  ]
]

{ #category : #'event handling' }
GtWardleyMapTitleVisibilityCheckbox >> onCheckedDo: anEvent [
	self hasWardleyMapViewModel ifFalse: [ ^ self ].
	self wardleyMapViewModel isTitleVisible: true
]

{ #category : #'event handling' }
GtWardleyMapTitleVisibilityCheckbox >> onTitleVisibilityChanged [
	self checked: self wardleyMapViewModel isTitleVisible
]

{ #category : #'event handling' }
GtWardleyMapTitleVisibilityCheckbox >> onTitleVisibilityChanged: anAnnouncement [
	BlTaskAction enqueueElement: self action: [ self onTitleVisibilityChanged ]
]

{ #category : #'event handling' }
GtWardleyMapTitleVisibilityCheckbox >> onUncheckedDo: anEvent [
	self hasWardleyMapViewModel ifFalse: [ ^ self ].
	self wardleyMapViewModel isTitleVisible: false
]

{ #category : #'api - wardley map view model' }
GtWardleyMapTitleVisibilityCheckbox >> onWardleyMapViewModelChanged [
	"Is sent when a new WardleyMap view model is assigned to the element"
	
	self onTitleVisibilityChanged
]

{ #category : #'api - wardley map view model' }
GtWardleyMapTitleVisibilityCheckbox >> subscribeToWardleyMapViewModel [
	"Is sent after a new WardleyMap view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromWardleyMapViewModel if elements subscribe to them"
	
	self wardleyMapViewModel weak
		when: GtWardleyMapViewModelTitleVisibilityChanged
		send: #onTitleVisibilityChanged:
		to: self
]

{ #category : #'api - wardley map view model' }
GtWardleyMapTitleVisibilityCheckbox >> unsubscribeFromWardleyMapViewModel [
	"Is sent before a new WardleyMap view model is assigned to the element.
	Elements that subscribe to WardleyMap view model in domain model are required to implement this methods"

	self wardleyMapViewModel unsubscribe: self
]
