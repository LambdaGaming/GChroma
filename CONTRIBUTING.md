# Contributing to this repository
Please read below before creating issues or pull requests.

## Issues
- Issues can be in any format you'd like as long as it's readable and in English.
- Avoid making duplicate issues. Check to make sure the issue you want to report hasn't been reported already.
- Verify that this module is responsible for your issue before reporting.

## Pull Requests
- Try to keep your pull requests small and directed towards a single change. If you want to change or add multiple unrelated things, make separate pull requests for each of them.
- Complete rewrites of large parts and extremely small changes probably won't be accepted unless you can provide proof that the change greatly improves performance and/or functionality.
	### Styling
	- Styling won't be strictly enforced unless it looks unreadable compared to the rest of the code. If you choose not to follow one or two of the styling rules shown below you'll still be fine.
	- See this example for how your code should be styled:
		``` cpp
			// Placing comments in your code is recommended but not required
			// Use size 4 tabs instead of spaces. I know this is unconventional but I find it to be neater.
			#include <iostream>
			#include <string>
			using namespace std; // Put includes and usings at the very top of the file

			bool Equals( string text1, string text2 ) // Put spaces in between the parenthesis and the arguments as well as after commas
			{
				string blacklist[3] = { // Keep the bracket here for arrays, lists, dictionaries, etc
					"word",
					"example",
					"blacklist" // Make a new line for each value in an array unless they start to take up too much room, then put everything on a single line
				};

				// Leave whitespace in between blocks of code that span multiple lines
				int len = sizeof( blacklist ) / sizeof( blacklist[0] );
				for ( int i=0; i < len; i++ )
				{
					if ( blacklist[i] == text1 )
					{
						cout << "Word is blacklisted. Aborting.";
						return false;
					}
				}

				if ( text1 == text2 ) return true; // For small amounts of code inside control structures, put everything on a single line
				return false;
			}
		```
