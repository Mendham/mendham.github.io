---
layout: page
title: Argument Verification
---
High quality code should verify the arguments of public methods and constructors. The typical way to do this is by validating the argument with an `if` statement and then throwing an ArgumentException when that condition is not met.

{% highlight csharp %}
public void Foo(object objValue, int intVal, string strValue)
{
    if (objValue == null)
    {
        throw new ArgumentNullException(nameof(objValue));
    }

    if (intVal num % 2 == 0)
    {
        throw new ArgumentException("intVal must be greater even", nameof(intVal));
    }

    if (string.IsNullOrWhiteSpace(strValue))
    {
        throw new ArgumentException("strValue cannot be null or whitespace", nameof(strValue));
    }

    // Do Something
}
{% endhighlight %}

Adding multiple conditional blocks this way can distract from the intension of the method. As an alternative, Mendham provides a set of extension methods that make argument verification easier to both implement and read.

{% highlight csharp %}
public void Foo(object objValue, int intVal, string strValue)
{
    objValue.VerifyArgumentNotNull(nameof(objValue));
    intVal.VerifyArgumentMeetsCriteria(num => num % 2 == 0, nameof(intVal), "Value must be even");
    strValue.VerifyArgumentNotNullOrWhiteSpace(nameof(strValue));

    // Do Something
}
{% endhighlight %}

Mendham's argument verification extension methods test for a condition and throw the ArgumentException if that condition is not met. Most of the extension methods provide a clear message as to the reason for the exception but allow for an optional argument to add an additional mesasage. 

Argument verification extension methods can be chained together to allow for multiple checks of a single argument to each have their own individual message.

{% highlight csharp %}
public void Foo(string strValue)
{
    strValue.VerifyArgumentNotNull(nameof(strValue))
        .VerifyArgumentLength(nameof(strValue), 2, 5)
        .VerifyArgumentMeetsCriteria(str => !str.Contains("$"), nameof(strValue), "Value cannot contain a $");

    // Do Something
}
{% endhighlight %}

The fluent design of the argument verification methods create additional possibilities when writing code. As an example, when classes initialize members with values from constructor parameters, the verification and the assignment of those values can be combined in a single statement.

{% highlight csharp %}
public class Foo
{
    private readonly int _intVal;
    private readonly string _strVal;

    public Foo(int intVal, string strValue)
    {
        _intVal = intVal
            .VerifyArgumentMeetsCriteria(num => num % 2 == 0, nameof(intVal), "Value must be even");
        _strVal = strValue
            .VerifyArgumentNotNullOrWhiteSpace(nameof(strValue))
            .VerifyArgumentLength(nameof(strValue), 2, 5);
    }
}
{% endhighlight %}

Argument Verification Methods
-----------------------------

| Name | Description |
|:----|:-------|
| `VerifyArgumentNotNull<T>(T argument, string paramName)` | Throws an ArgumentException the argument is null. |
| `VerifyArgumentNotDefaultValue<T>(T argument, string paramName)` | Throws an ArgumentException when the argument is equal to the default of T. The default of T depends on the type, but for reference objects, this is effectively the same as a null check. |
| `VerifyArgumentNotNullOrEmpty<T>(IEnumerable<T> argument, string paramName)` | Throws an ArgumentException when the enumerable argument is null or empty |
| `VerifyArgumentNotNullOrEmpty(string argument, string paramName)` | Throws an ArgumentException when the string argument is null or empty |
| `VerifyArgumentNotNullOrWhiteSpace(string argument, string paramName)` | Throws an ArgumentException when the string argument is null or whitespace |
| `VerifyArgumentLength(string argument, int? minimum, int? maximum, string paramName)` | Throws an ArgumentException when the length of the argument string is not in the range specified. When a minimum or maximum are left null, they are not considered.  |
| `VerifyArgumentLength(string argument, int? minimum, int? maximum, bool trimStringFirst, string paramName)` | Throws an ArgumentException when the length of the argument string is not in the range specified. When a minimum or maximum are left null, they are not considered. When trimStringFirst is set to true, whitespace on end of string is not considered for the range check. |
| `VerifyArgumentRange(int argument, int? minimum, int? maximum, string paramName)` | Throws an ArgumentException when integer argument is not with the range specified. When a minimum or maximum are left null, they are not considered. |
|  `VerifyArgumentMeetsCriteria<T>(T argument, Func<T, bool> acceptanceCriteria, string paramName, string message)` | Throws an ArgumentException when the argument does not meet the acceptance criteria. This method should be used when the other methods do not meet the needs for checking the argument. Because this method is a catch all for argument checks not covered by the other extension methods, this method always requires a message. |
