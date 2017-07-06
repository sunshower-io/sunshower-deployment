# Deploying Sunshower.io


Creating your own sunshower.io deployment is easy!  Follow the simple steps described below and you're off!  
We'll streamline these as we get time, and as we get our CD system back online, you should be able to deploy with
even less hassle 


### Deploying via Docker

1. `git clone git@gitlab.com:sunshower.io/sunshower-deployment.git`
2. `cd sunshower-deployment`
3. `chmod a+x ./resources/create-certs.sh && source ./resources/create-certs.sh`
4. `docker compose -f docker-compose.yml up -d`

And you should be good to go!  Unfortunately, `create-certs.sh` only generates self-signed certificates.  If you
want CA-signed certificates, we've had great luck with [Let's Encrypt](https://gethttpsforfree.com/).  Follow the (somewhat long)
process to generate a Let's Encrypt-signed certificate and you should be good to go with no additional effort.  


###  Building sunshower.io


// TODO
