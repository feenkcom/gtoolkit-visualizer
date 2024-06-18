Class {
	#name : #GtWardleyMapTitleVisiblityMenuItem,
	#superclass : #Object,
	#traits : 'TGtWardleyMapContextMenuItem',
	#classTraits : 'TGtWardleyMapContextMenuItem classTrait',
	#category : #'GToolkit-WardleyMap-Helpers - Context Menu'
}

{ #category : #converting }
GtWardleyMapTitleVisiblityMenuItem >> createElementUsingContext: aContextMenuItem [
	<return: #BlElement or: nil>
	^ GtWardleyMapTitleVisibilityCheckbox new
		wardleyMapViewModel: aContextMenuItem wardleyMapViewModel
]

{ #category : #'gt - extensions' }
GtWardleyMapTitleVisiblityMenuItem >> gtItemName [
	^ 'Title visibility checker'
]
