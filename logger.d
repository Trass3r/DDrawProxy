/**
 *	
 */
module logger;

import tools;
import std.stdio;
import std.c.windows.windows;

/// small logging class
struct Logger
{
	static File f;
	
	/// open the file
	static void init(string filename)
	{
		try
		{
			f = File(filename, "w");
		}
		catch(Exception e)
		{
			MessageBoxA(null, ("Exception: " ~ e.toString() ~ "\0").ptr, "DDraw Proxy", 0);
		}
	}
	
	/// close the log file
	static void close()
	{
		f.close();
	}
	
	/// add a log entry
	static void addEntry(T...)(T ts)
	{
		//assert(f.isOpen(), "Logger class hasn't been properly initialized!");
		if (!f.isOpen())
			MessageBoxA(null, "Logger.addEntry: f is not open!", "DDraw Proxy", 0);
		else
		{
			f.write(myformat(ts), "\n");
			f.flush();
		}
	}
}