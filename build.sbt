name := """report-demo"""

version := "1.0-SNAPSHOT"

lazy val root = (project in file(".")).enablePlugins(PlayScala)

scalaVersion := "2.11.7"

resolvers += "Atlassian Releases" at "https://maven.atlassian.com/public/"

resolvers += "scalaz-bintray" at "http://dl.bintray.com/scalaz/releases"

libraryDependencies ++= Seq(
  jdbc,
  cache,
  filters,
  ws,
  "net.codingwell" %% "scala-guice" % "4.0.0",
  "net.ceedubs" %% "ficus" % "1.1.2",
  "org.webjars" % "bootstrap" % "3.3.4",
  "org.webjars" % "bootstrap-switch" % "3.3.2",
  "org.webjars" % "angularjs" % "1.4.8",
  "org.webjars" % "angular-ui-bootstrap" % "0.14.3",
  "org.webjars" % "momentjs" % "2.11.1",
  "org.webjars.bower" % "angular-bootstrap-calendar" % "0.18.1",
  "org.webjars.bower" % "interact.js" % "1.2.6",
  "org.webjars.npm" % "angular-animate" % "1.4.8",
  "org.webjars" % "jquery" % "2.1.4",
  specs2 % Test
)


// Play provides two styles of routers, one expects its actions to be injected, the
// other, legacy style, accesses its actions statically.
routesGenerator := InjectedRoutesGenerator
