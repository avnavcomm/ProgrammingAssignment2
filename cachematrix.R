####### cachematrix.R #################################################
##
## Routines for creating a special numeric matrix, calculating its 
## inverse, and caching that inverse for later use.
## 
## CONTAINS:
##    makeCacheMatrix( x=matrix() )
##        This function returns a special matrix object (CacheMatrix) 
##        with the following methods:
##           set(y)    -- set the cached matrix to y and initialize the
##                        inverse to NULL
##           get()     -- get the cached matrix
##           setInv(y) -- set the inverse of the matrix to y
##           getInv()  -- return the inverse of the matrix
## 
##         Formally, the function returns a list with the above 
##         functions, i.e., methods of the object. A matrix object
##         can be passed to the function when the CacheMatrix object
##         is created.  Otherwise, a matrix object (1X1, NA) is created 
##         and cached. 
##    
##    cacheSolve(x, ...)
##        Takes a CacheMatrix object as an argument. The "..." is used
##        to pass arguments to the solve function for matrix inversion.
##
##        This function returns the inverse of a matrix stored in
##        a CacheMatrix object, which is a matrix-like object created 
##        using makeCacheMatrix. The routine first determines whether 
##        the inverse of the matrix that is stored in the CacheMatrix  
##        object exists. If it does exist, the function simply returns 
##        the inverse.  If the inverse does not yet exist, the inverse   
##        is calculated, cached, and the inverse is returned.
##
##        NOTE: cacheSolve assumes that the matrix is invertible and is 
##              square (through use of "solve").
##
#######################################################################


makeCacheMatrix <- function(x = matrix()) {
    ## Takes a matrix object.  If none is supplied, create one (1X1, NA). 
    ##
    ## initialize inverse inv to NULL
    inv <- NULL
    ##
    ## Define set method (cache a matrix, set the inverse to NULL).
    set <- function(y){
        x <<- y
        inv <<- NULL
    }
    ## 
    ## Define the get method (return the cached matrix).
    get <- function() x
    ##
    ## Define setInv method (cache the inverse).
    setInv <- function(inverse) inv <<-inverse
    ##
    ## Define getInv method (recall a cached inverse).
    getInv <- function() inv
    ##
    ## Return CachedMatrix object (which is a list).
    list(set = set, get = get, setInv = setInv, getInv = getInv)
}

cacheSolve <- function(x, ...) {
    ## Pass in a CacheMatrix object and any arguments to be passed to 
    ## the solve function via "..." .
    ##
    ## Use the getInv method to recall the cached matrix inverse.
    inv <- x$getInv()
    ##
    ## If the cached matrix inverse is not NULL, print message and 
    ## return the inverse.
    if(!is.null(inv)){
            message("getting cached data")
            return(inv)
    }
    ##
    ## The cached matrix inverse is NULL.  It must be calculated. 
    ## Get the cached matrix.
    data <- x$get()
    ##
    ## Calculate the inverse of the cached matrix. 
    inv <- solve(data, ...)
    ##
    ## Use the setInv method to cache the matrix inverse in the 
    ## corresponding CacheMatrix object.
    x$setInv(inv)
    ##
    ## Return the matrix inverse.
    inv
}
