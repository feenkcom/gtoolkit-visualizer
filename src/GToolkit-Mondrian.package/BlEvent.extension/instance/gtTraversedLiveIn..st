*Gtoolkit-Mondrian
gtTraversedLiveIn: anElement
	| aView |

	aView := GtMondrian new.
	self traversedTargetsTreeIn: aView.
	anElement addChild: aView asScalableElement