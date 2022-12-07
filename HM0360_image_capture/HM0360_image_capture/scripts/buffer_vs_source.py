# -*- coding: utf-8 -*-
"""
Created on Sat Nov 12 18:56:40 2022

@author: miche

This code is used to verify that the source picture corresponds to the buffer
"""

import numpy as np

#Load file
buffer_filename = "buffer_file.txt"
pic_filename = "pic_file.txt"
#Read lines and rearrange buffer to match pic order
buffer_data = np.genfromtxt(buffer_filename, dtype='<U10')
pic_data = np.genfromtxt(pic_filename, dtype='<U10')
for i in range(buffer_data.shape[0]):
    buffer_data[i] = "0b"+buffer_data[i]
    pic_data[i] = "0b"+pic_data[i]
#rearrange buffer data
buffer_matrix = buffer_data.reshape([656,496])
pic_matrix = pic_data.reshape([656,496])
buffer_matrix_modified = np.empty([656,496],dtype='<U10')
for row_up in range(656):
        row_down = 655-row_up
        buffer_matrix_modified[row_up] = buffer_matrix[row_down]
#row_index:       1..656
#column_index:    1..496
#for i in range(buffer_data.shape[0]):
 #   print(i)
  #  row_index = int(i/656)+1
   # column_index = 496*(row_index-1)+1-i
    #When j = 0 we scan the last 496 elements of buffer_data
    #buffer_data_modified[i] = int(buffer_data[-(656)*row_index+column_index-1],2)
diff_index = np.argwhere(buffer_matrix_modified!=pic_matrix)