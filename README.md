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


###  Building and running sunshower.io


Building sunshower.io from source is pretty easy.  Unfortunately, we don't yet have all of our projects deployed into
a public repository, so you'll have to build them and deploy them yourself (we provide scripts!).  So, to begin, 
- install [Maven](https://maven.apache.org/index.html), 
- install [Gradle](https://www.gradle.com)
- check out the sunshower.io aggregator project via: `git clone git@gitlab.com:sunshower.io/sunshower.io.git && cd sunshower.io && git submodule update --init --recursive`
- generate a self-signed certificate using keytool `keytool -genkey -alias mydomain -keyalg RSA -keystore keystore.jks -keysize 2048`. 
-- Make a note of the keystore password and keystore location (e.g. `$CWD/keystore.jks`)--it'll be used below
- install Postgres (note: sunshower *should* work with H2 in Postgres mode, but it's not guaranteed to). (not required for building, but required for installation)
- provide sunshower with your database URL.  You can do this by either setting the following environment variables or properties:
-- `SUNSHOWERDB_URL` *or* `--jdbc.url` to the database URL (e.g `jdbc:postgresql://localhost:5432/sunshower`)
-- `SUNSHOWERDB_USERNAME` *or* `--jdbc.username` to the database sunshower user's username
-- `SUNSHOWERDB_PASSWORD` *or* `--jdbc.password` to the database sunshower user's password 
-  Create a self-signed certificate to use via keytool, and set server.ssl.key-store to `<location of keystore>` (e.g. sunshower.jks--but don't use ours)
- Build all the projects via `chmod a+x ./build-all.sh && ./build-all.sh` (this can take a while)
- CD into sunshower-web and run the project via 
        ```
        java -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005 \
        -jar web-service/build/libs/web-service-1.0.0-SNAPSHOT.jar \
        --server.ssl.key-store-password=<keystore pw> \
        --administration.user.username=administrator \
        --administration.user.password=<administrator password> \
        --server.ssl.key-alias=sunshower.io \
        --server.ssl.key-store=file:<keystore file> \
        --administration.user.email-address=<administrator-email>
        ```
        
If everything goes well, you should be able to navigate to         



