## CacheMatrix

Routines for creating a special numeric matrix, calculating its inverse, and caching that inverse for later use.

### CONTAINS:
 - makeCacheMatrix( x=matrix() ): This function returns a special matrix object (CacheMatrix) with the following methods:
   - set(y)   : set the cached matrix to y and initialize the inverse to NULL
   - get()    : get the cached matrix
   - setInv(y): set (cache) the inverse of the matrix to y
   - getInv() : return the inverse of the cahced matrix

   - Formally, the function returns a list with the above functions, i.e., methods of the object. A matrix object can be passed to the function when the CacheMatrix object is created.  Otherwise, an empty matrix object is created and cached. 

 - cacheSolve(x, ...)
   - Takes a CacheMatrix object as an argument. The "..." is used to pass arguments to the solve function for matrix inversion.

   - This function returns the inverse of a matrix stored in a CacheMatrix object, which is a matrix-like object created using makeCacheMatrix. The routine first determines whether the inverse of the matrix that is stored in CacheMatrix object  exists. If it does exist, the function simply returns the inverse.  If the inverse does not yet exist, the inverse is  calculated, cached, and the inverse is returned.  

   - NOTE: cacheSolve assumes that the matrix is invertible and is square (through use of "solve").
