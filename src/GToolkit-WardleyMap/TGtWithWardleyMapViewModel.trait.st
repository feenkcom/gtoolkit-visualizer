Trait {
	#name : #TGtWithWardleyMapViewModel,
	#instVars : [
		'wardleyMapViewModel'
	],
	#category : #'GToolkit-WardleyMap-! Views'
}

{ #category : #'api - export / import' }
TGtWithWardleyMapViewModel >> gtJSONFor: aView [
	<gtView>
	
	^ aView forward
		title: 'JSON';
		priority: 8;
		object: [ self wardleyMapViewModel ];
		view: #gtJSONFor:
]

{ #category : #'api - wardley map view model' }
TGtWithWardleyMapViewModel >> hasWardleyMapViewModel [
	"Return a true if WardleyMap view model is assigned to the receiver element, false otherwise"
	<return: #Boolean>

	^ wardleyMapViewModel notNil
]

{ #category : #'api - wardley map view model' }
TGtWithWardleyMapViewModel >> onWardleyMapViewModelChanged [
	"Is sent when a new WardleyMap view model is assigned to the element"
	
	self explicitRequirement
]

{ #category : #'api - wardley map view model' }
TGtWithWardleyMapViewModel >> subscribeToWardleyMapViewModel [
	"Is sent after a new WardleyMap view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromWardleyMapViewModel if elements subscribe to them"
]

{ #category : #'api - wardley map view model' }
TGtWithWardleyMapViewModel >> unsubscribeFromWardleyMapViewModel [
	"Is sent before a new WardleyMap view model is assigned to the element.
	Elements that subscribe to WardleyMap view model in domain model are required to implement this methods"
]

{ #category : #'api - wardley map view model' }
TGtWithWardleyMapViewModel >> wardleyMapViewModel [
	"Return a not-null WardleyMap view model assigned to the receiver element"
	self
		assert: [ wardleyMapViewModel notNil ]
		description: [ 'WardleyMap view model should be initialized' ].

	^ wardleyMapViewModel
]

{ #category : #'api - wardley map view model' }
TGtWithWardleyMapViewModel >> wardleyMapViewModel: aWardleyMapViewModel [
	"Set a not-null WardleyMap view model assigned to the receiver element"
	self
		assert: [ aWardleyMapViewModel notNil ]
		description: [ 'WardleyMap view model must not be nil' ].

	wardleyMapViewModel == aWardleyMapViewModel 
		ifTrue: [ ^ self ].

	wardleyMapViewModel ifNotNil: [ self unsubscribeFromWardleyMapViewModel ].
	wardleyMapViewModel := aWardleyMapViewModel.

	self onWardleyMapViewModelChanged.
	self subscribeToWardleyMapViewModel
]
