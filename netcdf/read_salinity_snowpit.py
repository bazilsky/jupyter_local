import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import matplotlib as mpl



# Read in the data from .tab file
data = pd.read_csv('MOSAiC_snowpits_13_salinity.tab', sep='\t', header=0, skiprows=1, skipfooter=1, engine='python')

