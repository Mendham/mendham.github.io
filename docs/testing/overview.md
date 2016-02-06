---
layout: page
title: Testing with Mendham
---
Mendham contains several libraries to help with testing. These libraries work with xUnit and should only be added to test projects and not the application code itself. The base library can be installed via NuGet:

{% highlight PowerShell %}
install-package Mendham.Testing
{% endhighlight %}

Beyond the base library, Mendham contains support for using object builders and mocking with Moq. Mendham also contains a library that is especially designed for testing domain logic including entities and domain events.