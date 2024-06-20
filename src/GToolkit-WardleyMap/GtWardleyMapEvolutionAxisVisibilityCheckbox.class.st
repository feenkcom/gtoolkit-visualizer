Class {
	#name : #GtWardleyMapEvolutionAxisVisibilityCheckbox,
	#superclass : #GtWardleyMapCheckbox,
	#traits : 'TGtWithWardleyMapViewModel',
	#classTraits : 'TGtWithWardleyMapViewModel classTrait',
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #initialization }
GtWardleyMapEvolutionAxisVisibilityCheckbox >> initialize [
	super initialize.

	self
		enabled: true;
		checked: false;
		enabledLabel: 'visible evolution axis';
		disabledLabel: 'Cannot change evolution axis visibility';
		tooltipLabel: 'Toggle map evolution axis visibility';
		whenCheckedDo: [ :anEvent | self onCheckedDo: anEvent ];
		whenUncheckedDo: [ :anEvent | self onUncheckedDo: anEvent  ]
]

{ #category : #'event handling' }
GtWardleyMapEvolutionAxisVisibilityCheckbox >> onCheckedDo: anEvent [
	self hasWardleyMapViewModel ifFalse: [ ^ self ].
	self wardleyMapViewModel isEvolutionAxisVisible: true
]

{ #category : #'event handling' }
GtWardleyMapEvolutionAxisVisibilityCheckbox >> onEvolutionAxisVisibilityChanged [
	self checked: self wardleyMapViewModel isEvolutionAxisVisible
]

{ #category : #'event handling' }
GtWardleyMapEvolutionAxisVisibilityCheckbox >> onUncheckedDo: anEvent [
	self hasWardleyMapViewModel ifFalse: [ ^ self ].
	self wardleyMapViewModel isEvolutionAxisVisible: false
]

{ #category : #'api - wardley map view model' }
GtWardleyMapEvolutionAxisVisibilityCheckbox >> onWardleyMapViewModelChanged [
	"Is sent when a new WardleyMap view model is assigned to the element"
	
	self onEvolutionAxisVisibilityChanged
]

{ #category : #'api - wardley map view model' }
GtWardleyMapEvolutionAxisVisibilityCheckbox >> subscribeToWardleyMapViewModel [
	"Is sent after a new WardleyMap view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromWardleyMapViewModel if elements subscribe to them"
	
	self wardleyMapViewModel weak
		when: GtWardleyMapViewModelEvolutionAxisVisibilityChanged
		send: #onEvolutionAxisVisibilityChanged
		to: self
]

{ #category : #'api - wardley map view model' }
GtWardleyMapEvolutionAxisVisibilityCheckbox >> unsubscribeFromWardleyMapViewModel [
	"Is sent before a new WardleyMap view model is assigned to the element.
	Elements that subscribe to WardleyMap view model in domain model are required to implement this methods"
	
	self wardleyMapViewModel unsubscribe: self
]
