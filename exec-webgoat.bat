@echo on

SET CX_AGENT="C:\CxSamples\IAST\cxiast-java-agent\cx-launcher.jar"

:: http://localhost:9090/WebGoat
java -jar target/WebGoat-6.0.1-war-exec.jar -httpPort 9090

::java -javaagent:%CX_AGENT% -Xverify:none -DcxScanTag=AWS -DcxAppTag=WebGoat6 -jar target/WebGoat-6.0.1-war-exec.jar -httpPort 9090