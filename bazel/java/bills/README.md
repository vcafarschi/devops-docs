docker run --name postgres -p 5432:5432 -e POSTGRES_PASSWORD=postgres -d postgres

# Dispatcher model CI
- This means that the first step the CI will do is to figure out what are incoming changes what we need to run and dispatch that work to workers that are running in parallel.
- Golang CLI build-collector figure out which project were affected by the incoming code changes, 

##  Parallel Builds in Maven
By default, Maven does not utilize the full power of your hardware. It builds all modules sequentially rather than in parallel.However, often your project setup does not require it to be sequential. Often you can command Maven to analyze your project including the dependency graph and build the project in parallel where possible. You can either specify the exact number of threads to use for building your project or use a portable version of the parameter and specify the number of thread in terms of CPUs available on the machine.
- mvn -Dmaven.artifact.threads=4 # will use 4 threads
- mvn -T 4 install # will use 4 threads
- mvn -T 1C install # will use 1 thread per available CPU core

## Running Maven Tests in Parallel
An aspect of build which probably has the biggest impact on your build speed are the tests. The most common practice is to disable the tests when you’re just interested in building your artifacts, but we cannot recommend such a non-conventional engineering practice. If you really do intend to skip your test goals during your Maven build, then the most common property that the majority plugins respect is: -DskipTests=true However, you can achieve faster build times without damaging your feedback loop that much.

The answer is running tests in parallel. The parallelization technique that we just discussed works on the module level. If you’re using an established plugin for running tests, let’s say, Surefire, you can also configure it for parallel execution within the module. Running tests in parallel might lead to unwanted side-effects, especially if they are tangled together and expect to be executed in a certain order. However, that’s another story altogether and you should totally try it to see if it works for you and by how much it speeds up your build. You can always figure out the failures later. 

This approach is excellent if you’ve got a large number of units in each module. Note that your tests need to be independent of one another !!!
- mvn test -Dparallel=all -DperCoreThreadCount=false -DthreadCount=16 

smth else examle 
mvn clean install [INFO] Total time: 01:05 h
mvn clean install -DskipTests [INFO] Total time: 18:35 min
mvn clean install -Dmaven.test.skip -DskipTests [INFO] Total time: 10:58 min
mvn -T 1C clean install -Dmaven.test.skip -DskipTests [INFO] Total time: 04:00 min
We can also skip the javadoc to be generated as Archmed commented by adding -Dmaven.javadoc.skip=true mvn -T 1C clean install -Dmaven.test.skip -DskipTests -Dmaven.javadoc.skip=true

## Build Necessary Modules Only
What command do you usually use to build your project? Is the answer: 

mvn clean install

While cleaning Maven is removing all the generated artifacts, all temporary files, except hopefully the configuration and the files checked in into the version control. It then generates fresh copies of those files again. It’s great for when you hit a weird caching issue or some obscure bug that you have but nobody else is able to reproduce.

However, it will take extra precious seconds and CPU cycles to do what is essentially a needless job of recreating already existing files. Instead what you most typically want to do is to build your project incrementally. Say you have a multi-module project with common core modules that rarely change and a web-interface that you’re currently working on. After changing the web-interface module try running a command like the following:

mvn install -pl $moduleName -am

First of all, we removed the implicit call to the clean phase. The project rarely requires cleaning, so we won’t want to do it all the time. Let’s take a look at the descriptions of the other options in the Maven command we just used:
    -pl - makes Maven build only specified modules and not the whole project.
    -am - makes Maven figure out what modules out target depends on and build them too.

The result of using these options together is the perfect combination of the flexibility and speed. We know what module we’re usually working on and if we have changed any dependencies, they will be renewed as well. At the same time a large chunk of your project build will be skipped either because it’s still fresh and doesn’t require rebuilding or because it’s not a part of the target module and won’t play a role.

##  Limit Internet Access
If you sometimes feel like Maven is downloading the internet, know that you’re not alone! This is one of the most common complaints of any build system, npm, gradle, sbt. You name it, you’ll be surprised at how many libraries and transitive dependencies known to humanity will need to be downloaded at an arbitrary, and usually most inopportune time. However, there’s a simple option you can enable that will make Maven work offline. You’ve probably guessed correctly, it’s the infamous offline key.

When the offline mode is enabled, Maven won't connect to any remote repositories when resolving dependencies. All the jar files in the local repository will still be available, so it won't break your usual workflow. So just append your mvn command with --offline or --o and Maven won’t be tempted to check for a new snapshot of your favorite dependency and won't make you wait for the network to respond.

------
Maven will check whether a SNAPSHOT dependency has a new "version" at every run. It means additional network roundtrips. We can prevent this check with the --offline option.
While you should avoid SNAPSHOT dependencies, it’s sometimes unavoidable, especially during development.
- mvn test -o


## Adjust memory configurations to optimum
- export MAVEN_OPTS=Xms1024m -Xmx2048m -XX:MaxPermSize=512m
- export MAVEN_OPTS="-XX:+TieredCompilation -XX:TieredStopAtLevel=1"; # It’s helpful with big project which contains lot of modules.

