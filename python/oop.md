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


# Python Modules Explained
- Python files are called modules and they are identified by the .py file extension. 
- A module can define functions, classes, and variables.

- interpreter runs a module, the __name__ variable will be set as __main__ if the module that is being run is the main program.
- But if the code is importing the module from another module, then the __name__  variable will be set to that module’s name
- When the Python interpreter reads a file, the __name__ variable is set as __main__ if the module being run, or as the module's name if it is imported. Reading the file executes all top level code, but not functions and classes (since they will only get imported).


# Python OOP

## Python Constructors

Before
```
class Robot:
  def introduce_self(self):
    print(f"My name is {self.name}")

r1 = Robot()
r1.name = "Tom"
r1.color = "red"
r1.weight = 30
```
- This is error prone, as you have to manually and everytime to add values to object attributes. What if instead of r1.name you type r1.nameee. You will get the error.
- Istead use Constructors, which will initialize the obejects attributes
```
class Robot:
  def __init__(self, givenName, givenColor, givenWeight):
  self.name = givenName
  self.color = givenColor
  self.weight = givenWeight

  def introduce_self(self):
    print(f"My name is {self.name}")

r1 = Robot(Tom, red, 30)
```



## cls vs self
-  **cls** and **self**, neither of them are keywords in python.
- **cls** and **self** are just ideal naming conventions whose name can be changed and yet the functionality would be the same.



## Self
- By using the “self”  we can access the attributes and methods of the class in python
- It binds the attributes with the given arguments
- **Self is always pointing to Current Object.**
```
#it is clearly seen that self and obj is referring to the same object

class check:
    def __init__(self):
        print("Address of self = ",id(self))

obj = check()
print("Address of class object = ",id(obj))

# this code is Contributed by Samyak Jain
```

```
Output
Address of self =  140124194801032
Address of class object =  140124194801032
```

- **Self is the first argument to be passed in Constructor and Instance Method, If you don’t provide it, it will cause an error.**
```
# Self is always required as the first argument
class check:
    def __init__():
        print("This is Constructor")
 
object = check()
print("Worked fine")
 
 
# Following Error is produced if Self is not passed as an argument
Traceback (most recent call last):
  File "/home/c736b5fad311dd1eb3cd2e280260e7dd.py", line 6, in <module>
    object = check()
TypeError: __init__() takes 0 positional arguments but 1 was given
   
   
  # this code is Contributed by Samyak Jain
```

- **Self is a convention and not a Python keyword.**
  - self is parameter in Instance Method and user can use another parameter name in place of it. But it is advisable to use self because it increases the readability of code, and it is also a good programming practice.

- When we call a method of this object as myobject.method(arg1, arg2), this is automatically converted by Python into MyClass.method(myobject, arg1, arg2) – this is all the special self is about.
```
class Robot:
  def introduce_self(self):
    print(f"My name is {self.name}")

r1 = Robot()
r1.name = "Tom"
r1.introduce_self() # It will execute My name is r1.name
```

## __init__
- The __init__ method is similar to constructors in C++ and Java
- Constructors are used to initialize (assign values) the object’s state (this is where we initialize attributes)
- Like methods, a constructor also contains a collection of statements(i.e. instructions) that are executed at the time of Object creation
- It automatically runs as soon as an object of a class is instantiated

Syntax of constructor declaration : 
```
def __init__(self):
    # body of the constructor
```

Types of constructors :
- default constructor: 
- parameterized constructor:

Example of Default Constructor
```
class GeekforGeeks:

	# default constructor
	def __init__(self):
		self.geek = "GeekforGeeks"

	# a method for printing data members
	def print_Geek(self):
		print(self.geek)


# creating object of the class
obj = GeekforGeeks()

# calling the instance method using the object obj
obj.print_Geek()
```

Example of Parameterized Constructor
```
class Addition:
	first = 0
	second = 0
	answer = 0
	
	# parameterized constructor
	def __init__(self, f, s):
		self.first = f
		self.second = s
	
	def display(self):
		print("First number = " + str(self.first))
		print("Second number = " + str(self.second))
		print("Addition of two numbers = " + str(self.answer))

	def calculate(self):
		self.answer = self.first + self.second

# creating object of the class
# this will invoke parameterized constructor
obj = Addition(1000, 2000)

# perform Addition
obj.calculate()

# display result
obj.display()

```


## Instance variables (attributes)

