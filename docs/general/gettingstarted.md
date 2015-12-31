---
layout: page
title: Getting Started
---
Mendham is comprised of multiple packages which gives consumers the flexibility to install only the modules that are required.

Mendham's core functionality is defined in `Mendham` which can be installed using Nuget

{% highlight PowerShell %}
install-package Mendham
{% endhighlight %}

The real power of Mendham comes when integrating the various packages together, but all of its packages depend upon the base `Mendham` library. This base library contains a variety of extensions and contracts that help improve code quality by handling things such as [argument verification](argumentverification.html) and equality.
