Class {
	#name : #GtInspectorConnectorSwitchStencil,
	#superclass : #BrStencil,
	#category : #'GToolkit-Connector'
}

{ #category : #'api - instantiation' }
GtInspectorConnectorSwitchStencil >> create [
	^ BrButton new
		background: Color white;
		look: BrLabelLook  + BrShadowLook new;
		constraintsDo: [ :c | c horizontal fitContent. c vertical fitContent. c padding: (BlInsets all:5)];
		geometry: (BlRectangle cornerRadius: 10);
		layout: BlLinearLayout horizontal alignCenter;
		when: BlMouseEnterEvent do: [ :anEvent | anEvent currentTarget background: Color veryVeryLightGray lighter ];
		when: BlMouseLeaveEvent do: [ :anEvent | anEvent currentTarget background: Color white ];
		yourself
]
