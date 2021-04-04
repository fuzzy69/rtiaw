module hitrecord;

import ray : Ray;
import vector3 : Vector3;


struct HitRecord
{
    float t;
    Vector3 p;
    Vector3 normal;
}

abstract class Hitable
{
    bool hit(Ray ray, float tMin, float tMax, ref HitRecord hitRecord);
}

class HitableList : Hitable
{
    this() {}
    this(Hitable[] hitableList)
    {
        this.hitableList = hitableList;
    }

    override bool hit(Ray ray, float tMin, float tMax, ref HitRecord hitRecord)
    {
        HitRecord tmpRecord;
        bool hitAnything = false;
        double closestSoFar = tMax;
        foreach (hitable; hitableList)
        {
            if (hitable.hit(ray, tMin, closestSoFar, tmpRecord))
            {
                hitAnything = true;
                closestSoFar = tmpRecord.t;
                hitRecord = tmpRecord;
            }
        }

        return hitAnything;
    }

    Hitable[] hitableList;
}
