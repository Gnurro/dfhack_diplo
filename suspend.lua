-- Suspend jobs

-- It can either suspend all jobs, or just jobs that risk blocking others.

local argparse = require('argparse')
local suspendmanager = reqscript('suspendmanager')

local help, onlyblocking = false, false
argparse.processArgsGetopt({...}, {
    {'h', 'help', handler=function() help = true end},
    {'b', 'onlyblocking', handler=function() onlyblocking = true end},
})

if help then
    print(dfhack.script_help())
    return
end

suspendmanager.foreach_construction_job(function (job)
    if not onlyblocking or suspendmanager.isBlocking(job) then
        suspendmanager.suspend(job)
    end
end)
