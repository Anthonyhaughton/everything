# Hosting a Static Website

In this project I have built what I am currenltly running on anthonyhaughton.com. I wanted to be able to redo this as code so if/when I change domains/buckets/etc I can deploy this build and be back up and running in minutes.

In main.tf the providers and account with declared.

In storage.tf the bucket was created and files were uploaded. I also enabled versioning for 
future uploads.

Next in content.tf I created the Cloudfront distro to host my s3 contents. This was a good learning opp as there was a lot that went wrong with applying my terra code. I think knowing syntax and what options conflict with eachother is very important. I created a ACM cert prior to building this stack as when certs are created they need to be vailidated via email (Need FQDN) or DNS (prefered). When trying to build this solution with creating a cert in the code it would fail out because Cloudfront would timeout trying to apply a cert that was still pendng (Invaild). I'm sure there's a way to do this in terraform but I'll come back to it. in the "viewer certificate" block at the bottom you can see where I used a var to pull the existing cert for this build. 

In Cloudfront you are able to force HTTPS by redirecting http -> https. 

Lastly, I bought a domain name "devhaughton.com". Becuase a hosted zone gets created automagically when you buy a domain (in AWS only) I used the data block to tap into the already existing hosted zone and then created a record to point to the cloudfront distro using an alias.

So, after the code is depolyed and finished you can go to devhaughton.com and see the website with SSL cert attached.

It was fun building something that is actually used in prod and being able to mirror the exact things/settings that were defined in the console. Going forward I should include more vars so that if I wanted to I could spin up anthonyhaughton.com as code just by chaging a few lines in my variable file.