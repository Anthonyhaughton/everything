# Revamping Project 1

## Trying to rebuild Project 1 but better..


In project 1 I succesfully built a highly availble architecture from Terraform but 
the build was sloppy and my main.tf file was very long so it's hard to see what is actually 
happening. 

In Project 1.5 I will attempt to learn more about terraform best practices and file structure in an attempt to clean up my code by breaking down the main file into sections like networking, compute, etc. 

I'll try to use modules to clean up the code and make it more modular.

I will also try to better use varibles with default values and the .tfvars file so that I can plug in the 
values in one location and be able to hand off this stack to a developer to build the arch he needs.

12/29/23: I was able to fix a issue I was having with deploying this build but I was able to reuse a block in my lamp proj and fix it!! More deets in modules/vpc/outputs.tf
