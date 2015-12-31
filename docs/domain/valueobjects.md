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


<h2>POCO Value Objects</h2>

There may be situations where using a base class cannot be used to define a value object. This can occur when using a struct instead of a class or when combining Mendham with other frameworks. Mendham offers support for this scenario by using the `IValueObject<T>` interface.

The following example will work with either a struct or a class.

{% highlight csharp %}
public struct ValueObjectPoco : IValueObject<ValueObjectPoco>
{
    public string Value1 { get; private set; }
    public int Value2 { get; private set; }

    public ValueObjectPoco(string value1, int value2)
    {
        this.Value1 = value1;
        this.Value2 = value2;
    }

    public IEnumerable<object> EqualityComponents
    {
        get
        {
            yield return Value1;
            yield return Value2;
        }
    }

    public override bool Equals(object obj)
    {
        return this.IsEqualToValueObject(obj);
    }

    public override int GetHashCode()
    {
        return this.GetValueObjectHashCode();
    }

    public bool Equals(ValueObjectPoco other)
    {
        return this.IsEqualToValueObject(other);
    }

    public static bool operator ==(ValueObjectPoco a, ValueObjectPoco b)
    {
        return Equals(a, b);
    }

    public static bool operator !=(ValueObjectPoco a, ValueObjectPoco b)
    {
        return !(a == b);
    }
}
{% endhighlight %}

When using `IValueObject<T>`, `Equals(object)` and  `GetHashCode()` must be overriden and `Equals(T)` must be implemented. It is also recommended that the `==` and `!=` operators are implemented. 

To simplify this process, Mendham has extension methods that encapsulate the equality functionality. Equality is based on the fields defined in `EqualityComponents` which should include every public property in the value object.

<h2>Equality in Value Objects</h2>

Mendham handles equality when comparing one value object to another. For two value objects to be equal (or to have the same hash code), the two objects must be of the same type and every public property must be equal.