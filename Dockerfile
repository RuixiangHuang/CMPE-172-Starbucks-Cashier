FROM openjdk:11
EXPOSE 8080
ADD ./target/spring-starbucks-casher-2.0.jar /srv/spring-starbucks-casher-2.0.jar
CMD java -jar /srv/spring-starbucks-casher-2.0.jar