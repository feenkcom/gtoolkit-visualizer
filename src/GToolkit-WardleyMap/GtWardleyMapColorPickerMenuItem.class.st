Class {
	#name : #GtWardleyMapColorPickerMenuItem,
	#superclass : #Object,
	#traits : 'TGtWardleyMapContextMenuItem',
	#classTraits : 'TGtWardleyMapContextMenuItem classTrait',
	#category : #'GToolkit-WardleyMap-Helpers - Context Menu'
}

{ #category : #converting }
GtWardleyMapColorPickerMenuItem >> createElementUsingContext: aContextMenuItem [
	<return: #BlElement or: nil>
	^ GtWardleyMapColorPickerElement new
		hFitContent;
		vFitContentLimited;
		columnCount: 8;
		cellSpacing: 3;
		colors: aContextMenuItem wardleyMapViewModel predefinedColors;
		whenColorPickedDo: [ :aColor |
			aContextMenuItem wardleyMapNodeViewModel changeColorTo: aColor.
			aContextMenuItem wardleyMapViewModel defaultColor: aColor ]
]

{ #category : #'gt - extensions' }
GtWardleyMapColorPickerMenuItem >> gtItemName [
	^ 'Color picker'
]
