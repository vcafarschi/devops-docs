# simple-java-maven-app
Deploy artifacts to artifactory using maven

1. Distribution Management in pom.xml
 - specifies where (and how) project will get to a remote repository when it is deployed.
 - the <repository> elements will be used for snapshot distribution if the <snapshotRepository> is not defined. 
 - in case <snapshotRepository> is not defined AND <repository>  <url> doesn't accept snapshots then you will get ERROR 409 Conflict

```
<distributionManagement>
    <repository>
      <id>releases</id>
      <name>Artifactory Releases</name>
      <url>http://repository/content/repositories/releases</url>
    </repository>
    
    <snapshotRepository>
      <id>snapshots</id>
      <name>Artifactory Snapshot</name>
      <url>http://repository/content/repositories/snapshots</url>
    </snapshotRepository>
</distributionManagement>
```
2. Repository - specifies in the POM/settings.xml the location and manner in which Maven may download remote artifacts for use by the current project
- Whenever a project has a dependency upon an artifact, Maven will first attempt to use a local copy of the specified artifact.
   If that artifact does not exist in the local repository, it will then attempt to download from a remote repository. 
   The repository elements within a POM specify those alternate repositories to search.

```
<repositories>
	<repository>
	  <name>Snapshots</name>
	  <id>snapshots-repo</id>
	  <url>https://artifactory/content/repositories/snapshots</url>
	  <layout>default</layout>
	  <releases>
		<enabled>false</enabled>
		<updatePolicy>always</updatePolicy>
		<checksumPolicy>warn</checksumPolicy>
	  </releases>
	  <snapshots>
		<enabled>true</enabled>
		<updatePolicy>never</updatePolicy>
		<checksumPolicy>warn</checksumPolicy>
	  </snapshots>
	</repository>
</repositories>
```

3. Server tag in settings.xml  

3.1 Create a master encryption key
```
$ mvn -emp mymasterpassword
{5pPAHoz3s0QH6NlxJEBHEQZoSQjEcyKV05Gq3ydrzdFzRvDS8HKtTDk6MRTdo0d6}
```

3.2 Create settings-security.xml under .m2 
```
$ vi ~/.m2/settings-security.xml
```

3.3. Add the master encryption key
```
<settingsSecurity>
  <master>{5pPAHoz3s0QH6NlxJEBHEQZoSQjEcyKV05Gq3ydrzdFzRvDS8HKtTDk6MRTdo0d6}</master>
</settingsSecurity>
```

3.3 Once the master password is configured properly, we can start encrypting rest of the confidential data in settings.xml
mvn -ep my_password
{PbYw8YaLb3cHA34/5EdHzoUsmmw/u/nWOwb9e+x6Hbs=}

3.4 Copy the value of the encrypted password and replace the corresponding value in the settings.xml file
<server>
 <id>artifactory</id>
 <username>my_username</username>
 <password>{PbYw8YaLb3cHA34/5EdHzoUsmmw/u/nWOwb9e+x6Hbs=}</password>
</server> 
