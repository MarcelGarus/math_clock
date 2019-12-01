import os

for i in range(8, 837):
	#os.system(f"rm {i:03d}_clock.png")
	os.system(f"convert -extract 1012x606+240+82 {i:03d}.png {i:03d}.png")
