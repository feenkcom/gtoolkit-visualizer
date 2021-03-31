Class {
	#name : #GtInspectorConnectorSwitchStencil,
	#superclass : #BrStencil,
	#category : #'GToolkit-Connector-Extensions'
}

{ #category : #'api - instantiation' }
GtInspectorConnectorSwitchStencil >> create [
	^ BrButton new
		background: Color white;
		aptitude: BrTextLabelAptitude  + BrShadowAptitude new;
		constraintsDo: [ :c | c horizontal fitContent. c vertical fitContent. c padding: (BlInsets all:5)];
		geometry: (BlRoundedRectangleGeometry cornerRadius: 10);
		layout: BlLinearLayout horizontal alignCenter;
		when: BlMouseEnterEvent do: [ :anEvent | anEvent currentTarget background: Color veryVeryLightGray lighter ];
		when: BlMouseLeaveEvent do: [ :anEvent | anEvent currentTarget background: Color white ];
		yourself
]
