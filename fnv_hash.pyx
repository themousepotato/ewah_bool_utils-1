"""
Fast hashing routines


"""

#-----------------------------------------------------------------------------
# Copyright (c) 2017, yt Development Team.
#
# Distributed under the terms of the Modified BSD License.
#
# The full license is in the file COPYING.txt, distributed with this software.
#-----------------------------------------------------------------------------

import numpy as np
cimport numpy as np

cimport cython

@cython.wraparound(False)
@cython.boundscheck(False)
cdef np.int64_t c_fnv_hash(unsigned char[:] octets) nogil:
    # https://bitbucket.org/yt_analysis/yt/issues/1052/field-access-tests-fail-under-python3
    # FNV hash cf. http://www.isthe.com/chongo/tech/comp/fnv/index.html
    cdef np.int64_t hash_val = 2166136261
    cdef unsigned char octet
    cdef int i
    for i in range(octets.shape[0]):
        hash_val = hash_val ^ octets[i]
        hash_val = hash_val * 16777619
    return hash_val

def fnv_hash(octets):
    """
    
    Create a FNV hash from a bytestring.
    Info: http://www.isthe.com/chongo/tech/comp/fnv/index.html
    
    Parameters
    ----------
    octets : bytestring
        The string of bytes to generate a hash from. 
    """
    return c_fnv_hash(octets)