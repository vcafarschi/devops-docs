#

## Table of Contents
- [smth]()
- [smth]()
- [smth]()
- [smth]()

###
- To do OOP, we need to create a class that is used afterwards to create objects.
- Classes are data types defined by the user to create a new type of “variable” which will have its own set of variables and functions associated with it.
- Attributes are specific features an object will have, it can be 
  - a field (variables inside a class)
  - a method (functions inside a class) or a anything else.
- To create a class, we just need to use the class header.
  ```
  class Square:
      pass
  ```
- A perfectly valid class was created here! The object created from the class is called an instance.


### Class attributes
- Class attributes are attributes created inside a class
- Which means they are defined outside the constructor method
- They are shared by all instances of the class and can be called by the class or its instances with class.attribute
- If the attribute is a variable, we have 3 possible syntaxes that will define the access modifier of the variable:
  - attr_name: public, it is accessible from any part of the program even outside the class;
  - _attr_name: protected, accessible only from within the class and the sub-classes;
  - __attr_name: private, gives a strong suggestion not to touch it from outside the class. Any attempt will give an AttributeError.
- 
