module camera;

import ray : Ray;
import vector3 : Vector3;


class Camera
{
    this()
    {
        lowerleftCorner = Vector3(-2.0, -1.0, -1.0);
        horizontal = Vector3(4.0, 0.0, 0.0);
        vertical = Vector3(0.0, 2.0, 0.0);
        origin = Vector3(0.0, 0.0, 0.0);
    }

    Ray getRay(float u, float v)
    {
        return new Ray(origin, lowerleftCorner + horizontal * u + vertical * v  -origin);
    }

    Vector3 origin;
    Vector3 lowerleftCorner;
    Vector3 horizontal;
    Vector3 vertical;
}