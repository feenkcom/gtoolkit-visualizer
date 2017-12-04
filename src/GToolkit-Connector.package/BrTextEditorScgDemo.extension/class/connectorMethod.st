*GToolkit-Connector
connectorMethod
	| connector |
	connector := GtConnector new.
	connector addMethod: (BlBezierExamples>>#quadraticCurveWithPerpendicularAnchor).
	
	(Smalltalk tools inspector openOn: connector) extent: (1268.0@1004.0)