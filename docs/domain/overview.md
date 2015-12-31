---
layout: page
title: Mendham.Domain
---

Mendham provides patterns, base implementations, and extension methods for building an application's domain model. To get started, use Nuget to add `Mendham.Domain` to any project that defines domain logic:

{% highlight PowerShell %}
install-package Mendham.Domain
{% endhighlight %}

Mendham defines domain building blocks including entities, [value objects](valueobjects.html) and domain events. These components can either built on top of Mendham's base classes or as POCO's that leverage extension methods to handle equality and other concerns. This helps streamline building applications following a Domain-Driven Design approach.