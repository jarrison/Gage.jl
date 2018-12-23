
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
    pData = Ref{CSACQUISITIONCONFIG}()
    ccall((:CsGet, :CsSsm), Int32,
          (CSHANDLE, Int32, Int32, Ref{CSACQUISITIONCONFIG}),
          hSystem, nIndex, nConfig, pData)
end

function CsSet(hSystem::CSHANDLE, nIndex::Int32, pData)
    ccall((:CsSet, :CsSsm), Int32, (CSHANDLE, Int32, Ptr{Cvoid}), hSystem, nIndex, pData)
end

function CsGetSystemInfo(hSystem::CSHANDLE, pSystemInfo::PCSSYSTEMINFO)
    ccall((:CsGetSystemInfo, :CsSsm), Int32, (CSHANDLE, PCSSYSTEMINFO), hSystem, pSystemInfo)
end

function CsGetSystemCaps(hSystem::CSHANDLE, CapsId::UInt32, pBuffer, BufferSize)
    ccall((:CsGetSystemCaps, :CsSsm), Int32, (CSHANDLE, UInt32, Ptr{Cvoid}, Ptr{UInt32}), hSystem, CapsId, pBuffer, BufferSize)
end

function CsDo(hSystem::CSHANDLE, i16Operation::Int)
    ccall((:CsDo, :CsSsm), Int32, (CSHANDLE, Int16), hSystem, i16Operation)
end

function CsTransfer(hSystem::CSHANDLE, pInData::PIN_PARAMS_TRANSFERDATA, outData::POUT_PARAMS_TRANSFERDATA)
    ccall((:CsTransfer, :CsSsm), Int32, (CSHANDLE, PIN_PARAMS_TRANSFERDATA, POUT_PARAMS_TRANSFERDATA), hSystem, pInData, outData)
end

function CsTransferEx(hSystem::CSHANDLE, pInData::PIN_PARAMS_TRANSFERDATA_EX, outData::POUT_PARAMS_TRANSFERDATA_EX)
    ccall((:CsTransferEx, :CsSsm), Int32, (CSHANDLE, PIN_PARAMS_TRANSFERDATA_EX, POUT_PARAMS_TRANSFERDATA_EX), hSystem, pInData, outData)
end

function CsGetEventHandle(hSystem::CSHANDLE, u32EventType::UInt32, phEvent)
    ccall((:CsGetEventHandle, :CsSsm), Int32, (CSHANDLE, UInt32, Ptr{Cint}), hSystem, u32EventType, phEvent)
end

function CsGetStatus(hSystem::CSHANDLE)
    ccall((:CsGetStatus, :CsSsm), Int32, (CSHANDLE,), hSystem)
end

function CsGetErrorStringA(i32ErrorCode::Int32, lpBuffer::Cint, nBufferMax::Cint)
    ccall((:CsGetErrorStringA, :CsSsm), Int32, (Int32, Cint, Cint), i32ErrorCode, lpBuffer, nBufferMax)
end

function CsGetErrorStringW(i32ErrorCode::Int32, lpBuffer, nBufferMax::Cint)
    ccall((:CsGetErrorStringW, :CsSsm), Int32, (Int32, Ptr{Cint}, Cint), i32ErrorCode, lpBuffer, nBufferMax)
end

function CsTransferAS(hSystem::CSHANDLE, pInData::PIN_PARAMS_TRANSFERDATA, pOutParams::POUT_PARAMS_TRANSFERDATA, pToken)
    ccall((:CsTransferAS, :CsSsm), Int32, (CSHANDLE, PIN_PARAMS_TRANSFERDATA, POUT_PARAMS_TRANSFERDATA, Ptr{Int32}), hSystem, pInData, pOutParams, pToken)
end

function CsGetTransferASResult(hSystem::CSHANDLE, nChannelIndex::Int32, pi64Results)
    ccall((:CsGetTransferASResult, :CsSsm), Int32, (CSHANDLE, Int32, Ptr{int64}), hSystem, nChannelIndex, pi64Results)
end

function CsExpertCall(hSystem::CSHANDLE, pFunctionParams::Cint)
    ccall((:CsExpertCall, :CsSsm), Int32, (CSHANDLE, Cint), hSystem, pFunctionParams)
end

function CsConvertToSigHeader(pHeader::PCSDISKFILEHEADER, pSigStruct::PCSSIGSTRUCT, szComment, szName)
    ccall((:CsConvertToSigHeader, :CsSsm), Int32, (PCSDISKFILEHEADER, PCSSIGSTRUCT, Ptr{Cint}, Ptr{Cint}), pHeader, pSigStruct, szComment, szName)
end

function CsConvertFromSigHeader(pHeader::PCSDISKFILEHEADER, pSigStruct::PCSSIGSTRUCT, szComment, szName)
    ccall((:CsConvertFromSigHeader, :CsSsm), Int32, (PCSDISKFILEHEADER, PCSSIGSTRUCT, Ptr{Cint}, Ptr{Cint}), pHeader, pSigStruct, szComment, szName)
end

