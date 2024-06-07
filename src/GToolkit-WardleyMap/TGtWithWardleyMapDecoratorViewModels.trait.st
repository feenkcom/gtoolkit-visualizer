Trait {
	#name : #TGtWithWardleyMapDecoratorViewModels,
	#instVars : [
		'wardleyMapDecoratorViewModels'
	],
	#category : #'GToolkit-WardleyMap-! View models'
}

{ #category : #'api - wardley map decorator view models' }
TGtWithWardleyMapDecoratorViewModels >> addWardleyMapDecoratorViewModel: aWardleyMapDecoratorViewModel [
	self wardleyMapDecoratorViewModels add: aWardleyMapDecoratorViewModel.
	self notifyWardleyMapDecoratorViewModelAdded: aWardleyMapDecoratorViewModel
]

{ #category : #'api - wardley map decorator view models' }
TGtWithWardleyMapDecoratorViewModels >> mapDecoratorViewModelFor: aWardleyMapDecoratorModel ifFound: aFoundBlock ifNone: aNoneBlock [
	^ self wardleyMapDecoratorViewModels
		detect: [ :each | each wardleyMapDecoratorModel == aWardleyMapDecoratorModel ]
		ifFound: aFoundBlock
		ifNone: aNoneBlock
]

{ #category : #'api - wardley map decorator view models' }
TGtWithWardleyMapDecoratorViewModels >> notifyWardleyMapDecoratorViewModelAdded: aWardleyMapDecoratorViewModel [
	self
		propagateAnnouncement: (GtWardleyMapNodeDecoratorViewModelAdded new
				nodeViewModel: self;
				decoratorViewModel: aWardleyMapDecoratorViewModel)
]

{ #category : #'api - wardley map decorator view models' }
TGtWithWardleyMapDecoratorViewModels >> notifyWardleyMapDecoratorViewModelRemoved: aWardleyMapDecoratorViewModel [
	self
		propagateAnnouncement: (GtWardleyMapNodeDecoratorViewModelRemoved new
				nodeViewModel: self;
				decoratorViewModel: aWardleyMapDecoratorViewModel)
]

{ #category : #'api - wardley map decorator view models' }
TGtWithWardleyMapDecoratorViewModels >> onWardleyMapDecoratorModelAdded: aWardleyMapDecoratorModel [
	self 
		mapDecoratorViewModelFor: aWardleyMapDecoratorModel
		ifFound: [ :aViewModel |  ]
		ifNone: [ self addWardleyMapDecoratorViewModel: aWardleyMapDecoratorModel asDecoratorViewModel ]
]

{ #category : #'api - wardley map decorator view models' }
TGtWithWardleyMapDecoratorViewModels >> onWardleyMapDecoratorModelRemoved: aWardleyMapDecoratorModel [
	self
		mapDecoratorViewModelFor: aWardleyMapDecoratorModel
		ifFound: [ :aViewModel | self removeWardleyMapDecoratorViewModel: aViewModel ]
		ifNone: [ nil ]
]

{ #category : #'api - wardley map decorator view models' }
TGtWithWardleyMapDecoratorViewModels >> removeWardleyMapDecoratorViewModel: aWardleyMapDecoratorViewModel [
	self wardleyMapDecoratorViewModels remove: aWardleyMapDecoratorViewModel ifAbsent: [ ^ self ].
	self notifyWardleyMapDecoratorViewModelRemoved: aWardleyMapDecoratorViewModel
]

{ #category : #'api - wardley map decorator view models' }
TGtWithWardleyMapDecoratorViewModels >> wardleyMapDecoratorViewModels [
	<return: #Collection of: #TGtWardleyMapDecoratorViewModel>
	^ wardleyMapDecoratorViewModels ifNil: [ wardleyMapDecoratorViewModels := OrderedCollection new ]
]

{ #category : #'api - wardley map decorator view models' }
TGtWithWardleyMapDecoratorViewModels >> wardleyMapDecoratorViewModelsFromModels: aCollectionOfModels [
	| toAddModels toRemoveViewModels |
	toAddModels := OrderedCollection new: aCollectionOfModels size.
	toRemoveViewModels := OrderedCollection new: self wardleyMapDecoratorViewModels size.
	aCollectionOfModels do: [ :eachModel | 
		self wardleyMapDecoratorViewModels 
			detect: [ :eachViewModel | eachViewModel wardleyMapDecoratorModel == eachModel ]
			ifFound: [ :aViewModel | ]
			ifNone: [ toAddModels add: eachModel ] ].
	self wardleyMapDecoratorViewModels do: [ :eachViewModel | 
		aCollectionOfModels 
			detect: [ :eachModel | eachModel == eachViewModel wardleyMapDecoratorModel ]
			ifFound: [ :aModel | ]
			ifNone: [ toRemoveViewModels add: eachViewModel ] ].
			
	toRemoveViewModels do: [ :eachViewModel | self removeWardleyMapDecoratorViewModel: eachViewModel ].
	toAddModels do: [ :eachModel | self addWardleyMapDecoratorViewModel: eachModel asDecoratorViewModel ].
]
