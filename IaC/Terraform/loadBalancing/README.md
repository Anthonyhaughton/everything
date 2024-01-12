# Load Balancing an ASG

In this project we deployed four (at min) EC2 instances across four different AZ's in a ASG behind a ALB. We used a VPC module we created earlier and did most of the work in the compute and alarm.tf files. I came back to this on the 30th to clean up the VPC module and make more vars to be more modular. I think I can probably do the same for the other tf files but I feel pretty confident at this point with creating most items in a VPC and things like ASG's/Alarms/Instances but I want to work on another proj with an ALB or NLB.

When this code is deployed you will get "alb_dns_name = "dev-lb-tf-example.us-east-1.elb.amazonaws.com"" as output. When you paste that into a browser you'll be able to hit a page that is showing it's IP. If yor refresh the page it should go to another webserver with a different IP. I kept the routing basic but you can set routing on a bunch of different factors. Just like my previous project, the CPU Util is monitored so when the ASG takes on load it is able to scale out and in. 

One of the places I got stuck for a bit was figuring why the ALB wasn't showing what my webservers were displaying.  It was like my ASG and ALB were working indepenendently. After digging I found that the target group I created had zero machines register so I tried to add them manually to see if permissions was the issue but it worked fine. To ge them to mesh I was missing was a "aws_autoscaling_attachment" this took in the ash.id and the target_group.id. After this was defined the instances would spin up and be added to the tg.

Next I'm looking to dive into other services and maybe mess around with DB's and queuing services..

Architecture for this build but instead of west it's east bc west doesn't have 4 AZs up currently.

![img](./docs/img.png)