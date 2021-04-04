module rand;

import std.random : Random, uniform01, unpredictableSeed;

float getRandomBetween0and1()
{
    Random rnd = Random(unpredictableSeed);

    return uniform01(rnd);
}
