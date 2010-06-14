/**
 *	
 */
module tools;

import std.stdio;
import std.string;
import std.traits;

/+
void mywrite(T...)(T ts)
{
	foreach(t; ts)
	{
		static if (is (t U : U*) && !is(U == void)) // is a pointer
		{
			mywrite(t);
		}
		else static if (is (t == struct))
		{
			write("{");
			foreach(i, t; t.tupleof)
			{
				static if (is (typeof(t) == struct))
					mywrite(t);
				else
				{
					write(t.tupleof[i].stringof[2..$], ":", t); // the slice cuts off the "t." that is always prepended
					static if (i < t.tupleof.length-1)
						write(", ");
				}
			}
			write("}");
		}
	}
}+/

/// custom format function to print arbitrary structs without toString() member
string myformat(T...)(T ts, bInsideStruct = false)
{
	string res;

	foreach (tidx, t; ts)
	{
		static if (is (typeof(t) U : U*) && !is(U == void)) // is a pointer
		{
			res ~= myformat(*t);
		}
/*		else static if (is (typeof(t) == interface))
		{
			pragma(msg, typeof(t));
		}
*/		else static if (is (typeof(t) == struct))
		{
			static if (is (typeof(t.toString())))
				res ~= t.toString();
			else
			{
				res ~= "{";
				foreach(i, el; t.tupleof)
				{
					res ~= t.tupleof[i].stringof[2..$] ~ ":" ~ myformat(el, true); // the slice cuts off the "t." that is always prepended
					static if (i < t.tupleof.length-1)
						res ~= ", ";
				}
				res ~= "}";
			}
		}
		else static if (isSomeString!(typeof(t)) && bInsideStruct) // enclose a string in ""
			res ~= `"` ~ t ~ `"`;
		else
			res ~= format(t);
		
		static if(tidx < ts.length-1)
			res ~= ", ";
	}
	
	return res;
}

version(unittest)
{
	struct S2
	{
		byte[4] aaaa = [0,1,2,3];
		string ddd = "asd";
	}

	struct S
	{
		int a;
		S2* p;
		
		S2 adad;
	}
	void main()
	{
	S2 sss = S2([5,4,5,4], "foo");
	S s = S(2, &sss);
	assert(myformat(s) == `{a:2, p:{aaaa:[5,4,5,4], ddd:"foo"}, adad:{aaaa:[0,1,2,3], ddd:"asd"}}`, "myformat is broken");
	assert(myformat(2) == "2");
	}
}