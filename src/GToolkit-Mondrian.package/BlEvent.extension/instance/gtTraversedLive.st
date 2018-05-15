*Gtoolkit-Mondrian
gtTraversedLive
	| aView |

	aView := GtMondrian new.
	self traversedTargetsTreeWith: aView.
	^ aView asScalableElement