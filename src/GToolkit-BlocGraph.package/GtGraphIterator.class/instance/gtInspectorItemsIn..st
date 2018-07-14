gt-inspector-extension
gtInspectorItemsIn: aComposite
	<gtInspectorPresentationOrder: 5>
	
	^ aComposite fastList
		title: 'Items';
		display: [ self asArray ]