# Python


# Modules
There are actually three different ways to define a module in Python:

A module can be written in Python itself.
A module can be written in C and loaded dynamically at run-time, like the re (regular expression) module.
A built-in module is intrinsically contained in the interpreter, like the itertools module.
A module’s contents are accessed the same way in all three cases: with the import statement.

# Packages
Suppose you have developed a very large application that includes many modules. As the number of modules grows, it becomes difficult to keep track of them all if they are dumped into one location

- Packages allow for a hierarchical structuring of the module namespace using dot notation. In the same way that modules help avoid collisions between global variable names, packages help avoid collisions between module names.

package_1
├── module_1.py
├── module_1.py


The __init__.py files are required to make Python treat directories containing the file as packages.
In the simplest case, __init__.py can just be an empty file, but it can also execute initialization code for the package.
If a file named __init__.py is present in a package directory, it is invoked when the package or a module in the package is imported. This can be used for execution of package initialization code, such as initialization of package-level data.


package_1
├── module_1.py
├── module_1.py
├── __init__.py

For example, consider the following __init__.py file:
  print(f'Invoking __init__.py for {__name__}')
  A = ['quux', 'corge', 'grault']

>>> import pkg
Invoking __init__.py for pkg
>>> pkg.A
['quux', 'corge', 'grault']




# project.toml
Creating pyproject.toml

pyproject.toml tells build tools (like pip and build) what is required to build your project. This tutorial uses setuptools, so open pyproject.toml and enter the following content:

[build-system]
requires = ["setuptools>=42"]
build-backend = "setuptools.build_meta"

build-system.requires gives a list of packages that are needed to build your package. Listing something here will only make it available during the build, not after it is installed.

build-system.build-backend is the name of Python object that will be used to perform the build. If you were to use a different build system, such as flit or poetry, those would go here, and the configuration details would be completely different than the setuptools configuration described below.

See PEP 517 and PEP 518 for background and details.
Configuring metadata

There are two types of metadata: static and dynamic.
- Static metadata (setup.cfg): guaranteed to be the same every time. This is simpler, easier to read, and avoids many common errors, like encoding errors.
- Dynamic metadata (setup.py): possibly non-deterministic. Any items that are dynamic or determined at install-time, as well as extension modules or extensions to setuptools, need to go into setup.py.

Static metadata (setup.cfg) should be preferred. Dynamic metadata (setup.py) should be used only as an escape hatch when absolutely necessary. setup.py used to be required, but can be omitted with newer versions of setuptools and pip.

















# Python tests
Creating a test directory
tests/ is a placeholder for test files. Leave it empty for now.

There are 3 main test runners:
  - unittest
  - pylint
  - coverage

# Coverage



# setup.py
Let's start with some definitions:

Package - A folder/directory that contains __init__.py file.
Module - A valid python file with .py extension.
Distribution - How one package relates to other packages and modules.

__init__.py is required to import the directory as a package, and should be empty.
example.py is an example of a module within the package that could contain the logic (functions, classes, constants, etc.) of your package. Open that file and enter the following content:
def add_one(number):
    return number + 1


# setup.py and setup.cfg
- The project specification files for distutils and setuptools. See also pyproject.toml.

# Source Distribution (or “sdist”)
- A distribution format (usually generated using python setup.py sdist) that provides metadata and the essential source files needed for installing by a tool like pip, or for generating a Built Distribution.
