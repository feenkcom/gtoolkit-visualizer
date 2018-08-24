Extension { #name : #Point }

{ #category : #'*GToolkit-BlocGraph-Layouts' }
Point class >> gtR: radius theta: angle [
	^ (radius * angle cos) @ (radius * angle sin)
]
