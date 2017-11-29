initialization
newButton
	<return: #BlElement>
	| aButton |

	aButton := GtConnectorTextButtonElement new
		size: 6 @ 6;
		margin:
			(BlInsets
				top: 6
				right: 2
				bottom: 0
				left: 2);
		background: (Color gray alpha: 0.5);
		geometry: BlEllipse new;
		addEventHandlerOn: BlClickEvent
			do: [ :anEvent | actionBlock value: anEvent ];
		yourself.
	aButton beConnectorSource.
	aButton connectorSource: self source.
	aButton connectorTarget: self target.
	^ aButton