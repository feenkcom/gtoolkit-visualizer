Class {
	#name : #GtWardleyMapNodeSizePickerMenuItem,
	#superclass : #Object,
	#traits : 'TGtWardleyMapContextMenuItem',
	#classTraits : 'TGtWardleyMapContextMenuItem classTrait',
	#category : #'GToolkit-WardleyMap-Helpers - Context Menu'
}

{ #category : #converting }
GtWardleyMapNodeSizePickerMenuItem >> createElementUsingContext: aContextMenuItem [
	<return: #BlElement or: nil>
	^ GtWardleyMapNodeSizePickerElement new
		wardleyMapNodeViewModel: aContextMenuItem wardleyMapNodeViewModel
]

{ #category : #'gt - extensions' }
GtWardleyMapNodeSizePickerMenuItem >> gtItemName [
	^ 'Size picker'
]
