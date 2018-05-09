ui
gtInspectorLiveIn: composite
	<gtInspectorPresentationOrder: 0>
	
	^ composite blocMondrian 
		title: 'Live';
		initializeView: [ self ];
		when: [ self topStep root hasParent not ]