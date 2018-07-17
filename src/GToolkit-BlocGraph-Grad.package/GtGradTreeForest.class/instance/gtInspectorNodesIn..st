gt-inspector-extension
gtInspectorNodesIn: aComposite
	<gtInspectorPresentationOrder: 1>

	^ aComposite fastTree
			title: 'Trees';
			display: [ self trees ];
			children: [ :aNode | aNode nodes ];
			allExpanded