examples
editorElementWithPreviews
	<gtExample>
	| root element editor ropeMondrian elementsMondrian block |
	block := [
		| view toAdd |
		view := GtMondrian new. 
		element forceLayout.
		element editor text rope paintTreeWith: view.
		toAdd := view asScalableElement.
		ropeMondrian removeChildren.
		ropeMondrian addChild: toAdd.
		
		view := GtMondrian new.
		GtMondrianDomainExamples new editorElementsOf: element on: view.
		toAdd := view asScalableElement.
		elementsMondrian removeChildren.
		elementsMondrian addChild: toAdd ].

	root := BlElement new.
	root constraintsDo: [ :c | 
			c vertical matchParent.
			c horizontal matchParent ].
	root layout: (BlGridLayout new cellSpacing: 20; columnCount: 1).
	element := BrEditorElement new.
	editor := BrTextEditor new.
	editor text: BrRopedTextExamples new textWithAttributes.
	editor when: BrTextEditorInsertedEvent do: block.
	element 
		background: Color white;
		effect: (BlDropShadowEffect color: Color lightGray width: 10 offset: 10@10);
		editor: editor;
		constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical matchParent.
				c grid vertical weight: 0.5 ].
	root addChild: element.

	elementsMondrian := BlElement new.
	elementsMondrian 
		background: Color white;
		effect: (BlDropShadowEffect color: Color lightGray width: 10 offset: 10@10);
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent.].
	root addChild: elementsMondrian.

	ropeMondrian := BlElement new.
	ropeMondrian 
		background: Color white;
		effect: (BlDropShadowEffect color: Color lightGray width: 10 offset: 10@10);
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent.].
	root addChild: ropeMondrian.
	block value.
	^ root