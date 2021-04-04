module vector3;

import std.algorithm : canFind;
import std.format : format;
import std.math : sqrt;
import std.stdio : writeln, writefln;


struct Vector3
{
    // this () {}
    this (float e0, float e1, float e2)
    {
        e[0] = e0;
        e[1] = e1;
        e[2] = e2;
    }

    float x () { return e[0]; }
    float y () { return e[1]; }
    float z () { return e[2]; }
    float r () { return e[0]; }
    float g () { return e[1]; }
    float b () { return e[2]; }

    float squaredLength ()
    {
        return e[0] * e[0] + e[1] * e[1] + e[2] * e[2];
    }

    float length ()
    {
        return sqrt(squaredLength());
    }

    void makeUnitVector ();

    auto opOpAssign(string op)(Vector3 rhs)
    {
        static if (["+", "-", "*", "/"].canFind(op))
        {
            static foreach (i; [0, 1, 2])
            {
                mixin("e[", i, "] ", op, "= rhs.e[", i, "];");
            }
        }

        return this;
    }

    auto opOpAssign(string op)(float t)
    {
        static if (["*", "/"].canFind(op))
        {
            static foreach (i; [0, 1, 2])
            {
                mixin("e[", i, "] ", op, "= t;");
            }
        }

        return this;
    }

    auto opBinary(string op)(Vector3 rhs)
    {
        static if (["+", "-", "*", "/"].canFind(op))
        {
            mixin("return Vector3(e[0] ", op, " rhs.e[0], e[1] ", op, " rhs.e[1], e[2] ", op, " rhs.e[2]);");
        }
    }

    auto opBinary(string op)(float t)
    {
        static if (["*", "/"].canFind(op))
        {
            mixin("return Vector3(e[0] ", op, " t, e[1] ", op, " t, e[2] ", op, " t);");
        }
    }

    string toString()
    {
        return format("Vector3(%f, %f, %f)", e[0], e[1], e[2]);
    }

    float[3] e;
}

Vector3 unitVector(Vector3 vector3)
{
    return vector3 / vector3.length;
}

float dot(Vector3 v1, Vector3 v2)
{
    return v1.x * v2.x + v1.y * v2.y + v1.z * v2.z;
}
