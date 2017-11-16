initialization
newButton
	<return: #BlElement>
	| aButton |

	aButton := GtConnectorTextButtonElement new
		size: 8 @ 8;
		margin:
			(BlInsets
				top: 2
				right: 5
				bottom: 0
				left: 5);
		background: Color gray;
		geometry: BlEllipse new;
		addEventHandlerOn: BlClickEvent
			do: [ :anEvent | actionBlock value: anEvent ];
		yourself.
	aButton beConnectorSource.
	aButton connectorSource: self source.
	aButton connectorTarget: self target.
	^ aButton