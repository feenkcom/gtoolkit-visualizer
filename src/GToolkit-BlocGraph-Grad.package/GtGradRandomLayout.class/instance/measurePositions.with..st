measure
measurePositions: anElement with: anExtentSpec
"
Some force-directed layouts, including Kamada-Kawai fail if
all nodes have the same initial position. So the idea is to
call this layouter first, as it should set random positions of
graph's nodes. The layouter can also be used on its own,
if someone needed it for any reason
"