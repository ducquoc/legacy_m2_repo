Hosting some legacy dependencies which might not exist on Maven central anymore.

pom.xml
```
<repository>
  <id>legacy-releases-temp-repository</id>
  <url>https://github.com/ducquoc/legacy_m2_repo/raw/master/release/</url>
  <!--<url>https://raw.github.com/ducquoc/legacy_m2_repo/master/release/</url>-->
  <snapshots><enabled>false</enabled></snapshots>
</repository>
```

(or `settings.xml` mirrors, see: http://maven.apache.org/guides/mini/guide-multiple-repositories.html , https://maven.apache.org/guides/mini/guide-mirror-settings.html )

Originally this is for my internal projects or experiment purpose. I don't claim any responsibility for other people usage.


```
   find . -name "*.jar" -type f > file-listing.txt
   git add . && git commit -a -m "added jar javax mail 1.3.3" && git push 
```

or

```
   ./dq_add_commit_push.sh ojdbc14-10.2.0.3.0.jar
```


(Backlink: https://ducquoc.wordpress.com/2012/03/03/apache-maven-tips/ )


