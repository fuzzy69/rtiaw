import std.stdio : write, writeln, writefln, File, SEEK_SET, SEEK_CUR;
import std.string : fromStringz, toStringz;
import std.conv;
import std.math : PI, sin, cos, sqrt;
import std.file : read;
import std.random : Random, uniform01, unpredictableSeed;
import std.parallelism : parallel;
import std.range : iota;

import bindbc.sdl;
// import bindbc.sdl.image;
// import bindbc.opengl;

import camera : Camera;
import color : Color, getColor;
import hitrecord : Hitable, HitableList;
import rand : getRandomBetween0and1;
import ray : Ray;
import sphere : hitSphere, Sphere;
import vector3 : Vector3, unitVector, dot;


void main()
{
    immutable(string) title = "Ray tracing in a weekend";
    immutable(int) windowX = SDL_WINDOWPOS_CENTERED;
    immutable(int) windowY = SDL_WINDOWPOS_CENTERED;
    immutable(int) windowWidth = 400;
    immutable(int) windowHeight = 200;
    const SDLSupport ret = loadSDL();
    if(ret != sdlSupport)
    {
        writeln("Error loading SDL dll");
        return;
    }
    scope (exit) SDL_Quit();
    if (SDL_Init(SDL_INIT_VIDEO) != 0)
    { 
        writeln("error initializing SDL: %s\n", SDL_GetError()); 
        return;
    } 
    SDL_Window *window = SDL_CreateWindow(cast(char*)(title.toStringz), windowX, windowY, windowWidth, windowHeight, SDL_WINDOW_SHOWN);
    scope (exit)
    {
        if (window != null)
            SDL_DestroyWindow(window);
    }
    if (window == null)
    {
        writeln("SDL_CreateWindow Error: ", SDL_GetError());
        return;
    }
    SDL_Renderer* renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_ACCELERATED | SDL_RENDERER_PRESENTVSYNC);

    scope (exit) SDL_DestroyRenderer(renderer);
    SDL_SetRenderDrawColor(renderer, 0, 0, 0, 0);
    SDL_RenderClear(renderer);

    Vector3 lowerLeftCorner = Vector3(-2.0, -1.0, -1.0);
    Vector3 horizontal = Vector3(4.0, 0.0, 0.0);
    Vector3 vertical = Vector3(0.0, 2.0, 0.0);
    Vector3 origin = Vector3(0.0, 0.0, 0.0);
    
    Hitable[] hitableList;
    hitableList ~= new Sphere(Vector3(0, 0, -1), 0.5);
    hitableList ~= new Sphere(Vector3(0, -100.5, -1), 100);
    HitableList world = new HitableList(hitableList);

    immutable(int) ns = 10;
    Camera camera = new Camera();
    // for (int y = windowHeight - 1; y >= 0; --y)
    for (int y = 0; y < windowHeight; ++y)
    {
        for (int x = 0; x < windowWidth; ++x)
        {
            Vector3 color = Vector3(0, 0, 0);
            for (int s = 0; s < ns; ++s)
            {
                float u = cast(float)(x + getRandomBetween0and1) / windowWidth;
                float v = cast(float)(y + getRandomBetween0and1) / windowHeight;
                Ray ray = camera.getRay(u, v);
                Vector3 p = ray.pointAtParameter(2.0);
                color += getColor(ray, world);
            }
            color /= cast(float)(ns);
            color = Vector3(sqrt(color.r), sqrt(color.g), sqrt(color.b));
            ubyte ir = cast(ubyte)(255.99 * color.r);
            ubyte ig = cast(ubyte)(255.99 * color.g);
            ubyte ib = cast(ubyte)(255.99 * color.b);

            SDL_SetRenderDrawColor(renderer, ir, ig, ib, 255);
            SDL_RenderDrawPoint(renderer, x, windowHeight - y);
        }
        SDL_RenderPresent(renderer);
    }
    // SDL_RenderPresent(renderer);

    SDL_Event event;
    while (true)
    {
        if (SDL_PollEvent(&event))
        {
            if (event.type == SDL_QUIT || event.key.keysym.sym == SDLK_q)
                break;
        }
    }
}
