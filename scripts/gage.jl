module Gage
using Libdl
@show include("gagestructs.jl")
using Main.GageStructs: BoardInfo
##############################################
####         GageAPI Methods              ####
##############################################
# Julia translations of the Gage Driver API.
# Low-level operations. Require GaGe Drivers Installed and Visible to Julia.
function geterror(errorcode::Int32)
    errstring = Vector{UInt8}(undef,255)
    lib = dlopen("CsSsm")
    sym =  dlsym(lib,:CsGetErrorString)
    err = ccall(sym,Int32,(Int32,Ref{UInt8}, Int32), errorcode, errstring, 255)
    errstring[end] = 0
    if err < 0
        return err
    else
        return unsafe_string(pointer(errstring))
    end
end

function initialize()
    lib = dlopen("CsSsm")
    sym =  dlsym(lib,:CsInitialize)
    err = ccall(sym,Int32,())
    if err < 0
        throw(SystemError)
    end
    err
end

function getsystem(boardtype=UInt32(0), nchannels=UInt32(0),
     bitresolution=UInt32(0), systemindex=Int16(0))
    @show boardtype
    lib = dlopen("CsSsm")
    sym =  dlsym(lib,:CsGetSystem)
    result = Ref{UInt32}(0)
    @show result
    argtype = (result, UInt32, UInt32, UInt32, Int16)
    args = (result, boardtype, nchannels, bitresolution, systemindex)
    err = ccall(sym,Int32,
    (Ref{Cuint},UInt32, UInt32, UInt32, Int16),
        result,boardtype,nchannels,bitresolution,systemindex)
    if err < 1
        return geterror(err)
    else
        @show err
        return result
    end
end

function getsysteminfo(handle::UInt32)
    result = Ref{BoardInfo}()
    lib = dlopen("CsSsm")
    sym =  dlsym(lib,:CsGetSystemInfo)
    err = ccall(sym,Int32,(UInt32,Ref{BoardInfo}),handle,result)
    if err < 0
        return geterror(err)
    end
    err
end

function getstatus(hSys::UInt32)
    lib = dlopen("CsSsm")
    sym =  dlsym(lib,:CsGetStatus)
    err = ccall(sym,Int32,(UInt32,),hSys)
    if err < 0
        throw(SystemError)
    end
    err
end

function freesystem(hSys::UInt32)
    lib = dlopen("CsSsm")
    sym =  dlsym(lib,:CsFreeSystem)
    err = ccall(sym,Int32,(UInt32,), hSys)
    if err < 0
        return geterror(err)
    else
        return true
    end
end

function gagedo(hSys::UInt32, operation::Integer)
    lib = dlopen("CsSsm")
    sym =  dlsym(lib,:CsDo)
    err = ccall(sym,Int32,(UInt32,Int16), hSys, operation)
    if err < 0
        return geterror(err)
    else
        return true
    end
end

function transfer(hSys::UInt)
end

end
