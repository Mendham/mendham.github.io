---
layout: page
title: About
displayOnMenu: true
---

### Why Mendham?
There are many challenges when trying to implement a strong domain model that is also easily testable. To support testing, key business logic often ends up in services and other places resulting which ultimately results in an anemic domain model. Doing it right can be hard and feel very tedious. Mendham libraries are designed to help streamline the process of writing testable software with a rich domain.

### Design
Libraries in Mendham are partitioned into multiple Nuget packages which allows consumers to only include the features they need. These packages are built targeting both .NET Framework 4.5.1 and DNX Core. Within Mendham, specific packages are intended to be used by either the application itself or by the test projects. Although Mendham can by one without the other, the real power of Mendham is really expressed when Mendham is used by both the application and the tests. 

### Domain
Mendham contains the building blocks for building an application's domain model. It defines base types for entities value objects that handle equality. In addition, Mendham also provides infrastructure for defining, raising and handling domain events. From there, Mendham's IoC support helps wire up domain dependencies with only a few lines of code.

### Testing
Mendham works with Xunit to help write clean test code that utilize test fixtures and object builders. It helps streamline the setup phase of tests making tests more maintainable and easier to understand. The process gets even easier when used in conjunction with Mendham's domain libraries. The testing libraries also support and are fully extensible to work with other mocking libraries as well.