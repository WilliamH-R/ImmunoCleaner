#' A test function to setup workspace
#'
#' @param foo is a float
#' @param bar is also a float
#' 
#' @importFrom magrittr %>%
#'
#' @return A float calculated from the mathematical expression in the function
#' @export
#'
#' @examples
#' myFunction(1,2)
#' myFunction(4,9)
myFunction <- function(foo, bar){
  # Multiply 'foo' and 'bar'
  foobar <- (foo * bar)
  return(foobar)
}