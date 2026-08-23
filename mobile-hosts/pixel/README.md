# AEGENTIX Pixel Host

Kotlin/Android implementation of the AEGENTIX application-layer mobile host.

Use the host from a native Android application. Configure the CORE endpoint at runtime and keep secrets out of source control.

WorkManager should be used for durable background synchronization. A foreground service is reserved for workloads that actually qualify under current Android rules and must declare the appropriate service type and permission.