function CsRetrieveChannelFromRawBuffer(pMulrecRawDataBuffer::Cint, i64RawDataBufferSize::int64, u32SegmentId::UInt32, ChannelIndex::uInt16, i64Start::int64, i64Length::int64, pNormalizedDataBuffer::Cint, i64TrigTimeStamp, i64ActualStart, i64ActualLength)
    ccall((:CsRetrieveChannelFromRawBuffer, :CsSsm), Int32, (Cint, int64, UInt32, uInt16, int64, int64, Cint, Ptr{int64}, Ptr{int64}, Ptr{int64}), pMulrecRawDataBuffer, i64RawDataBufferSize, u32SegmentId, ChannelIndex, i64Start, i64Length, pNormalizedDataBuffer, i64TrigTimeStamp, i64ActualStart, i64ActualLength)
end

function SetAcquisitionParameters(hSystem::CSHANDLE, pCsAcquisitionCfg)
    ccall((:SetAcquisitionParameters, :CsSsm), Int32, (CSHANDLE, Ptr{CSACQUISITIONCONFIG}), hSystem, pCsAcquisitionCfg)
end

function SetChannelParameters(hSystem::CSHANDLE, pCsChannelCfg)
    ccall((:SetChannelParameters, :CsSsm), Int32, (CSHANDLE, Ptr{CSCHANNELCONFIG}), hSystem, pCsChannelCfg)
end

function SetTriggerParameters(hSystem::CSHANDLE, pCsTriggerCfg)
    ccall((:SetTriggerParameters, :CsSsm), Int32, (CSHANDLE, Ptr{CSTRIGGERCONFIG}), hSystem, pCsTriggerCfg)
end

function CsAs_ConvertToVolts(i64Depth::int64, u32InputRange::UInt32, u32SampleSize::UInt32, i32SampleOffset::Int32, i32SampleResolution::Int32, i32DcOffset::Int32, pBuffer, pVBuffer)
    ccall((:CsAs_ConvertToVolts, :CsSsm), Int32, (int64, UInt32, UInt32, Int32, Int32, Int32, Ptr{Cvoid}, Ptr{Cfloat}), i64Depth, u32InputRange, u32SampleSize, i32SampleOffset, i32SampleResolution, i32DcOffset, pBuffer, pVBuffer)
end

function CsAs_CalculateChannelIndexIncrement(pAqcCfg, pSysInfo)
    ccall((:CsAs_CalculateChannelIndexIncrement, :CsSsm), UInt32, (Ptr{CSACQUISITIONCONFIG}, Ptr{CSSYSTEMINFO}), pAqcCfg, pSysInfo)
end

function CsAs_ConfigureSystem(hSystem::CSHANDLE, nChannelCount::Cint, nTriggerCount::Cint, szIniFile::Cint, pu32Mode)
    ccall((:CsAs_ConfigureSystem, :CsSsm), Int32, (CSHANDLE, Cint, Cint, Cint, Ptr{UInt32}), hSystem, nChannelCount, nTriggerCount, szIniFile, pu32Mode)
end

function CsAs_LoadConfiguration(hSystem::CSHANDLE, szIniFile::Cint, i32Type::Int32, pConfig)
    ccall((:CsAs_LoadConfiguration, :CsSsm), Int32, (CSHANDLE, Cint, Int32, Ptr{Cvoid}), hSystem, szIniFile, i32Type, pConfig)
end

function LoadAcquisitionConfiguration(hSystem::CSHANDLE, szIniFile::Cint, pConfig::PCSACQUISITIONCONFIG)
    ccall((:LoadAcquisitionConfiguration, :CsSsm), Int32, (CSHANDLE, Cint, PCSACQUISITIONCONFIG), hSystem, szIniFile, pConfig)
end

function LoadChannelConfiguration(hSystem::CSHANDLE, szIniFile::Cint, pConfig::PCSCHANNELCONFIG)
    ccall((:LoadChannelConfiguration, :CsSsm), Int32, (CSHANDLE, Cint, PCSCHANNELCONFIG), hSystem, szIniFile, pConfig)
end

function LoadTriggerConfiguration(hSystem::CSHANDLE, szIniFile::Cint, pConfig::PCSTRIGGERCONFIG)
    ccall((:LoadTriggerConfiguration, :CsSsm), Int32, (CSHANDLE, Cint, PCSTRIGGERCONFIG), hSystem, szIniFile, pConfig)
end

function LoadApplicationData(szIniFile::Cint, pConfig::PCSAPPLICATIONDATA)
    ccall((:LoadApplicationData, :CsSsm), Int32, (Cint, PCSAPPLICATIONDATA), szIniFile, pConfig)
end

function CsAs_SetApplicationDefaults(pAppData)
    ccall((:CsAs_SetApplicationDefaults, :CsSsm), Cvoid, (Ptr{CSAPPLICATIONDATA},), pAppData)
end

function CsAs_SaveFile(szFileName::Cint, pBuffer, sType::Cint, pHeader)
    ccall((:CsAs_SaveFile, :CsSsm), int64, (Cint, Ptr{Cvoid}, Cint, Ptr{FileHeaderStruct}), szFileName, pBuffer, sType, pHeader)
end
