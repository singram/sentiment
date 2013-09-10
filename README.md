# TorqueBox on OpenShift

Here is a quick way to try out your Ruby application running in
TorqueBox on OpenShift.

By default, this quickstart will install TorqueBox 3.0.0.  You
can specify a different version by tweaking
`.openshift/torquebox.sh`, but any release older
than 3.0.0.beta1 won't work. ;-)


## Running on OpenShift

Create an account at http://openshift.redhat.com/

Ensure you have the latest version of the
[client tools](https://www.openshift.com/get-started#cli).

Create a jbossas-7 application from the code in this repository:

    rhc app create -a yourapp -s -t jbossas-7 --from-code git://github.com/openshift-quickstart/torquebox-quickstart.git

That's it! The first build will take a minute or two, so be patient.
You should ssh to your app and run `tail_all` so you'll have something
to watch while your app deploys.

When you see `Deployed "your-knob.yml"` in the log,
point a browser at the following link (adjusted for your namespace)
and you should see a friendly welcome:

    http://yourapp-$namespace.rhcloud.com

Any changes you push from the `yourapp/` directory will trigger a
redeploy of your app.

At this point, you can either write your app from scratch, or you can
merge in changes from an existing project, i.e. your real app.

    git remote add yourrealapp -m master git@github.com:yourorg/yourrealapp.git
    git pull -s recursive -X theirs yourrealapp master
    git push

Now whenever you're ready to deploy your real app to OpenShift, you
pull in changes from your real repo and push to your OpenShift repo.

Drop in to the `#torquebox` IRC channel on freenode.net if you have any
questions.


## Zero Downtime Deployments

If you'd like to take advantage of zero downtime deployments provided
by TorqueBox, you'll need to add an OpenShift-specific `hot_deploy`
marker file to tell OpenShift not to restart TorqueBox and the
TorqueBox-specific zero downtime deployment marker.

    touch .openshift/markers/hot_deploy
    git add .openshift/markers/hot_deploy
    mkdir -p tmp
    touch tmp/restart.txt
    git add tmp/restart.txt
    git commit -m "Use zero downtime deploys for the web runtime"
    git push

Now every time you push code the TorqueBox web runtime will be
restarted without dropping any web requests. See
http://torquebox.org/documentation/current/deployment.html#zero-downtime-redeployment
for the different markers you can use to restart non-web runtimes.

To switch back to regular deployments, remove
`.openshift/markers/hot_deploy` and `tmp/restart.txt`, commit, and
push the application.


## Database Migrations

If you have a Rails application and want to run database migrations on
every new code push, uncomment the `db_migrate` line from
`.openshift/action_hooks/pre_start_jbossas-7`. If you don't use Rails
and still need to run migrations, edit the `db_migrate` function in
`.openshift/torquebox.sh` to fit your needs.


## Connecting VisualVM to TorqueBox on OpenShift

You can use OpenShift's port forwarding feature to connect a local
VisualVM to your TorqueBox instances running in OpenShift. In a local
terminal window, initiate port forwarding:

    rhc port-forward -a yourapp

Take note of which local port the remote port 9999 gets forwarded to -
this should be 9999 unless you already have something listening
locally on that same port.

Now we need to boot VisualVM with the `jboss-cli-client.jar` on the
classpath. This JAR is found within the TorqueBox distribution.

    jvisualvm --cp:a $TORQUEBOX_HOME/jboss/bin/client/jboss-cli-client.jar

Now add a new JMX Connection in VisualVM (File -> Add JMX Connection)
and enter `service:jmx:remoting-jmx://localhost:9999` as the
connection string, substituting port 9999 if necessary. No security
credentials are needed.

After the connection is added, double-click on it in VisualVM's left
pane to connect to the remote TorqueBox server.
