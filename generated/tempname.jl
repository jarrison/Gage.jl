struct GageCard
    handle::CSHANDLE
    function GageCard()
        CsInitialize()
        hndl = CsGetSystem()
        hndl == 0 ? error("System not found or already in use.") : new(hndl)
    end
end

function free(sys::GageCard)
    CsFreeSystem(sys.handle)
end

function getconfig_acq(sys::GageCard)
    aquisitionconfig = CsGetAcq(sys.handle, CS_CURRENT_CONFIGURATION)
    return aquisitionconfig
end

function getconfig_trig(sys::GageCard)
    triggercfg = CsGetTrig(sys.handle, CS_CURRENT_CONFIGURATION)
    return triggercfg
end

function getconfig_chan(sys::GageCard)
    channelcfg = CsGetChan(sys.handle, CS_CURRENT_CONFIGURATION)
    return channelcfg
end

sys = GageCard()
acqconfig = getconfig_chan(sys)

free(sys)
