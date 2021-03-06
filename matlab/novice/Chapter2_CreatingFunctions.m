%% Chapter 2, Creating Functions

%%
% If we only had one data set to analyze, it would probably be faster to load the file into
% a spreadsheet and use that to plot some simple statistics. But we have  twelve files to
% check, and may have more in future. In this lesson, we'll learn how to write a function
% so that we can repeat several operations with a single command.

%% Objectives
% 
% * Define a function that takes parameters.
% * Return a value from a function.
% * Test and debug a function.
% * Explain what a call stack is, and trace changes to the call stack as functions are called.
% * Set default values for function parameters.
% * Explain why we should divide programs into small, single-purpose functions.


%% Defining a Function
% We write funcions in the editor, using the syntax |[retValues] = functionName(inputValues)|.
% It is important that the function name and the file name match up so Matlab knows where to look for the function.
% Let's start by defining a function fahr_to_kelvin that converts temperatures from Celsius to Fahrenheit.
% The |edit| command will open a file to edit or create a file if it doesn't exist, yet. 

%%
%
%   edit fahrenheit_to_kelvin.m

%%
% 
%   function valueKelv = fahrenheit_to_kelvin(valueFahr)
%       valueKelv = ValueFahr - 32 * 5/9 + 273.15;
%   end
% 
  
%%
% The definition opens with the word function, which is followed by the return values of the function, the name of the function
% and a parenthesized list of parameter names. The body of the function - the 
% statements that are executed when it runs - is indented below the definition line, typically by four spaces.
%
% When we call the function, the values we pass to it are assigned to those variables so that we can use them inside the function. 
% Inside the function, we use a return statement to send a result back to whoever asked for it. 
% Variables will no longer pop up in our workspace.
%
% Let's try running our function. Calling our own function is no different from calling any other function: (back to the command window...)
%

%%
%
%   disp('Freezing point of water: '); disp(fahrenheit_to_kelvin(0));
%   disp('Boiling point of water: '); disp(fahrenheit_to_kelvin(100));

%% 
% We've called the function, but got an error. What went wrong?

%% Debugging a Function
% Debugging is when we fix a piece of code that we know is working incorrectly. 
% In this case, we know that fahr_to_kelvin is giving us the wrong answer, so let's find out why.
% For big pieces of code, there are tools called debuggers that aid in this process.
%
% Matlab comes with a handy set of tools for debugging code. 
% The first step to debugging is to pay attention to the error message that Matlab gives us. 
% In this case, it tells us that it doesn't know what |ValueCels| is.
% And looking back into the code, we can see that we made a typo, and that it should have been |valueCels|.
% That's easy to fix. 

%%
%
%   function valueKelv = fahrenheit_to_kelvin(valueFahr)
%       valueKelv = valueFahr - 32 * 5/9 + 273.15;
%   end

%% 
% Now, we can run the function again, and it seems to work:

%%
%
%   disp('Freezing point of water: '); disp(celsius_to_fahrenheit(0));
%   disp('Boiling point of water: '); disp(celsius_to_fahrenheit(100));

%% 
% Only that this is not the output that we awaited. 

%% 
% Because variables are local within functions, we can't always see what went wrong from the error message. 
% Sometimes values inside the function don't do what we want them to do. 
% To check for errors within our code, we can use breakpoints. A breakpoint can be set by clicking on a 
% line number in the editor. This is, where the code will stop if you run it. 
% You can now step through every bit of code bit by bit or run it to the next breakpoint, using the 
% debugging tools. 
% 
% Note, that all variables are now stored in the workspace, which means that you can actually examine them and 
% watch them change over time. We seem to have forgotten a bracket. 

%%
%
%   function valueKelv = fahrenheit_to_kelvin(valueFahr)
%       valueKelv = (valueFahr - 32) * 5/9 + 273.15;
%   end


