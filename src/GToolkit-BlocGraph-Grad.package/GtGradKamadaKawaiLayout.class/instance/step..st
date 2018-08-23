private-layout
step: theNodes
	| maxDeltaNode nodeWithMaxDelta nodeWithMaxDeltaIndex deltaNode loopIndex thresholdReached energy nodesNum |
	self currentIteration: self currentIteration + 1.
	maxDeltaNode := 0.
	nodeWithMaxDeltaIndex := -1.
	theNodes
		doWithIndex: [ :aNode :index | 
			deltaNode := self
				calculateDeltaNode: theNodes
				node: aNode
				nodeIndex: index.
			deltaNode > maxDeltaNode
				ifTrue: [ maxDeltaNode := deltaNode.
					nodeWithMaxDelta := aNode.
					nodeWithMaxDeltaIndex := index ] ].
	nodeWithMaxDeltaIndex > -1
		ifFalse: [ ^ self ].
	loopIndex := 1.
	thresholdReached := false.
	[loopIndex <= 100 and: [ thresholdReached not ]]
		whileTrue: [ | dxy nodePosition newNodePositionX newNodePositionY |
			dxy := self
				calculateDeltaPositionNode: theNodes
				node: nodeWithMaxDelta
				nodeIndex: nodeWithMaxDeltaIndex.
			nodePosition := nodeWithMaxDelta constraints gradKamadaKawai
				computedPosition.
			newNodePositionX := nodePosition x + dxy x.
			newNodePositionY := nodePosition y + dxy y.
			nodeWithMaxDelta constraints gradKamadaKawai
				computedPosition: newNodePositionX @ newNodePositionY.
			thresholdReached := (self
				calculateDeltaNode: theNodes
				node: nodeWithMaxDelta
				nodeIndex: nodeWithMaxDeltaIndex) < self epsilon ].
	self adjustForGravity
		ifTrue: [ self shiftNodesToTheCenterOfGavity: theNodes ].
	(self exchangeNodes and: [ maxDeltaNode < self epsilon ])
		ifFalse: [ ^ self ].
	energy := self calculateEnergy: theNodes.
	nodesNum := theNodes count.
	1 to: nodesNum do: [ :i | 
		i + 1 to: nodesNum do: [ :j | 
			| exenergy firstNode secondNode position1 position2 |
			exenergy := self
				calculateEnergyIfExchanged: theNodes
				firstNodeIndex: i
				secondNodeIndex: j.
			energy > exenergy
				ifTrue: [ firstNode := theNodes at: i.
					secondNode := theNodes at: j.
					position1 := firstNode constraints gradKamadaKawai
						computedPosition.
					position2 := secondNode constraints gradKamadaKawai
						computedPosition.
					firstNode constraints gradKamadaKawai computedPosition: position2.
					secondNode constraints gradKamadaKawai
						computedPosition: position1 ] ] ]