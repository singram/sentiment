TorqueBox on OpenShift
======================

Here is a quick way to try out your Ruby application running in
TorqueBox on OpenShift.

By default, this quickstart will install the latest incremental
version of TorqueBox. You can specify a different version by tweaking
`.openshift/action_hooks/pre_start_jbossas-7`, but any build older 
than incremental 1294 won't work. ;-)

Running on OpenShift
--------------------

Create an account at http://openshift.redhat.com/

Ensure you have the latest version of the
[client tools](https://www.openshift.com/get-started#cli).

Create a jbossas-7 application from the code in this repository:

    rhc app create -a yourapp -t jbossas-7 --from-code git://github.com/openshift-quickstart/torquebox-quickstart.git

That's it! The first build will take a minute or two, so be patient.
You should ssh to your app and run `tail_all` so you'll have something
to watch while your app deploys.

When you see `Deployed "your-knob.yml"` in the log,
point a browser at the following link (adjusted for your namespace)
and you should see a friendly welcome:

    http://yourapp-$namespace.rhcloud.com

Any changes you push from the `yourapp/` directory will trigger a
redeploy of your app.

Drop in to the `#torquebox` IRC channel on freenode.net if you have any
questions.
