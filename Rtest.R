# Example of a poorly designed R script
factorial_calc<-function(n){
if(n<0){
stop("Factorial is not defined for negative numbers")
}
if(n==0||n==1){
return(1)
}
result<-1
for(i in 2:n){
result<-result*i
}
return(result)
}

library(dplyr)
x<-factorial_calc(5)
print(x)
