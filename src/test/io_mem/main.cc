/*
 * \brief  Linux: test IO_MEM session
 * \author Johannes Kliemann
 * \date   2018-01-19
 */

/*
 * Copyright (C) 2012-2017 Genode Labs GmbH
 *
 * This file is part of the Genode OS framework, which is distributed
 * under the terms of the GNU Affero General Public License version 3.
 */

#include <base/component.h>
#include <io_mem_session/connection.h>

using namespace Genode;

struct Main {
    
    Main(Env &env);

};

Main::Main(Env &env)
{
	Genode::log("--- test-io_mem started ---");

        Io_mem_connection _mem_con( env, 0, 10, true );
        Io_mem_session_client _mem(_mem_con.cap());
        Region_map &_map(env.rm());
        log("attaching");
        char *test = (char*)_map.attach(_mem.dataspace());
        log("attached");
        log((void*)test);
}


void Component::construct(Env &env) { static Main main(env); }
