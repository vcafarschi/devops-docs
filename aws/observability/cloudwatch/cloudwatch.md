# CloudWatch
- [Cloudwatch Overview](#cloudwatch-overview)
- [CloudWatch vs CloudTrail](#cloudwatch-vs-cloudtrail)
- [Concepts](#cloudwatch-concepts)
  - [Namespaces](#namespaces)
  - [Metrics](#metrics)
    - [Metrics Time Stamps](#metric-time-stamps)
    - [Metrics Retention](#metric-retention)
    - [Metrics Resolution](#metrics-resolution)
  - [Dimensions](#dimensions)
    - [Dimension Combinations]()
  - [Statistics](#statistics)
  - [Units](#units)
  - [Periods](#periods)
  - [Percentiles](#percentiles)
  - [Alarms](#alarms)
- [Pricing of AWS CloudWatch]()
- [Cross-account cross-Region CloudWatch]()

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
  - or your **custom metrics** (AWS can't monitor DiskUtilization, so you can create this custom metric. Or any applicatiob generated metric).
- CloudWatch **Events** delivers a **near real-time stream** of system **events** that describe changes in AWS resources.
- You can access CloudWatch using :
  - AWS CloudWatch console
  - AWS CLI
  - CloudWatch API
  - AWS SDK
- VPC resources can connect to CloudWatch by creating a CloudWatch VPC Interface Endpoint
- [AWS services that publish CloudWatch metrics](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/aws-services-cloudwatch-metrics.html)

# CloudWatch vs CloudTrail
| CloudWatch                                              | CloudTrail                                                               |
| --------------------------------------------------------| ------------------------------------------------------------------------ |
| Performance monitoring                                  | Auditing (**Who** performed **what** actions and **when** on your resources)|
| Log events across AWS Services – think operations       | Log API activity across AWS services – think activities, or who to blame |
| Higher-level comprehensive monitoring and event service | More low-level, granular                                                 |
| Log from multiple accounts                              | Log from multiple accounts                                               |
| Logs stored indefinitely                                | Logs stored to S3 or CloudWatch indefinitely                             |
| Alarms history for 14 days                              | No native alarming; can use CloudWatch alarms                            |

# CloudWatch Concepts
## Namespaces
- A namespace is a container for CloudWatch metrics
- Used to isolate different application and service metrics
- Metrics in different namespaces are isolated from each other
- Metrics from different applications are not aggregated into same statistics
- There is no default namespace.
- You **must specify a namespace** for **each data point** that you publish to CloudWatch.
- The AWS namespaces use the following naming convention: **AWS/service**
  - Examples namespaces:
    - EBS: AWS/EBS
    - ELB: AWS/ELB
    - EC2: AWS/EC2
- You can specify a namespace name when you create a **custom metric**, but you can't specify AWS reserved namespaces.



# Metrics
- Metrics are the fundamental concept in CloudWatch.
- A metric represents a **time-ordered set of datapoints** that are published to CloudWatch.
  - Think of a **metric** as a **variable** to monitor and **datapoints** represent the **values** of that variable over time.
    - CPU usage of an EC2 instance is one metric provided by Amazon EC2.
- Data points themselves can come from any application or business activity from which you collect data.
- AWS services send metrics to CloudWatch
  - You can send your own custom metrics to CloudWatch.
- **Important note for EC2 metrics**: CloudWatch does not collect memory utilization and disk space usage metrics right from the get go. You need to install CloudWatch Agent in your instances first to retrieve these metrics.
- **Metrics exist only in the region in which they are created, in other words**,
  - Metrics are completely separate between regions.
- **Metrics are uniquely defined by a name, a namespace, and zero or more dimensions.**
- You can retrieve **statistics** about those **datapoints** as an ordered set of time-series data
  - Statistics example: average CPU utilization across 5 EC2
- **Metric** math enables you to query multiple CloudWatch metrics and use math expressions to create new time series based on these metrics.


## Metric Time Stamps
- Each metric data point must be associated with a time stamp
  - Each metric data point must be marked with a time stamp.
  - If you do not provide a time stamp, Cloud Watch creates time stamp for you based on time the data point was recieved


## Metric Retention
- **Metrics cannot be deleted**, but they automatically **expire after 15 month**s if no new data is published to them.
- CloudWatch retains metric data as follows:
 - Data points with a period of less than 60 seconds are available for 3 hours. These data points are high-resolution custom metrics.
  - Data points with a period of 60 seconds (1 minute) are available for 15 days
  - Data points with a period of 300 seconds (5 minute) are available for 63 days
  - Data points with a period of 3600 seconds (1 hour) are available for 455 days (15 months)
    - Data points older than 15 months expire on a rolling basis; as new data points come in, data older than 15 months is dropped.
  - Data points that are initially published with a shorter period are aggregated together for long-term storage.

For example:
- If you collect data using a prediod of 1 minute, the data remains available for 15 days with 1 minute resolution
  - After 15 days this data will still be avaialable, but this is agregated and is retrievable only with a resolution of 5 minutes
  - After 63 days, the data is further agregated ans is avaialbe with resolution of 1 hours
- CloudWatch started retaining 5-minute and 1-hour metric data

## Metrics Resolution
- Each metric is one of the following:
  -**Standard resolution**, with data having a one-minute granularity 
  -**High resolution**, with data at a granularity of one second
- Metrics produced by AWS services are standard resolution by default
- When you publish a custom metric, you can define it as either standard resolution or high resolution.
- When you publish a high-resolution metric, CloudWatch stores it with a resolution of 1 second, and you can read and retrieve it with a period of 1 second, 5 seconds, 10 seconds, 30 seconds, or any multiple of 60 seconds.
- High-resolution metrics can give you more immediate insight into your application’s sub-minute activity.
- Keep in mind that every PutMetricData call for a custom metric is charged, so calling PutMetricData more often on a high-resolution metric can lead to higher charges
- If you set an alarm on a high-resolution metric, you can specify a high-resolution alarm with a period of 10 seconds or 30 seconds, or you can set a regular alarm with a period of any multiple of 60 seconds.
- There is a higher charge for high-resolution alarms with a period of 10 or 30 seconds.


# Dimensions
- Represents a **name/value pair** that uniquely identifies a metric
- You can assign up to 10 dimensions to a metric.
- Whenever you add a unique dimension to one of your metrics, you are creating a new variation of that metric.
- Example EC2 metric dimensions:
  - InstanceId
  - InstanceType
  - ImageId
- Examples ELB metric dimensions:
  - AvailabilityZone]
- With **put-metric-data**, you specify each dimension as **MyName=MyValue**
- With **get-metric-statistics** or **put-metric-alarm** you use the format **Name=MyName, Value=MyValue**
- For example, the following command publishes a Buffers metric with two dimensions named InstanceId and InstanceType.
  ```bash
  aws cloudwatch put-metric-data  \
      –metric-name Buffers –namespace MyNameSpace \
      –unit Bytes –value 231434333 \
      –dimensions InstanceId=1-23456789, InstanceType=m1.small
  ```
- This command retrieves statistics for that same metric. Separate the Name and Value parts of a single dimension with commas, but if you have multiple dimensions, use a space between one dimension and the next.
  ```bash
  aws cloudwatch get-metric-statistics \
    –metric-name Buffers –namespace MyNameSpace \
    –dimensions Name=InstanceId, Value=1-23456789 Name=InstanceType, Value=m1.small \
    –start-time 2016-10-15T04:00:00Z –end-time 2016-10-19T07:00:00Z \
    –statistics Average –period 60
  ```
- If a single metric includes multiple dimensions, you must specify a value for every defined dimension when you use get-metric-statistics.
    - For example, the Amazon S3 metric **BucketSizeBytes** includes the **dimensions** *BucketName* and *StorageType*, so you must specify both dimensions with get-metric-statistics.
    ```
    aws cloudwatch get-metric-statistics \
    –metric-name BucketSizeBytes \
    –start-time 2017-01-23T14:23:00Z –end-time 2017-01-26T19:30:00Z \
    –period 3600 \
    –namespace AWS/S3 \
    –statistics Maximum \
    –dimensions Name=BucketName,Value=MyBucketName Name=StorageType,Value=StandardStorage \
    –output table
    ```

# Statistics
- Statistics are metric data aggregations over specified periods of time.
- CloudWatch provides statistics based on the **metric data points** provided by your **custom data** or provided by **other AWS services** to CloudWatch
- Aggregations are made using the namespace, metric name, dimensions, and the data point unit of measure, within the time period you specify.

| Statistic   | Description                                                                                                                               |
| ----------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| Minimum     | The lowest value observed during the specified period. You can use this value to determine low volumes of activity for your application   |
| Maximum     | The highest value observed during the specified period. You can use this value to determine high volumes of activity for your application |
| Sum         | All values submitted for the matching metric added together. This statistic can be useful for determining the total volume of a metric    |
| Average     | The value Sum/SampleCount during the specific period. By comparing this statistic with the Minimum and Maximum you can determine the full scope of a metric and how close the average is to the Minimum and Maximum. This comparison helps you know when to increase or decrease your resources as needed |
| SampleCount | The count (number) of data points used for the statistical calculation.                                                                   |
| pNN.NN      | The value of the specified percentile. You can specify and percentile using up to two decimal places (e.. p45.45). Percentile statistics are not available for metric that include negative values. For more information see Percentiles |

## Units
- Each statistic has a **unit of measure**
  - Example units include Bytes, Seconds, Count, and Percent
- Metric data points that specify a unit of measure are aggregated separately
- You can specify a unit when you create a custom metric. 
- If you do not specify a unit, CloudWatch uses None as the unit.


## Periods
- A period is the length of time associated with a specific CloudWatch statistic. 
  - The default value is 60 seconds.
- CloudWatch aggregates statistics according to the period length that you specify when retrieving statistics.
- For large datasets, you can insert a pre-aggregated dataset called a statistic set.


## Percentiles
- A percentile indicates the relative standing of a value in a dataset. 
- For example, the 95th percentile means that 95 percent of the data is lower than this value and 5 percent of the data is higher than this value
- **Percentiles are often used to isolate anomalies.**
- 
- Some CloudWatch metrics support percentiles as a statistic
  - For these metrics, you can monitor your system and applications using percentiles as you would when using the other CloudWatch statistics (Average, Minimum, Maximum, and Sum)
  - The following AWS services include metrics that support percentile statistics.
    - API Gateway
    - Application Load Balancer
    - Amazon EC2
    - Elastic Load Balancing
    - Kinesis
    - Amazon RDS 
- Percentile statistics are available for custom metrics as long as you publish the raw, unsummarized data points for your custom metric
  - Percentile statistics are not available for metrics when any of the metric values are negative numbers



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



# Logging terminology
  - Log Event: the activity being reported
  - Log Stream: represents a sequence of Log Events from the same source
  - Log Group: A grouping of Log Events that have the same properties, policies and access controls
  - Metric Filters: allow us to define which metrics to extract and public to CLoudWatch
  - Retention Policies: Dictate how long the data is kept
  - Log Agent: this is the agent that we can install on EC2 instances to automatically publish log events to CloudWatch.

# Pricing of AWS CloudWatch
**Free Tier of AWS CloudWatch**
- Most of the Amazon Services, such as S3, Kinesis, EC2, and others, are destined to send valuable metrics for free onto CloudWatch. The process of sending insights is automatic without any external efforts. Most of the applications should be destined to operate seamlessly over these free tier limits. Get an idea about the free tier of AWS by referring to this link!
- The perks that you get upon using the free tier of Amazon CloudWatch are as follows:
  - Basic monitoring metrics at 5-minute frequency.
  - 10 detailed monitoring of the metrics, at 1-minute frequency
  - It supports one million API requests. But it is not applicable to GetMetricWidgetImage and GetMetricData.
  - You get 3 dashboards with up to 50 metrics every month.
  - You get ten metrics for alarms. But you cannot integrate the same for high-resolution scenarios.
  - All of the events are inclusive within the free tier, except the custom events.
  - You get 5GB space for data ingestion, archiving storage, or storing data that are scanned by the Logs Insights queries.
  - You get one contributor insights rule every month.
  - You also get 100 canary runs every month.
  - These are all you get within the free tier of Amazon CloudWatch, which is more than sufficient for most of your applications.

**Paid Tier of AWS CloudWatch**
- As stated above, you only need to pay for what you use over AWS CloudWatch, and nothing up-front. AWS CloudWatch is offering you a price calculator to let you calculate the architecture and CloudWatch cost within a single estimate. But, here are some of the preset amounts that you will be charged within the paid tier.

- **Charges as per the Metrics**
  - You need to pay $0.30 per metric per month for the first 10,000 metrics.
  - For the next 240,000 metrics, you will have to pay $0.10 per metric per month.
  - For the next 750,000 metrics, you will have to pay $0.05 per metric per month.
  - For over 1,000,000 metrics, you will have to pay $0.02 metric per month.
- **Charges as per the APIs**
  For GetInsightRuleReport and GetMetricData, you will have to pay $0.01 for every 1000 metrics that you request.
  For GetMetricWidgetImage API, you will have to pay $0.02 for every 1000 metrics that you request.
  For GetMetricStatistics, PutMetricData, ListDashboards, ListMetrics, DeleteDashboards, and PutDashboard API requests, you will have to pay $0.01 for every 1000 metrics that you request.
- **Charges of the Dashboard**
  - You will be charged around $3.00 for every AWS CloudWatch dashboard that you use. All of it will be billed at the end of every month.

- **Charges as per the Alarms**
  - For alarms of the standard resolution, you will have to pay $0.10/alarm metric.
  - For alarms of high resolution, you will have to pay $0.30/alarm metric.
  - For alarms of standard resolution anomaly detection, you will have to pay $0.30/alarm metric.
  - For alarms of high-resolution anomaly detection, you will have to pay $0.90/alarm metric.
  - For composite alarms, you will have to pay $0.50/alarm metric.
- **Charges as per the Logs**
  - Data collection or ingestion demands you to pay $0.67/GB.
  - Data or archival storage demands you to pay $0.033/GB.
  - Data analysis or logs insights query demands you to pay $0.0067/GB data scanned.
- **Charges as per Events**
  - You need to pay $1.00/million events for custom events.
  - You need to pay $1.00/million events for cross-account events.
- **Charges as per Contributor Insights**
  - The fee for every contributor insight rule is $0.50/rule/month.
  - You need to pay $0.027 for every 1 million log events/month that matches the rule.
- **Charges as per Canary Runs**
  - You will be charged $0.0017 for every canary run that you execute over AWS CloudWatch.

# Cross-account cross-Region CloudWatch