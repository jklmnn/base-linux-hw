
/*
 * Tests IO Port functionality by turning they keyboard LEDs on and off.
 * Uses the 8042 PS/2 controller
 */

#include <base/component.h>
#include <base/log.h>
#include <io_port_session/connection.h>
#include <timer_session/connection.h>

struct Main {

    Genode::Env &_env;

    enum {
        BASE = 0x60,
        STAT = 0x64,
        SCRL = 0x1,
        NUML = 0x2,
        CAPS = 0x4,
        LEDC = 0xed
    };

    Genode::Io_port_connection _iop {
        _env,
        BASE,
        STAT - BASE
    };

    Timer::Connection _timer { _env };

    Main(Genode::Env &env) : _env(env)
    {
        Genode::log("--- IO_Port keyboard LED test ---");
        while(1){
            Genode::log("on");
            while(_iop.inb(STAT));
            _iop.outb(BASE, LEDC);
            while(_iop.inb(STAT));
            _iop.outb(BASE, SCRL & NUML & CAPS);
            _timer.msleep(1000);
            Genode::log("off");
            while(_iop.inb(STAT));
            _iop.outb(BASE, LEDC);
            while(_iop.inb(STAT));
            _iop.outb(BASE, 0x0);
        }
    }

};

void Component::construct(Genode::Env &env)
{
    static Main main(env);
}
