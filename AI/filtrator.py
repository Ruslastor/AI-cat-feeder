import os
import json
from PIL import Image
import numpy

IMAGE_FINAL_SIZE = 128
SAVING_DIRECTORY = 'filtrated_cats'
DIRECTORIES_TO_READ = ['CAT_00','CAT_01','CAT_02','CAT_03','CAT_04','CAT_05','CAT_06']


def filter():
	for path in DIRECTORIES_TO_READ:
		print(f'>>> processing {path}...')
		for file in os.listdir(os.fsencode(path)):
			filename = os.fsdecode(file)
			if filename.endswith(".cat"):
	        	
				image = Image.open(f'{path}/{filename[:-4]}').convert('L')
				w,h = image.size
				image = image.resize((IMAGE_FINAL_SIZE,IMAGE_FINAL_SIZE))
				image.save(f'{SAVING_DIRECTORY}/{filename[:-4]}')

				with open(f'{path}/{filename}', 'r') as to_read:
					points = [ float(i) for i in   to_read.read().split()[1:]]
					for i in range(9):
						points[i * 2] *= IMAGE_FINAL_SIZE/w
						points[i * 2 + 1] *= IMAGE_FINAL_SIZE/h
					with open(f'{SAVING_DIRECTORY}/{filename}', 'w') as to_write:
						to_write.write(','.join([str(int(round(i,0))) for i in points]))
	print('>>> Done!')



#checking directory
print('starting....')
try:
	os.makedirs(SAVING_DIRECTORY)
	filter()
except:
	print(f'>>> remove old "{SAVING_DIRECTORY}" saving directory')
#reading files
