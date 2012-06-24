# metaclass(singleton_class) and method lookup
* D < C

>
>                     BaseObject ---[m]c--->  #<Class:BaseObject> 
>                          ^                   ^
>                          |                   |
>                     super class         super class
>                          |                   |
>                          |                   |
>                      Object ---[m]c--->  #<Class:Object> 
>                          ^                   ^
>                          |                   |
>                     super class         super class
>                          |                   |
>                          |                   |
>                          C ---[m]c--->  #<Class:C> 
>                          ^                   ^
>                          |                   |
>                     super class         super class
>                          |                   |
>                          |                   |
>                          D ---[m]c--->  #<Class:D> 
>                          ^
>                          |
>                     super class
>                          |
>                          |
>     obj ---[m]c--->  #<Class:#<D>>
>
