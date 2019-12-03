import os

os.system(f"ffmpeg -i screen.mp4 -vf fps=24 \"%3d.png\"")
