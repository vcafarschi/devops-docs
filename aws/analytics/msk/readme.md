# MSK (Apache Kafka)



## Commit log

- These are append-only sequences of records order by time. More importantly, these logs are the source of truth for the state of data across the entire organization. And, because this state is centralized, it can then become the source of truth for a horizontally scaled, ever-evolving, multi-faceted application architecture.
- You can think of a log as acting as a kind of messaging system with durability guarantees and strong ordering semantics. In distributed systems, this model of communication sometimes goes by the (somewhat terrible) name of atomic broadcast. (Kindle, Location 295)

- [MSK (Apache Kafka)](#msk-apache-kafka)
  - [Commit log](#commit-log)
  - [Use cases](#use-cases)
  - [Architecture](#architecture)
    - [Messages](#messages)
    - [Message Delivery](#message-delivery)
    - [Schemas](#schemas)
    - [Topics](#topics)
    - [Partitions](#partitions)
    - [Brokers](#brokers)
  - [Producers](#producers)
    - [Reliability](#reliability)
  - [Consumers](#consumers)
  - [Zookeeper](#zookeeper)



## Use cases

## Architecture

- Brokers and Clusters
- Messages and Schemas
- Stream Processor
- Connector

### Messages

- The unit of data within Kafka is called a message
- From database point of view, you can think of this as similar to a row or a record
- A message is simply an array of bytes as far as Kafka is concerned, so the data contained within it does not have a specific format or meaning to Kafka

---

- A message can have an optional piece of metadata, which is referred to as a **key**
- The key is also a byte array and, as with the message, has no specific meaning to Kafka.
- Keys are used when messages are to be written to partitions in a more controlled manner.

---

- For efficiency, messages are written into Kafka in **batches**.
- An individual round trip across the network for each message would result in excessive over‐head, and collecting messages together into a batch reduces this.
- Batches are also typically compressed, providing more efficient data trans‐fer and storage at the cost of some processing power

---

### Message Delivery

- Message delivery can take at least one of the following delivery method
- AT LEAST ONCE
- AT MOST ONCE
- EXACTLY ONCE

### Schemas

- While messages are **byte arrays** to Kafka itself, it is recommended that additional **structure**, or **schema**, be imposed on the message content so that it can be easily understood.
- There are many options available for message schema (**JSON, XML**)
- However, they **lack** features such as **robust type handling** and **compatibility between schema versions**
- Many Kafka developers favor the use of **Apache Avro**, which is a **serialization framework** originally developed for **Hadoop**
- Avro provides a **compact serialization format**, **schemas** that are **separate** from the message **payloads** and that do not require code to be generated when they change, and strong data typing and schema evolution, with both backward and forward compatibility.

---

- **A consistent data format is important in Kafka, as it allows writing and reading messages to be decoupled.**
- When these tasks are tightly coupled, applications that subscribe to messages must be updated to handle the new data format, in parallel with the old format.
- Only then can the applications that publish the messages be updated to utilize the new format.

### Topics

- Messages in Kafka are categorized into **TOPICS**
- A topic is a logical channel to which producers publish message and from which the consumers receive messages

- A topic is a stream of a particular data (Collection of Messages), that belongs to a category/label or feed name.
- Moreover, here messages are structured or organized. A particular type of messages is published on a particular topic
- Basically, at first, a producer writes its messages to the topics. Then consumers read those messages from topics.
- In a Kafka cluster, a topic is identified by its name and must be unique.
- There can be any number of topics, there is no limitation
- We can not change or update data, as soon as it gets published (Immutable)
- TOPICS are divided into **PARTITIONS**

### Partitions

- In a Kafka cluster, Topics are split into Partitions and also replicated across brokers.
- However, to which partition a published message will be written, there is no guarantee about that
- Also, we can add a key to a message. Basically, we will get ensured that all these messages (with the same key) will end up in the same partition if a producer publishes a message with a key. Due to this feature, Kafka offers message sequencing guarantee. Though, unless a key is added to it, data is written to partitions randomly.
- Moreover, in one partition, messages are stored in the sequenced fashion.
- In a partition, each message is assigned an incremental id, also called offset.

### Brokers

- Each broker is assigned an ID.
- One broker in a Cluster is selected as **Controller**
- **Controller** will be responsible for electing a **Leader** of the **Partition**



- Broker is in charge of the Topic’s Message Storage
- Brokers are stateless, so ZooKeeper is used to preserve the Kafka Clusters state ???

## Producers

- When a Producer adds a record to a Topic, it is published to the Topic’s Leader
- The record is appended to the Leader’s Commit Log, and the record offset is increased
- Hence, it is crucial that Producers must first obtain metadata about the Kafka Clusters from the Broker before sending any records
- The Zookeeper metadata identifies which Broker is the Partition Leader, and a Producer always writes to the Partition leader


### Reliability

- Producer can Choose whether to receive a confirmation of delivery by settings "**acks**" acknowledgements
- acks=0
- acks=1
- acks=all

## Consumers


## Zookeeper

- The Consumer Clients’ details and Information about the Kafka Clusters are stored in a ZooKeeper
- It acts like a Master Management Node where it is in charge of managing and maintaining the Brokers, Topics, and Partitions of the Kafka Clusters.
- The Zookeeper keeps track of the Brokers of the Kafka Clusters. It determines which Brokers have crashed and which Brokers have just been added to the Kafka Clusters, as well as their lifetime.
- Zookeeper also keeps track of which Broker is the subject Partition’s Leader and gives that information to the Producer or Consumer so they may read and write messages.



#######
- Messages and Schemas
