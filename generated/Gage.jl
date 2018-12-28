##########################################
########   GaGe Low-level API    #########
##########################################

function CsInitialize()
    ccall((:CsInitialize, :CsSsm), Int32, ())
end

function CsGetSystem( ; u32BoardType=UInt32(0), u32Channels=UInt32(0),
                        u32SampleBits=UInt32(0), i16Index=Int16(0))

    phSystem = Ref{CSHANDLE}(0)

    ccall((:CsGetSystem, :CsSsm), Int32,
          (Ref{CSHANDLE}, UInt32, UInt32, UInt32, Int16),
          phSystem, u32BoardType, u32Channels, u32SampleBits, i16Index)

    return phSystem[]
end

function CsFreeSystem(arg1::CSHANDLE)
    ccall((:CsFreeSystem, :CsSsm), Int32, (CSHANDLE,), arg1)
end

function CsGet(hSystem::CSHANDLE, nIndex::Integer, nConfig::Integer)

    nIndex == CS_ACQUISITION ? pData = CSACQUISITIONCONFIG() :
    nIndex == CS_CHANNEL     ? pData = CSCHANNELCONFIG() :
                               pData = CSTRIGGERCONFIG()

    ccall((:CsGet, :CsSsm), Int32,
          (CSHANDLE, Int32, Int32, Ref{CSACQUISITIONCONFIG}),
          hSystem, nIndex, nConfig, pData)

    return pData
end

function CsSet(hSystem::CSHANDLE, nIndex::Integer)
    nIndex == CS_ACQUISITION ? pData = CSACQUISITIONCONFIG() :
    nIndex == CS_CHANNEL     ? pData = CSCHANNELCONFIG() :
                               pData = CSTRIGGERCONFIG()

    ccall((:CsSet, :CsSsm), Int32,
          (CSHANDLE, Int32, Ref{CSACQUISITIONCONFIG}), hSystem, nIndex, pData)

    return pData
end

function CsGetSystemInfo(hSystem::CSHANDLE)
    SystemInfo = CSSYSTEMINFO()
    ccall((:CsGetSystemInfo, :CsSsm), Int32, (CSHANDLE, PCSSYSTEMINFO),
                                              hSystem, pSystemInfo)
end

function CsGetSystemCaps(hSystem::CSHANDLE, CapsId::UInt32, pBuffer, BufferSize)
    ccall((:CsGetSystemCaps, :CsSsm), Int32, (CSHANDLE, UInt32, Ptr{Cvoid}, Ptr{UInt32}), hSystem, CapsId, pBuffer, BufferSize)
end

function CsDo(hSystem::CSHANDLE, i16Operation::Integer)
    ccall((:CsDo, :CsSsm), Int32, (CSHANDLE, Int16), hSystem, i16Operation)
end

function CsTransfer(hSystem::CSHANDLE)
    pInData::PIN_PARAMS_TRANSFERDATA
    outData::POUT_PARAMS_TRANSFERDATA

    ccall((:CsTransfer, :CsSsm), Int32, (CSHANDLE, PIN_PARAMS_TRANSFERDATA,
                        POUT_PARAMS_TRANSFERDATA), hSystem, pInData, outData)

end

function CsTransferEx(hSystem::CSHANDLE)
    pInData::PIN_PARAMS_TRANSFERDATA_EX
    outData::POUT_PARAMS_TRANSFERDATA_EX

    ccall((:CsTransferEx, :CsSsm), Int32,
            (CSHANDLE, PIN_PARAMS_TRANSFERDATA_EX, POUT_PARAMS_TRANSFERDATA_EX),
            hSystem, pInData, outData)

end

function CsGetEventHandle(hSystem::CSHANDLE, u32EventType::UInt32, phEvent)
    ccall((:CsGetEventHandle, :CsSsm), Int32, (CSHANDLE, UInt32, Ptr{Cint}),
        hSystem, u32EventType, phEvent)
end

function CsGetStatus(hSystem::CSHANDLE)
    ccall((:CsGetStatus, :CsSsm), Int32, (CSHANDLE,), hSystem)
end

function CsGetErrorString(i32ErrorCode::Integer)
    errstring = Vector{UInt8}(undef,255)
    ccall((:CsGetErrorStringA, :CsSsm), Int32, (Int32, Ref{UInt8}, Cint),
                                        i32ErrorCode, errstring, 255)

    return errstring |> pointer |> unsafe_string
end

function CsTransferAS(hSystem::CSHANDLE)
    pInData::PIN_PARAMS_TRANSFERDATA
    pOutParams::POUT_PARAMS_TRANSFERDATA
    pToken
    ccall((:CsTransferAS, :CsSsm), Int32,
    (CSHANDLE, PIN_PARAMS_TRANSFERDATA, POUT_PARAMS_TRANSFERDATA, Ptr{Int32}),
    hSystem, pInData, pOutParams, pToken)

