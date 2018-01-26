Hosting some legacy dependencies which might not exist on Maven central anymore.

pom.xml
```
<repository>
    <id>legacy-releases-temp-repository</id>
    <url>https://github.com/ducquoc/legacy_m2_repo/tree/master/release</url>
</repository>
```

(or `setttings.xml` mirrors)

Originally this is for my internal projects or testing purpose. I don't claim any responsibility for other people usage.


