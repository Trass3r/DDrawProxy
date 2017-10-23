/**
 *	
 */
module tools;

import std.conv;
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
string myformat(bool bInsideStruct = false, T...)(T ts)
{
	string res;

	foreach (tidx, t; ts)
	{
		static if (is (typeof(t) U : U*)) // is a pointer
		{
			static if (!is (U == void)) // is not a void*
			{
				if (t !is null)
					res ~= myformat(*t);
			}
			else
				res ~= format("0x%X", t); // void*
		}
		else static if (is (typeof(t) == interface))
		{
			res ~= format("0x%X", cast(void*) t); // take the object's address
		}
		else static if (is (typeof(t) == struct))
		{
			static if (is (typeof(t.toString())))	// toString exists for that struct
				res ~= t.toString();				// so use it
			else
			{
				res ~= "{";
				foreach(i, el; t.tupleof)
				{
					res ~= t.tupleof[i].stringof[2..$] ~ ":" ~ myformat!true(el); // the slice cuts off the "t." that is always prepended
					static if (i < t.tupleof.length-1)
						res ~= ", ";
				}
				res ~= "}";
			}
		}
		else static if (isSomeString!(typeof(t)) && bInsideStruct) // enclose a string in "" inside structs
		{
//			if (bInsideStruct)
				res ~= `"` ~ t ~ `"`;
//			else
//				res ~= t;
		}
		else
			res ~= to!string(t);
		
		static if(tidx < ts.length-1 && (bInsideStruct || !isSomeString!(typeof(t)))) // don't add a , after a string
			res ~= ", ";
	}
	
	return res;
}

unittest
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

	S2 sss = S2([5,4,5,4], "foo");
	S s = S(2, &sss);
	assert(myformat(s) == `{a:2, p:{aaaa:[5, 4, 5, 4], ddd:"foo"}, adad:{aaaa:[0, 1, 2, 3], ddd:"asd"}}`, "myformat is broken");
	assert(myformat(2) == "2");
}