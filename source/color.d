module color;

import hitrecord : HitableList, HitRecord;
import rand : getRandomBetween0and1;
import ray : Ray;
import sphere : hitSphere;
import vector3 : Vector3, unitVector, dot;


struct Color
{
    // this() {}
    this(int r, int g, int b, int a)
    {
        this.r = r;
        this.g = g;
        this.b = b;
        this.a = a;
    }


    int r;
    int g;
    int b;
    int a;
}

Vector3 randomInUnitSphere()
{
    Vector3 p;
    do
    {
        p = Vector3(getRandomBetween0and1, getRandomBetween0and1, getRandomBetween0and1) * 2.0 - Vector3(1, 1, 1);
    } while (dot(p, p) >= 1.0);

    return p;
}

Vector3 getColor(Ray ray, HitableList world)
{
    HitRecord hitRecord;
    if (world.hit(ray, 0.0, float.max, hitRecord))
    {
        Vector3 target = hitRecord.p + hitRecord.normal + randomInUnitSphere;
        return getColor(new Ray(hitRecord.p, target - hitRecord.p), world) * 0.5;
    }
    else
    {
        Vector3 unitDirection = unitVector(ray.direction);
        immutable(float) t = 0.5 * (unitDirection.y + 1.0);
        return Vector3(1.0, 1.0, 1.0) * (1.0f - t) + Vector3(0.5, 0.7, 1.0) * t;
    }
}