end

function CsGetTransferASResult(hSystem::CSHANDLE)
    nChannelIndex::Int32
    pi64Results
    ccall((:CsGetTransferASResult, :CsSsm),Int32, (CSHANDLE, Int32, Ptr{int64}),
                                            hSystem, nChannelIndex, pi64Results)

end

function CsExpertCall(hSystem::CSHANDLE, pFunctionParams::Cint)
    ccall((:CsExpertCall, :CsSsm), Int32, (CSHANDLE, Cint), hSystem, pFunctionParams)
end

function CsConvertToSigHeader(pHeader::PCSDISKFILEHEADER,
                              pSigStruct::PCSSIGSTRUCT, szComment, szName)
    ccall((:CsConvertToSigHeader, :CsSsm), Int32,
                        (PCSDISKFILEHEADER, PCSSIGSTRUCT, Ptr{Cint}, Ptr{Cint}),
                        pHeader, pSigStruct, szComment, szName)
end

function CsConvertFromSigHeader(pHeader::PCSDISKFILEHEADER,
                                pSigStruct::PCSSIGSTRUCT, szComment, szName)
    ccall((:CsConvertFromSigHeader, :CsSsm), Int32,
        (PCSDISKFILEHEADER, PCSSIGSTRUCT, Ptr{Cint}, Ptr{Cint}),
        pHeader, pSigStruct, szComment, szName)
end

function CsRetrieveChannelFromRawBuffer(pMulrecRawDataBuffer::Cint,
        i64RawDataBufferSize::int64, u32SegmentId::UInt32, ChannelIndex::uInt16,
        i64Start::int64, i64Length::int64, pNormalizedDataBuffer::Cint,
        i64TrigTimeStamp, i64ActualStart, i64ActualLength)
    ccall((:CsRetrieveChannelFromRawBuffer, :CsSsm), Int32,
(Cint, int64, UInt32, uInt16, int64, int64, Cint, Ptr{int64}, Ptr{int64}, Ptr{int64}),
    pMulrecRawDataBuffer, i64RawDataBufferSize, u32SegmentId, ChannelIndex,
    i64Start, i64Length, pNormalizedDataBuffer, i64TrigTimeStamp, i64ActualStart,
    i64ActualLength)
end

function SetAcquisitionParameters(hSystem::CSHANDLE, pCsAcquisitionCfg)
    ccall((:SetAcquisitionParameters, :CsSsm), Int32,
        (CSHANDLE, Ref{CSACQUISITIONCONFIG}), hSystem, pCsAcquisitionCfg)
end

function SetChannelParameters(hSystem::CSHANDLE, pCsChannelCfg)
    ccall((:SetChannelParameters, :CsSsm), Int32,
            (CSHANDLE, Ptr{CSCHANNELCONFIG}), hSystem, pCsChannelCfg)
end

function SetTriggerParameters(hSystem::CSHANDLE, pCsTriggerCfg)
    ccall((:SetTriggerParameters, :CsSsm), Int32,
                    (CSHANDLE, Ptr{CSTRIGGERCONFIG}), hSystem, pCsTriggerCfg)
end

##########################################
########     Custom Wrappers     #########
##########################################
function CsGetAcq(hSystem::CSHANDLE, nConfig::Integer)
    pData = CSACQUISITIONCONFIG()
    err = ccall((:CsGet, :CsSsm), Int32,
          (CSHANDLE, Int32, Int32, Ref{CSACQUISITIONCONFIG}),
          hSystem, CS_ACQUISITION, nConfig, pData)
    if err < 0
        return error(CsGetErrorString(err))
    else
        return pData
    end
end

function CsGetTrig(hSystem::CSHANDLE, nConfig::Integer)
    pData = CSTRIGGERCONFIG()
    err = ccall((:CsGet, :CsSsm), Int32,
          (CSHANDLE, Int32, Int32, Ref{CSTRIGGERCONFIG}),
          hSystem, CS_TRIGGER, nConfig, pData)
    if err < 0
        return error(CsGetErrorString(err))
    else
        return pData
    end
end

function CsGetChan(hSystem::CSHANDLE, nConfig::Integer)
    pData = CSCHANNELCONFIG()
    err = ccall((:CsGet, :CsSsm), Int32,
          (CSHANDLE, Int32, Int32, Ref{CSCHANNELCONFIG}),
          hSystem, CS_CHANNEL, nConfig, pData)
    if err < 0
        return error(CsGetErrorString(err))
    else
        return pData
    end
end
