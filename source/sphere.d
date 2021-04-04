module sphere;

import std.math : sqrt;

import hitrecord : HitRecord, Hitable;
import ray : Ray;
import vector3 : Vector3, dot;


class Sphere : Hitable
{
    this() {}
    this(Vector3 center, float radius)
    {
        this.center = center;
        this.radius = radius;
    }

    override bool hit(Ray ray, float tMin, float tMax, ref HitRecord hitRecord)
    {
        Vector3 oc = ray.origin - center;
        immutable(float) a = dot(ray.direction, ray.direction);
        immutable(float) b = dot(oc, ray.direction);
        immutable(float) c = dot(oc, oc) - radius * radius;
        immutable(float) discriminant = b * b - a * c;
        if (discriminant > 0)
        {
            float tmp = (-b - sqrt(b * b - a * c)) / a;
            if (tmp < tMax && tmp > tMin)
            {
                hitRecord.t = tmp;
                hitRecord.p = ray.pointAtParameter(hitRecord.t);
                hitRecord.normal = (hitRecord.p - center) / radius;
                return true;
            }
            tmp = (-b + sqrt(b * b - a * c)) / a;
            if (tmp < tMax && tmp > tMin)
            {
                hitRecord.t = tmp;
                hitRecord.p = ray.pointAtParameter(hitRecord.t);
                hitRecord.normal = (hitRecord.p - center) / radius;
                return true;
            }
        }

        return false;
    }

    Vector3 center;
    float radius;
}

float hitSphere(Vector3 center, float radius, Ray ray)
{
    Vector3 oc = ray.origin -  center;
    float a = dot(ray.direction, ray.direction);
    float b = 2.0 * dot(oc, ray.direction);
    float c = dot(oc, oc) - radius * radius;
    float discriminant = b * b - 4 * a *c;

    if (discriminant < 0)
        return -1.0;
    else
        return (-b - sqrt(discriminant)) / (2.0 * a);
}
