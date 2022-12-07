# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""

import numpy as np

#Create Matrix
horizontal_size = 656
vertical_size = 496
pic = np.random.rand(horizontal_size, vertical_size)*255
pic = pic.astype(int)
pic_filename = "pic_file.txt"
f = open(pic_filename, "w")
#Convert Values into binary
for i in range(pic.shape[0]):
    for j in range(pic.shape[1]):
        f.write((8-len(str(bin(pic[i,j])).replace("0b","")))*'0'+ str(bin(pic[i,j]).replace("0b",""))+"\n")
f.close()

