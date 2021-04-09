module metal;

import color : randomInUnitSphere;
import hitrecord : HitRecord;
import material : Material, reflect;
import ray : Ray;
import vector3 : Vector3, dot, unitVector;


class Metal : Material
{
    this(in Vector3 albedo)
    {
        this.albedo = albedo;
    }

    override bool scatter(Ray rayIn, HitRecord hitRecord, ref Vector3 attenuation, ref Ray scattered)
    {
        Vector3 reflected = reflect(unitVector(rayIn.direction), hitRecord.normal);
        scattered = new Ray(hitRecord.p, reflected);
        attenuation = albedo;

        return dot(scattered.direction, hitRecord.normal) > 0;
    }

    Vector3 albedo;
}
