---
layout: page
title: Value Objects
---
Value objects are small, immutable objects where equality is not based on an identity. Using value objects can make the domain more flexible and easier to understand.

There are several ways to use Mendham to implement value objects. The preferred  way is to extend ValueObject\<T> where T is the type being extended.

{% highlight csharp %}
public class ValueObjectUsingGenericBase : ValueObject<ValueObjectUsingGenericBase> 
{
    public readonly string value1;
    public readonly string value2;
    
    public ValueObjectUsingGenericBase(string value1, int value2)
    {
        this.value1 = value1;
        this.value2 = value2;
    }

    public string Value1 
    {
    	get { return value1; }
    }

    public int Value2 
    {
    	get { return value2; }
    }
}
{% endhighlight %}

When using ValueObject\<T>, Mendham handles the work required to make an object behave like a value object:

- Overriding `Equals(object)` and  `GetHashCode()`
- Implementing `IEquatable<T>`
- Overloading `==` and `!=` operators