## Find Unused Dependencies
- mvn dependency:analyze
- mvn dependency:analyze-duplicate

- dependency:analyze -DignoreNonCompile

This will print a list of used undeclared and unused declared dependencies (while ignoring runtime/provided/test/system scopes for unused dependency analysis.)
Be careful while using this, some libraries used at runtime are considered unused

## Maven daemon
The Maven daemon is a recent addition to the Maven ecosystem. It draws its inspiration from the Gradle daemon:

    Gradle runs on the Java Virtual Machine (JVM) and uses several supporting libraries that require a non-trivial initialization time. As a result, it can sometimes seem a little slow to start. The solution to this problem is the Gradle Daemon: a long-lived background process that executes your builds much more quickly than would otherwise be the case. We accomplish this by avoiding the expensive bootstrapping process and leveraging caching by keeping data about your project in memory.

The Gradle team recognized early that a command-line tool was not the best usage of the JVM. To fix that, one keeps a JVM background process, the daemon, always up. It acts as a server while the CLI itself plays the role of the client.

As an additional benefit, such a long-running process loads classes only once (if they didn’t change between runs).

Once you have installed the software, you can run the daemon with the mvnd command instead of the standard mvn one. Here are the results with mvnd test:

## Final Thoughts

In this post we’ve looked at several common reasons why a Maven build might be slow and could be annoying you each and every time it’s run. In a nutshell, I think the default command for your build should be something along the lines of the following snippet:

mvn -T 1C install -pl $moduleName -am —offline
mvnd test -Dparallel=all -DperCoreThreadCount=false -DthreadCount=16 -o

It will deny Maven its annoying right to download the internet, build only the necessary modules and their dependencies, and won’t relentlessly clean the whole project again and again. You’re welcome. I bet you’ve been waiting for me to say this next bit, so wait no longer! If you have an opportunity, consider trying out another build tool. For example Gradle is said to be more intelligent with greater “optimizations” as built-in defaults.

## What is “Wall-Clock” time in Maven
By default (without -T 4), Maven builds all modules sequentially rather than in parallel. So you only have one process, which (in your example) takes 40s.

You start the build with 4 threads, so the total time of 40s gets divided by 4 threads, so each thread runs for 10s.

The total CPU time stays the same (40s), but the time that passed for YOU is only 10s + some overhead for parallelization. It's the time that you see when you look on your clock on the wall, therefore it's called Wall-Clock time.


## Integration tests

“Integration tests” has a bit of a broad definition these days, but for the sake of argument let’s say we mean stuff that runs at the integration-test phase in the Maven lifecycle, using Spring test to bring up an application context against a database and test the app via its entry points.

Naturally, being higher in the pyramid, these tests are going to take a lot longer to run than unit tests. As ever, parallelisation is the key to gaining time, but with the nature of this kind of testing we are more likely to run into problems; for example, any thread safety issues in your application will be brutally exposed.

We can configure the Surefire plugin right to extract the best performance like this:

<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-surefire-plugin</artifactId>
    ...
    <configuration>
        <parallel>classes</parallel>
        <threadCount>4</threadCount>
        <perCoreThreadCount>true</perCoreThreadCount>
        <trimStackTrace>false</trimStackTrace>
    </configuration>
</plugin>

Notice that in our parallel property, we have “classes” instead of “all” - this means Maven will use multiple threads to run tests, but will only parallelise down to class level, so every test method in a given class will run one at a time on the same thread. This is certainly not ideal, but parallelisation down to method level simply didn’t work with Spring test, as we found to our cost[3].

You can do things to work around this limitation; if you have an expensive setup operation (“calculate a quote”, “create a document” etc), the result of which is asserted on by multiple methods that don’t change any state themselves, you may be able to refactor to do that expensive operation fewer times whist maintaining the same coverage.


## Other options 
-B, --batch-mode
    Run in non-interactive (batch) mode 

Batch mode is essential if you need to run Maven in a non-interactive, continuous integration environment.



# Maven dependencies plugin:

## purge-local-repository
## When run on a project, remove the project dependencies from the local repository, and optionally re-resolve them. Outside of a project, remove the manually given dependencies.
### Force re-download project (SNAPSHOTS and RELEASES) dependencies from .m2
- mvn dependency:purge-local-repository

### Force re-download project SNAPSHOTS dependencies only from .m2
- mvn dependency:purge-local-repository -DsnapshotsOnly=true

### Delete project ALL (SNAPSHOT and RELEASE) dependencies from .m2 (without reinstalling them)
- mvn dependency:purge-local-repository -DreResolve=false

### Delete project ONLY SNAPSHOT dependencies from .m2 (without reinstalling them)
- mvn dependency:purge-local-repository -DreResolve=false -DsnapshotsOnly=true


## copy-dependencies
## Goal that copies the project dependencies from the repository to a defined location.

- mvn dependency:copy-dependencies -DoutputDirectory=${project.build.directory}/lib
- mvn dependency:copy-dependencies -DoutputDirectory=./some/path
overWriteReleases
overWriteSnapshots
### List dependencies of an project, in case dependencies are not installed, first install them and then list
- mvn dependency:list

### Locking snapshot dependencies
