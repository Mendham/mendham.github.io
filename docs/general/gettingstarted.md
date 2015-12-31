---
layout: page
title: Getting Started
---
Mendham is comprised of multiple packages which gives consumers the flexibility to install only the components that are required.

Mendham's core functionality is defined in `Mendham` which can be installed using Nuget

{% highlight PowerShell %}
install-package Mendham
{% endhighlight %}

The real power of Mendham comes when integrating its various packages together, but all of its packages depend upon the base `Mendham` library. This library contains a variety of extensions and contracts that help improve code quality by handling things such as argument verification and equality.
