# Experiments with Twitter4J, Stanford NLP Sentiment analysis, Torquebox & Openshift


## Getting started locally.

### Pre-requistites

1. RVM installed

### Installation

Due to file size limitations on Github (100Mb) is is necessary to download the NLP package from stanfords website.
To do this, from the project root directory run

    ./setup

Next you will need to download the gems required for the project.

    bundle install

Next you will need to set up your environment variables dictating your Twitter access credentials.
A helper file has been created for you to edit and source into your environment. Make a copy of this file and edit the contents appropriately.
Please note that 'oauth_env' is listed in the .gitignore file to protect your twitter credentials from accidentally being checked in.

    cp oauth_env.sample oauth_env
    vi oauth_env

To load into your shell environment correctly execute the following

    source ./oauth_env

Finally to run your server

    torquebox run

In a seperate shell window fire up a brower to access the server

    firefox http://localhost:8080/


## Openshift

Work in progress.

Due to github limitations and wanting to sync the repositories there are 2 options for working aorund the jar size issues.

1.  Download the jars, check them in, deploy to OpenShift as normal and not worry about further syncing with github

2.  Ssh into your OpenShift gear and download the jars from there.

## Prior art

Wish I could say I thought of this myself but the excellent article written by Shekhar Gulati was inspirational for a Jruby port.

See https://www.openshift.com/blogs/day-20-stanford-corenlp-performing-sentiment-analysis-of-twitter-using-java
