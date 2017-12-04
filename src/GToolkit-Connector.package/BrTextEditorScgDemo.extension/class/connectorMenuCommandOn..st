*GToolkit-Connector
connectorMenuCommandOn: aBuilder
	<worldMenu>

	(aBuilder item: #'8. Connector')
		order: 0.8;
		iconName: #catalogIcon;
		parent: #'SCG - Moldable Editor';
		action: [ self connectorMethod ].