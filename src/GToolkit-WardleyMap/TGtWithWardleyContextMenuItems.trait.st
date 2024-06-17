Trait {
	#name : #TGtWithWardleyContextMenuItems,
	#category : #'GToolkit-WardleyMap-Helpers - Context Menu'
}

{ #category : #'api - context menu' }
TGtWithWardleyContextMenuItems >> contextMenuItems [
	<return: #Collection of: #TGtWardleyMapContextMenuItem>
	| allPragmas |
	allPragmas := Pragma
			allNamed: #wardleyContextMenuItem:
			from: self class
			to: GtWardleyMapNodeViewModel
			sortedByArgument: 1.

	^ allPragmas collect: [ :eachPragma | 
		(self perform: eachPragma methodSelector)
			definingMethod: eachPragma method asRingDefinition ]
]

{ #category : #'gt - extensions' }
TGtWithWardleyContextMenuItems >> gtContextMenuItemsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Context menu';
		items: [ self contextMenuItems ];
		column: 'Index'
			text: [ :anItem :anIndex | anIndex ]
			width: 40;
		column: 'Menu item' text: #gtItemName
]
