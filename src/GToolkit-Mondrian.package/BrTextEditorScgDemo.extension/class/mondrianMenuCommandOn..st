*GToolkit-Mondrian
mondrianMenuCommandOn: aBuilder
	<worldMenu>

	(aBuilder item: #'2. Mapping of elements')
		order: 0.2;
		iconName: #catalogIcon;
		parent: #'SCG - Moldable Editor';
		action: [ self editorElements ].