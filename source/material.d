module material;

import hitrecord : HitRecord;
import ray : Ray;
import vector3 : Vector3, dot;


abstract class Material
{
    bool scatter(Ray rayIn, HitRecord hitRecord, ref Vector3 attenuation, ref Ray scattered);
}

Vector3 reflect(Vector3 v, Vector3 n)
{
    return v - n * dot(v, n) * 2;
}