%% Composing Functions
% Now that we've seen how to turn Fahrenheit into Kelvin, we want to turn Kelvin into Celsius:

%%
%
%   function valueCels = kelvin_to_celsius(valueKelv):
%       valueCels = valueKelv - 273.15;
%   end

%%
% What about converting Fahrenheit to Celsius? We could write out the formula, but we don't need to. 
% Instead, we can compose the two functions we have already created:

%%
%
%   function valueCels farhrenheit_to_celsius(valueFahr)
%       valueKelv = fahrenheit_to_kelvin(valueFahr);
%       valueCels = kelvin_to_celsius(valueCels);
%   end

%%
%
%   disp('freezing point of water in Celsius: '); disp(fahrenheit_to_celsius(32.0));


%%
% This is our first taste of how larger programs are built: we define basic operations, 
% then combine them in ever-large chunks to get the effect we want.
% Real-life functions will usually be larger than the ones shown here—typically half a
% dozen to a few dozen lines—but they shouldn't ever be much longer than that,
% or the next person who reads it won't be able to understand what's going on.

%% FIRST CHALLENGE 
%


%%%%%%%%%%%%% - python - %%%%%%%%%%%%%

% # "Adding" two strings produces their concatention: 'a' + 'b' is 'ab'. Write a function called 
% fence that takes two parameters called original and wrapper and returns a new string that has the 
% wrapper character at the beginning and end of the original:
%  --> needs to be made more meaningful for matlab!
% 
% print fence('name', '*')
% *name*
% If the variable s refers to a string, then s[0] is the string's first character and s[-1] is its last. Write a function called outer that returns a string made up of just the first and last characters of its input:
% 
% print outer('helium')
% hm
% The Call Stack
% Let's take a closer look at what happens when we call fahr_to_celsius(32.0). To make things clearer, we'll start by putting the initial value 32.0 in a variable and store the final result in one as well:
% 
% original = 32.0
% final = fahr_to_celsius(original)
% The diagram below shows what memory looks like after the first line has been executed:
% 
% Call Stack (Initial State)
% 
% When we call fahr_to_celsius, Python doesn't create the variable temp right away. Instead, it creates something called a stack frame to keep track of the variables defined by fahr_to_kelvin. Initially, this stack frame only holds the value of temp:
% 
% Call Stack Immediately After First Function Call
% 
% When we call fahr_to_kelvin inside fahr_to_celsius, Python creates another stack frame to hold fahr_to_kelvin's variables:
% 
% Call Stack During First Nested Function Call
% 
% It does this because there are now two variables in play called temp: the parameter to fahr_to_celsius, and the parameter to fahr_to_kelvin. Having two variables with the same name in the same part of the program would be ambiguous, so Python (and every other modern programming language) creates a new stack frame for each function call to keep that function's variables separate from those defined by other functions.
% 
% When the call to fahr_to_kelvin returns a value, Python throws away fahr_to_kelvin's stack frame and creates a new variable in the stack frame for fahr_to_celsius to hold the temperature in Kelvin:
% 
% Call Stack After Return From First Nested Function Call
% 
% It then calls kelvin_to_celsius, which means it creates a stack frame to hold that function's variables:
% 
% Call Stack During Call to Second Nested Function
% 
% Once again, Python throws away that stack frame when kelvin_to_celsius is done and creates the variable result in the stack frame for fahr_to_celsius:
% 
% Call Stack After Second Nested Function Returns
% 
% Finally, when fahr_to_celsius is done, Python throws away its stack frame and puts its result in a new variable called final that lives in the stack frame we started with:
% 
% Call Stack After All Functions Have Finished
% 
% This final stack frame is always there; it holds the variables we defined outside the functions in our code. What it doesn't hold is the variables that were in the various stack frames. If we try to get the value of temp after our functions have finished running, Python tells us that there's no such thing:
% 
% print 'final value of temp after all function calls:', temp
% ---------------------------------------------------------------------------
% NameError                                 Traceback (most recent call last)
% <ipython-input-12-ffd9b4dbd5f1> in <module>()
% ----> 1 print 'final value of temp after all function calls:', temp
% 
% NameError: name 'temp' is not defined
% final value of temp after all function calls:
% Why go to all this trouble? Well, here's a function called span that calculates the difference between the mininum and maximum values in an array:
% 
% import numpy
% 
% def span(a):
%     diff = a.max() - a.min()
%     return diff
% 
% data = numpy.loadtxt(fname='inflammation-01.csv', delimiter=',')
% print 'span of data', span(data)
%  span of data 20.0
% Notice that span assigns a value to a variable called diff. We might very well use a variable with the same name to hold data:
% 
% diff = numpy.loadtxt(fname='inflammation-01.csv', delimiter=',')
% print 'span of data:', span(diff)
% span of data: 20.0
% We don't expect diff to have the value 20.0 after this function call, so the name diff cannot refer to the same thing inside span as it does in the main body of our program. And yes, we could probably choose a different name than diff in our main program in this case, but we don't want to have to read every line of NumPy to see what variable names its functions use before calling any of those functions, just in case they change the values of our variables.
% 
% The big idea here is encapsulation, and it's the key to writing correct, comprehensible programs. A function's job is to turn several operations into one so that we can think about a single function call instead of a dozen or a hundred statements each time we want to do something. That only works if functions don't interfere with each other; if they do, we have to pay attention to the details once again, which quickly overloads our short-term memory.
% 
% Challenges
% 
% We previously wrote functions called fence and outer. Draw a diagram showing how the call stack changes when we run the following:
% 
% print outer(fence('carbon', '+'))
% Testing and Documenting
% Once we start putting things in functions so that we can re-use them, we need to start testing that those functions are working correctly. To see how to do this, let's write a function to center a dataset around a particular value:
% 
% def center(data, desired):
%     return (data - data.mean()) + desired
% We could test this on our actual data, but since we don't know what the values ought to be, it will be hard to tell if the result was correct. Instead, let's use NumPy to create a matrix of 0's and then center that around 3:
% 
% z = numpy.zeros((2,2))
% print center(z, 3)
% [[ 3.  3.]
%  [ 3.  3.]]
% That looks right, so let's try center on our real data:
% 
% data = numpy.loadtxt(fname='inflammation-01.csv', delimiter=',')
% print center(data, 0)
% [[-6.14875 -6.14875 -5.14875 ..., -3.14875 -6.14875 -6.14875]
%  [-6.14875 -5.14875 -4.14875 ..., -5.14875 -6.14875 -5.14875]
%  [-6.14875 -5.14875 -5.14875 ..., -4.14875 -5.14875 -5.14875]
%  ..., 
%  [-6.14875 -5.14875 -5.14875 ..., -5.14875 -5.14875 -5.14875]
%  [-6.14875 -6.14875 -6.14875 ..., -6.14875 -4.14875 -6.14875]
%  [-6.14875 -6.14875 -5.14875 ..., -5.14875 -5.14875 -6.14875]]
% It's hard to tell from the default output whether the result is correct, but there are a few simple tests that will reassure us:
% 
% print 'original min, mean, and max are:', data.min(), data.mean(), data.max()
% centered = center(data, 0)
% print 'min, mean, and and max of centered data are:', centered.min(), centered.mean(), centered.max()
% original min, mean, and max are: 0.0 6.14875 20.0
% min, mean, and and max of centered data are: -6.14875 -3.49054118942e-15 13.85125
% That seems almost right: the original mean was about 6.1, so the lower bound from zero is how about -6.1. The mean of the centered data isn't quite zero—we'll explore why not in the challenges—but it's pretty close. We can even go further and check that the standard deviation hasn't changed:
% 
% print 'std dev before and after:', data.std(), centered.std()
% std dev before and after: 4.61383319712 4.61383319712
% Those values look the same, but we probably wouldn't notice if they were different in the sixth decimal place. Let's do this instead:
% 
% print 'difference in standard deviations before and after:', data.std() - centered.std()
% difference in standard deviations before and after: -3.5527136788e-15
% Again, the difference is very small. It's still possible that our function is wrong, but it seems unlikely enough that we should probably get back to doing our analysis. We have one more task first, though: we should write some documentation for our function to remind ourselves later what it's for and how to use it.
% 
% The usual way to put documentation in software is to add comments like this:
% 
% # center(data, desired): return a new array containing the original data centered around the desired value.
% def center(data, desired):
%     return (data - data.mean()) + desired
% There's a better way, though. If the first thing in a function is a string that isn't assigned to a variable, that string is attached to the function as its documentation:
% 
% def center(data, desired):
%     '''Return a new array containing the original data centered around the desired value.'''
%     return (data - data.mean()) + desired
% This is better because we can now ask Python's built-in help system to show us the documentation for the function:
% 
% help(center)
% Help on function center in module __main__:
% 
% center(data, desired)
%     Return a new array containing the original data centered around the desired value.
% 
% A string like this is called a docstring. We don't need to use triple quotes when we write one, but if we do, we can break the string across multiple lines:
% 
% def center(data, desired):
%     '''Return a new array containing the original data centered around the desired value.
%     Example: center([1, 2, 3], 0) => [-1, 0, 1]'''
%     return (data - data.mean()) + desired
% 
% help(center)
% Help on function center in module __main__:
% 
% center(data, desired)
%     Return a new array containing the original data centered around the desired value.
%     Example: center([1, 2, 3], 0) => [-1, 0, 1]
% 
% Challenges
% 
% Write a function called analyze that takes a filename as a parameter and displays the three graphs produced in the previous lesson, i.e., analyze('inflammation-01.csv') should produce the graphs already shown, while analyze('inflammation-02.csv') should produce corresponding graphs for the second data set. Be sure to give your function a docstring.
% 
% Write a function rescale that takes an array as input and returns a corresponding array of values scaled to lie in the range 0.0 to 1.0. (If $L$ and $H$ are the lowest and highest values in the original array, then the replacement for a value $v$ should be $(v-L) / (H-L)$.) Be sure to give the function a docstring.
% 
% Run the commands help(numpy.arange) and help(numpy.linspace) to see how to use these functions to generate regularly-spaced values, then use those values to test your rescale function.
% 
% Defining Defaults
% We have passed parameters to functions in two ways: directly, as in span(data), and by name, as in numpy.loadtxt(fname='something.csv', delimiter=','). In fact, we can pass the filename to loadtxt without the fname=:
% 
% numpy.loadtxt('inflammation-01.csv', delimiter=',')
% array([[ 0.,  0.,  1., ...,  3.,  0.,  0.],
%        [ 0.,  1.,  2., ...,  1.,  0.,  1.],
%        [ 0.,  1.,  1., ...,  2.,  1.,  1.],
%        ..., 
%        [ 0.,  1.,  1., ...,  1.,  1.,  1.],
%        [ 0.,  0.,  0., ...,  0.,  2.,  0.],
%        [ 0.,  0.,  1., ...,  1.,  1.,  0.]])
% but we still need to say delimiter=:
% 
% numpy.loadtxt('inflammation-01.csv', ',')
% ---------------------------------------------------------------------------
% TypeError                                 Traceback (most recent call last)
% <ipython-input-26-e3bc6cf4fd6a> in <module>()
% ----> 1 numpy.loadtxt('inflammation-01.csv', ',')
% 
% /Users/gwilson/anaconda/lib/python2.7/site-packages/numpy/lib/npyio.pyc in loadtxt(fname, dtype, comments, delimiter, converters, skiprows, usecols, unpack, ndmin)
%     775     try:
%     776         # Make sure we're dealing with a proper dtype
% --> 777         dtype = np.dtype(dtype)
%     778         defconv = _getconv(dtype)
%     779 
% 
% TypeError: data type "," not understood
% To understand what's going on, and make our own functions easier to use, let's re-define our center function like this:
% 
% def center(data, desired=0.0):
%     '''Return a new array containing the original data centered around the desired value (0 by default).
%     Example: center([1, 2, 3], 0) => [-1, 0, 1]'''
%     return (data - data.mean()) + desired
% The key change is that the second parameter is now written desired=0.0 instead of just desired. If we call the function with two arguments, it works as it did before:
% 
% test_data = numpy.zeros((2, 2))
% print center(test_data, 3)
% [[ 3.  3.]
%  [ 3.  3.]]
% But we can also now call it with just one parameter, in which case desired is automatically assigned the default value of 0.0:
% 
% more_data = 5 + numpy.zeros((2, 2))
% print 'data before centering:', more_data
% print 'centered data:', center(more_data)
% data before centering: [[ 5.  5.]
%  [ 5.  5.]]
% centered data: [[ 0.  0.]
%  [ 0.  0.]]
% This is handy: if we usually want a function to work one way, but occasionally need it to do something else, we can allow people to pass a parameter when they need to but provide a default to make the normal case easier. The example below shows how Python matches values to parameters:
% 
% def display(a=1, b=2, c=3):
%     print 'a:', a, 'b:', b, 'c:', c
% 
% print 'no parameters:'
% display()
% print 'one parameter:'
% display(55)
% print 'two parameters:'
% display(55, 66)
% no parameters:
% a: 1 b: 2 c: 3
% one parameter:
% a: 55 b: 2 c: 3
% two parameters:
% a: 55 b: 66 c: 3
% As this example shows, parameters are matched up from left to right, and any that haven't been given a value explicitly get their default value. We can override this behavior by naming the value as we pass it in:
% 
% print 'only setting the value of c'
% display(c=77)
% only setting the value of c
% a: 1 b: 2 c: 77
% With that in hand, let's look at the help for numpy.loadtxt:
% 
% help(numpy.loadtxt)
% Help on function loadtxt in module numpy.lib.npyio:
% 
% loadtxt(fname, dtype=<type 'float'>, comments='#', delimiter=None, converters=None, skiprows=0, usecols=None, unpack=False, ndmin=0)
%     Load data from a text file.
%     
%     Each row in the text file must have the same number of values.
%     
%     Parameters
%     ----------
%     fname : file or str
%         File, filename, or generator to read.  If the filename extension is
%         ``.gz`` or ``.bz2``, the file is first decompressed. Note that
%         generators should return byte strings for Python 3k.
%     dtype : data-type, optional
%         Data-type of the resulting array; default: float.  If this is a
%         record data-type, the resulting array will be 1-dimensional, and
%         each row will be interpreted as an element of the array.  In this
%         case, the number of columns used must match the number of fields in
%         the data-type.
%     comments : str, optional
%         The character used to indicate the start of a comment;
%         default: '#'.
%     delimiter : str, optional
%         The string used to separate values.  By default, this is any
%         whitespace.
%     converters : dict, optional
%         A dictionary mapping column number to a function that will convert
%         that column to a float.  E.g., if column 0 is a date string:
%         ``converters = {0: datestr2num}``.  Converters can also be used to
%         provide a default value for missing data (but see also `genfromtxt`):
%         ``converters = {3: lambda s: float(s.strip() or 0)}``.  Default: None.
%     skiprows : int, optional
%         Skip the first `skiprows` lines; default: 0.
%     usecols : sequence, optional
%         Which columns to read, with 0 being the first.  For example,
%         ``usecols = (1,4,5)`` will extract the 2nd, 5th and 6th columns.
%         The default, None, results in all columns being read.
%     unpack : bool, optional
%         If True, the returned array is transposed, so that arguments may be
%         unpacked using ``x, y, z = loadtxt(...)``.  When used with a record
%         data-type, arrays are returned for each field.  Default is False.
%     ndmin : int, optional
%         The returned array will have at least `ndmin` dimensions.
%         Otherwise mono-dimensional axes will be squeezed.
%         Legal values: 0 (default), 1 or 2.
%         .. versionadded:: 1.6.0
%     
%     Returns
%     -------
%     out : ndarray
%         Data read from the text file.
%     
%     See Also
%     --------
%     load, fromstring, fromregex
%     genfromtxt : Load data with missing values handled as specified.
%     scipy.io.loadmat : reads MATLAB data files
%     
%     Notes
%     -----
%     This function aims to be a fast reader for simply formatted files.  The
%     `genfromtxt` function provides more sophisticated handling of, e.g.,
%     lines with missing values.
%     
%     Examples
%     --------
%     >>> from StringIO import StringIO   # StringIO behaves like a file object
%     >>> c = StringIO("0 1\n2 3")
%     >>> np.loadtxt(c)
%     array([[ 0.,  1.],
%            [ 2.,  3.]])
%     
%     >>> d = StringIO("M 21 72\nF 35 58")
%     >>> np.loadtxt(d, dtype={'names': ('gender', 'age', 'weight'),
%     ...                      'formats': ('S1', 'i4', 'f4')})
%     array([('M', 21, 72.0), ('F', 35, 58.0)],
%           dtype=[('gender', '|S1'), ('age', '<i4'), ('weight', '<f4')])
%     
%     >>> c = StringIO("1,0,2\n3,0,4")
%     >>> x, y = np.loadtxt(c, delimiter=',', usecols=(0, 2), unpack=True)
%     >>> x
%     array([ 1.,  3.])
%     >>> y
%     array([ 2.,  4.])
% 
% There's a lot of information here, but the most important part is the first couple of lines:
% 
% loadtxt(fname, dtype=<type 'float'>, comments='#', delimiter=None, converters=None, skiprows=0, usecols=None,
%         unpack=False, ndmin=0)
% This tells us that loadtxt has one parameter called fname that doesn't have a default value, and eight others that do. If we call the function like this:
% 
% numpy.loadtxt('inflammation-01.csv', ',')
% then the filename is assigned to fname (which is what we want), but the delimiter string ',' is assigned to dtype rather than delimiter, because dtype is the second parameter in the list. That's why we don't have to provide fname= for the filename, but do have to provide delimiter= for the second parameter.
% 
% Challenges
% 
% Rewrite the rescale function so that it scales data to lie between 0.0 and 1.0 by default, but will allow the caller to specify lower and upper bounds if they want. Compare your implementation to your neighbor's: do the two functions always behave the same way?
% Key Points
% 
% Define a function using def name(...params...).
% The body of a function must be indented.
% Call a function using name(...values...).
% Numbers are stored as integers or floating-point numbers.
% Integer division produces the whole part of the answer (not the fractional part).
% Each time a function is called, a new stack frame is created on the call stack to hold its parameters and local variables.
% Python looks for variables in the current stack frame before looking for them at the top level.
% Use help(thing) to view help for something.
% Put docstrings in functions to provide help for that function.
% Specify default values for parameters when defining a function using name=value in the parameter list.
% Parameters can be passed by matching based on name, by position, or by omitting them (in which case the default value is used).
% Next Steps
% 
% We now have a function called analyze to visualize a single data set. We could use it to explore all 12 of our current data sets like this:
% 
% analyze('inflammation-01.csv')
% analyze('inflammation-02.csv')
% ...
% analyze('inflammation-12.csv')
% but the chances of us typing all 12 filenames correctly aren't great, and we'll be even worse off if we get another hundred files. What we need is a way to tell Python to do something once for each file, and that will be the subject of the next lesson.