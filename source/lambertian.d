module lambertian;

import color : randomInUnitSphere;
import hitrecord : HitRecord;
import material : Material;
import ray : Ray;
import vector3 : Vector3;


class Lambertian : Material
{
    this(in Vector3 albedo)
    {
        this.albedo = albedo;
    }

    override bool scatter(Ray rayIn, HitRecord hitRecord, ref Vector3 attenuation, ref Ray scattered)
    {
        Vector3 target = hitRecord.p + hitRecord.normal + randomInUnitSphere();
        scattered = new Ray(hitRecord.p, target - hitRecord.p);
        attenuation = albedo;

        return true;
    }

    Vector3 albedo;
}
