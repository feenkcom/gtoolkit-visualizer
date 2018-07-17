gt-inspector-extension
gtInspectorNodesIn: aComposite
	<gtInspectorPresentationOrder: 1>

	^ aComposite fastTree
			title: 'Tree';
			display: [ { self } ];
			children: [ :aNode | aNode nodes ];
			allExpanded