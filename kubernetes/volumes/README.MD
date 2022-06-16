Volumes in K8s allow you to store data outside the ocntainer.
When a container stops, all data on the container inteslf is lost.
That's why using stteless apps is better, becase they dont keep a local stare, but store their state in an external service.

External service like a database, caching servers or S3.

Persistent Volumes allow you to attach a volume to a container that will exist even when the container stops.

Volumes can be attached using different volume plugins: AWS cloud (EBS), Google Cloud (Google disk) Network storage (NFS, Cephfs)

Using volumes, you could deploy applications with state on your cluster. Those apps need to read/write to files on the local filesystem that need to be persistent in time.

If your node goes down, pod can be rescheduled on another node and the volume can be attached to the new node. Keep in mind that those nodes should be in the same availability zone, because EBS volumes are attacehd to node in the same AZ.