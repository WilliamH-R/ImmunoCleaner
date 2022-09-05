RemovePrefix <- function(data){
  data %>% 
    mutate(across(.cols = matches("^TR[A|B]"),
                  .fns = str_replace,
                  pattern = "TR[A|B]:",
                  replacement = ""))
}
