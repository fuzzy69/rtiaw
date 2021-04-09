module ray;

import vector3 : Vector3;


class Ray
{
    this() {}
    this(Vector3 a, Vector3 b)
    {
        A = a;
        B = b;
    }

    Vector3 origin() const { return A; }
    Vector3 direction() const { return B; }
    Vector3 pointAtParameter(float t) { return A  + B * t; }

    Vector3 A;
    Vector3 B;
}
