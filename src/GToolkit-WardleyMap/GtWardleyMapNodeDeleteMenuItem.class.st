Class {
	#name : #GtWardleyMapNodeDeleteMenuItem,
	#superclass : #Object,
	#traits : 'TGtWardleyMapContextMenuItem',
	#classTraits : 'TGtWardleyMapContextMenuItem classTrait',
	#category : #'GToolkit-WardleyMap-Helpers - Context Menu'
}

{ #category : #converting }
GtWardleyMapNodeDeleteMenuItem >> createElementUsingContext: aContextMenuItem [
	<return: #BlElement or: nil>
	^ GtWardleyMapUtility newMenuItemDeleteButton
		label: 'Delete node';
		action: [ :aButton |
			aContextMenuItem wardleyMapNodeViewModel removeFromMap.
			aButton fireEvent: BrContextMenuHideWish new ]
]

{ #category : #'gt - extensions' }
GtWardleyMapNodeDeleteMenuItem >> gtItemName [
	^ 'Delete node button'
]
