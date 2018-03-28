
#include <base/component.h>

struct Main {

    Main(Genode::Env &)
    {
        Genode::warning("EMPTY");
    }

};

void Component::construct(Genode::Env &env)
{
    static Main main(env);
}
