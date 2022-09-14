from math import *
import numpy as np

def sci(num):
    return "{:e}".format(num)

def expi(th):
    return complex(cos(th), sin(th))

def rad(graus):
    return pi * graus / 180.0
