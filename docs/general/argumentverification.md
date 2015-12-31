---
layout: page
title: Argument Verification
---
High quality code should verify the arguments of public methods and constructors. The typical way to do this is by validating the argument with an `if` statement and then throwing an `ArgumentException` when that condition is not met.

{% highlight csharp %}
public void SomeMethod(object objValue, int intVal, string strValue)
{
    if (objValue == null)
    {
        throw new ArgumentException("objValue cannot be null");
    }

    if (intVal <= 0)
    {
        throw new ArgumentException("intVal must be greater than zero");
    }

    if (string.IsNullOrWhiteSpace(strValue))
    {
        throw new ArgumentException("strValue cannot be null or whitespace");
    }

    // Do Something
}
{% endhighlight %}

Adding multiple conditional blocks this way can distract from the intension of the method. As an alternative, Mendham provides a set of extension methods that make argument verification easier to both implement and read.

{% highlight csharp %}
public void SomeMethod(object objValue, int intVal, string strValue)
{
    objValue.VerifyArgumentNotNull("objValue cannot be null");
    intVal.VerifyArgumentMeetsCriteria(num => num > 0, "intVal must be greater than 0");
    strValue.VerifyArgumentNotNullOrWhiteSpace("strValue cannot be null or whitespace");

    // Do Something
}
{% endhighlight %}

Mendham's argument verification extension methods test for a condition and throw the ArgumentException if that condition is not met. This exception contains the message that is defined in the final argument of the extension method. 

Argument verification extension methods can be chained together to allow for multiple checks of a single argument to each have their own individual message.

{% highlight csharp %}
public void SomeMethod(string strValue)
{
    strValue.VerifyArgumentNotNull("strValue cannot be null")
        .VerifyArgumentLength(2, 5, "strValue must have a length between 2 and 5")
        .VerifyArgumentMeetsCriteria(str => !str.Contains("$"), "strValue cannot contain a $");

    // Do Something
}
{% endhighlight %}

The fluent design of argument verification methods creates additional possibilities when writing code. For example, when classes initialize members with values from constructor parameters, the verification and the assignment of an argument can be combined in a single statement.

{% highlight csharp %}
public class MyClass
{
    private readonly int _intVal;
    private readonly string _strVal;

    public MyClass(int intVal, string strValue)
    {
        _intVal = intVal
            .VerifyArgumentMeetsCriteria(num => num > 0, "intVal must be greater than zero");
        _strVal = strValue
            .VerifyArgumentNotNullOrWhiteSpace("strValue cannot be null or whitespace");
    }
}
{% endhighlight %}