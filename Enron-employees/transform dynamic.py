# -*- coding: utf-8 -*-
"""
Created on Thu Mar 22 15:02:31 2018

@author: Tim
"""
import numpy as np
from numpy import genfromtxt
my_data = genfromtxt('ia-enron-employees-121.txt', delimiter=',')

my_data=my_data.astype(int)


#np.savetxt("m_enron_employees_17.csv", my_data[0:,0:2] , delimiter=",",fmt='%1.0f')
np.savetxt("m_enron_employees_17_weighted.csv", my_data[0:,[0,1,3]] , delimiter=",",fmt='%1.0f')
#np.savetxt("m_enron_employees_17_weighted.csv", np.stack((my_data[1:,0], my_data[1:,1], my_data[1:,3])), delimiter=",",fmt="%1.0f")

#np.savetxt("m1_wiki_elec.csv", my_data_split[0][:,0:2], delimiter=",",fmt='%1.0f')
#np.savetxt("m2_wiki_elec.csv", my_data_split[1][:,0:2], delimiter=",",fmt='%1.0f')
#np.savetxt("m3_wiki_elec.csv", my_data_split[2][:,0:2], delimiter=",",fmt='%1.0f')
#np.savetxt("m4_wiki_elec.csv", my_data_split[3][:,0:2], delimiter=",",fmt='%1.0f')