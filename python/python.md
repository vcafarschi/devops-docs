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

# Functions
## 5 Types of Arguments in Python Function Definition:
1. default arguments
2. keyword arguments
3. positional arguments
4. arbitrary positional arguments
5. arbitrary keyword arguments

### Python Function Definition:
 - The function definition starts with the keyword **def**.
 - It must be followed by the **function name** and the parenthesized list of **formal parameters**. 
 - The statements that form the body of the function start at the next line and must be indented.

![](images/python-function-descr.png)

- The terms **parameter** and **argument** can be used for the same thing
- However, there is a slight distinction between these two terms
- **Parameter** is the variable inside the parentheses in the function definition (In the above example are **arg1** and **arg2**)
- **Argument** is a variable, value or object passed to a function when it is called (In the above example are **a** and **b**)


### 1. default arguments
- Default arguments are values that are provided while defining functions.
- The assignment operator = is used to assign a default value to the argument.
- Default arguments become optional during the function calls.
- If we provide a value to the default arguments during function calls, it overrides the default value.
- The function can have any number of default arguments
- **Default arguments should follow non-default arguments.**

In the below example, the default value is given to argument **b** and **c**
```
def add(a, b=5, c=10):
    return (a + b + c)
```
This function can be called in 3 ways:
1. Giving only the mandatory argument
    - **a** is mandatory
    - **b** and **c** are optional as they have default values
    ```
    print(add(3))
    #Output:18
    ```
2. Giving one of the optional arguments.
    - 3 is assigned to **a**
    - 4 is assigned to **b**
    - and **c** has default value of 10
    ```
    print(add(3,4))
    #Output:17
    ```
3. Giving all the arguments.
    - In this case, we override all the default parameters
    ```
    print(add(2,3,4))
    #Output:9
    ```

Note: Default values are evaluated only once at the point of the function definition in the defining scope. So, it makes a difference when we pass mutable objects like a list or dictionary as default values.

- What happens if you define a function and you put default values first and then non-default
  ```
  def add(b=5, c=10, a):
      return (a + b + c)

  # Output
      def add(b=5, c=10, a):
                        ^
  SyntaxError: non-default argument follows default argument
  ```

##3 positional arguments
**positional arguments** means that the argument must be provided in a correct position in a function call.
```
# Here name and age are positional arguments.
def info(name, age):
    print(f"Hi, my name is {name}. I am  {age * 365.25} days old.")

# This does what is expected
info("Alice", 23.0)

# This doesn't
info(23.0, "Alice")
```

### keyword arguments

### variable-length arguments
- Variable-length arguments are also known as arbitrary arguments.
- If we don’t know the number of arguments needed for the function in advance, we can use arbitrary arguments

Two types of arbitrary arguments:
  - arbitrary positional arguments
  - arbitrary keyword arguments

### 4. arbitrary positional arguments, *args
- If you do not know how many arguments that will be passed into your function, add a * before the parameter name in the function definition.
- This way the function will receive a tuple of arguments, and can access the items accordingly


- Note: “We use the “wildcard” or “*” notation like this – *args OR **kwargs – as our function’s argument when we have doubts about the number of  arguments we should pass in a function.”


- The special syntax *args in function definitions in python is used to pass a variable number of arguments to a function. 
- It is used to pass a non-key worded, variable-length argument list.

Example:
Let’s create a function called mySum that accepts any number of arguments and sums them up:
```
def mySum(*args):
    s = 0
    for num in args:
        s += num
    return s
mySum(1,2)        # returns 3
mySum(1,2,2,3,4)  # returns 12
```
- Notice how *args are looped just like a list of numbers. This is because *args is a list of number arguments



### arbitrary keyword arguments, **kwargs
- You can use **kwargs to pass any number of keyword arguments to a function
```
def read(**kwargs):
    for key, value in kwargs.items():
        print("{}: {}".format(key, value))
read(shoes="Adidas", shirt="H&M")
read(socks="Nike")

```

- Notice how **kwargs is looped through just like a dictionary. This is because **kwargs actually is a dictionary

below is an implementation of the combination of *args and **kwargs
```

```

*args and *kwargs Conclusion
- Now that you understand *args and **kwargs, it is a good time to point out that there is nothing special about the words args and kwargs. The naming is actually up to you: *args could just as well be named *numbers. **kwargs could just as well be named **items.
