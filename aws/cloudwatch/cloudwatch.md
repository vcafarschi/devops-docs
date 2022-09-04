- [Cloudwatch Overview](#cloudwatch-overview)
- [Concepts](#cloudwatch-concepts)
  - [Namespaces](#namespaces)
  - [Metrics]()
    - [Metrics Time Stamps]()
    - [Metrics Retention]()
  - [Dimensions]()
    - [Dimension Combinations]()
  - [Resolution]()
  - [Statistics]()
  - [Units]()
  - [Periods]()
  - [Aggregation]()
  - [Percentiles]()
  - [Alarms]()


# CloudWatch Overview
![](images/cloudwatch-overview.svg)


- CloudWatch is a **monitoring service** for **AWS resources** and **applications** you run on AWS in real time.
- Can be used:
  - to collect and track metrics (CPUUtilization)
  - to collect and monitor log files
  - create alarms
- CloudWatch **alarms monitor metrics** and can be configured to **automatically initiate actions** when a threshold is breached.
- CloudWatch can monitor:
  - the **built-in metrics** that come with AWS (ex. CPUUtilization)
  - or your **custom metrics** (AWS can't monitor DiskUtilization, so you can create this custom metric).
- You can access CloudWatch using :
  - AWS CloudWatch console
  - AWS CLI
  - CloudWatch API
  - AWS SDK
- VPC resources can connect to CloudWatch by creating a CloudWatch VPC Interface Endpoint

- [AWS services that publish CloudWatch metrics](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/aws-services-cloudwatch-metrics.html)

Amazon CloudWatch is a metrics repository

# CloudWatch Concepts
## Namespaces
- A namespace is a container for CloudWatch metrics
- Metrics in different namespaces are isolated from each other
- Metrics from different applications are not aggregated into same statistics
- The AWS namespaces use the following naming convention: AWS/service
  - For instance, EC2 uses the AWS/EC2 namespace.
- You can specify a namespace name when you create a **custom metric**, but you can't specify AWS reserved namespaces.
- There is no default namespace.
- Specify a namespace for each data point (i.e metric value at a point in time - take CPU utilization at a specific time) that you publish to CloudWatch.

-------
- Used to isolate different application and service metrics
- Examples namespaces:
  - EBS: AWS/EBS
  - ELB: AWS/ELB
  - EC2: AWS/EC2

# Metrics
- Metrics are the fundamental concept in CloudWatch.
- A metric represents a **time-ordered set of datapoints** that are published to CloudWatch.
  - Think of a metric as a variable to monitor,
  - The datapoints represent the values of that variable over time.
    - CPU usage of an EC2 instance is one metric provided by Amazon EC2.
- Data points themselves can come from any application or business activity from which you collect data.
- AWS services send metrics to CloudWatch
  - You can send your own custom metrics to CloudWatch.
- **Metrics exist only in the region in which they are created, in other words**,
  - Metrics are completely separate between regions.
- **Metrics are uniquely defined by a name, a namespace, and zero or more dimensions.**
- You can retrieve **statistics** about those **data points** as an ordered set of time-series data
  - Statistics example: average CPU utilization across 5 EC2
- Each datapoint has a time stamp
  - Each metric data point must be marked with a time stamp.
  - If you do not provide a time stamp, Cloud Watch creates time stamp for you based on time the data point was recieved

## Metric Retention
- Metrics cannot be deleted, but they automatically expire after 15 months if no new data is published to them.
- CloudWatch retains metric data as follows:
 - Data points with a period of less than 60 seconds are available for 3 hours. These data points are high-resolution custom metrics.
  - Data points with a period of 60 seconds (1 minute) are available for 15 days
  - Data points with a period of 300 seconds (5 minute) are available for 63 days
  - Data points with a period of 3600 seconds (1 hour) are available for 455 days (15 months)
    - Data points older than 15 months expire on a rolling basis; as new data points come in, data older than 15 months is dropped.
  - Data points that are initially published with a shorter period are aggregated together for long-term storage.

For examples:
- If you collect data using a prediod of 1 minute, the data remains available for 15 days with 1 minute resolution
  - After 15 days this data will still be avaialable, but this is agregated and is retrievable only with a resolution of 5 minutes
  - After 63 days, the data is further agregated ans is avaialbe with resolution of 1 hours
- CloudWatch started retaining 5-minute and 1-hour metric data

# Alarms
- A CloudWatch alarm can be created to watch a **single CloudWatch metric** or the result of a **math expression** based on CloudWatch metrics.
- Alarms can be created or can be based on **CloudWatch Logs metric filters**
- The alarm can perform one or more actions based on the value of the metric or expression relative to a threshold over a number of time periods (the duration of time over which the alarm is evaluated). 
- The possible alarm states:
  - OK – The metric or expression is within the defined threshold
  - ALARM – The metric or expression is outside of the defined threshold (Alarm is triggered)
  - INSUFFICIENT_DATA – The alarm has just started, the metric is not available, or not enough data is available for the metric to determine the alarm state.
- Alarms can be added to CloudWatch dashboards and monitor them visually (They turn RED when in ALARM state).

## Evaluating an Alarm
- When creating an alarm you need to specify:
  - Period (seconds)
    - If you choose one minute as the period, there is one data point every minute
  - Evaluation Period
    - Is the number of the most recent periods, or datapoints to evaluate when determining the alarm state
  - Datapoints to Alarm
    - Is the number of datapoints whithin evaluation period that must be breaching to cause the alarm to go to the **ALARM** state.
    - The breaching datapoint don;t have to be consecutive
    - However they must all be within the last nubmer of datapoints equal to Evaluation Period
- CloudWatch uses these settings to determine the Alarm state.

- If you set an alarm on high-resolution metric, you can specify a high-resolution alarm with a period of 10 or 30 seconds, or oyu can set a regular alarm with a period of any multiple of 60 seconds.
- there is a higher charge for high-resolution alarms

## Alarms - Actions and Targets
- When **action** is triggered by **alarm**?
  - **Alarms** invoke **actions** only for sustained state changes
  - They do not invoke actions because they aer in a particular state
  - The state must have changed and been maintained for a **specified number of periods**
- What happens when alarm is triggered ?
  - CloudWatch Alarms can do Auto Scaling, EC2, or SNS actions only.
  - IMPORTANT: CloudWatch alarms are very limited, they can do the above only actions.
  - IMPORTANT: ONLY CloudWatch **event** can invoke a lambda function (or an SQS queue) based on CloudWatch **alarm**.
  - This is very important for exam.

# CloudWatch Periods

# Dimensions
- Represents a name:value paird that uniquely identifies a metric
- Example EC2 metric dimensions:
  - InstanceId
  - InstanceType
  - ImageId
- Examples ELB metric dimensions:
  - AvailabilityZone
  - LoadBalancerName

# Logging terminology
  - Log Event: the activity being reported
  - Log Stream: represents a sequence of Log Events from the same source
  - Log Group: A grouping of Log Events that have the same properties, policies and access controls
  - Metric Filters: allow us to define which metrics to extract and public to CLoudWatch
  - Retention Policies: Dictate how long the data is kept
  - Log Agent: this is the agent that we can install on EC2 instances to automatically publish log events to CloudWatch.