using Clang

GAGE_INCLUDE = raw"C:\Program Files (x86)\Gage\CompuScope\include"

clang_includes = String[]
push!(clang_includes, GAGE_INCLUDE)
push!(clang_includes, raw"C:\Program Files\LLVM\include\clang-c",raw"C:\Program Files\LLVM\include\llvm-c" )
clang_extraargs = ["-v"]
clang_extraargs = ["-D", "__STDC_CONSTANT_MACROS","-D", "__STDC_LIMIT_MACROS"]
function wrap_header(top_hdr, cursor_hdr)
    return true#startswith(dirname(cursor_hdr), GAGE_INCLUDE)
end

function lib_file(hdr)
     if startswith(hdr, "CsAppSupport")
         return :CsSsm
     else
         return :CsSsm
     end
 end

output_file(hdr) = "Gage.jl"

const wc = wrap_c.init(;
headers = [joinpath(GAGE_INCLUDE,"CsAppSupport.h")],
output_file= "gage_headers.jl",
common_file = "cs_common.jl",
clang_includes = clang_includes,
clang_args = clang_extraargs,
header_wrapped = wrap_header,
header_library = lib_file,
header_outputfile = output_file)
run(wc)

# @show Clang.wrap_c.debug_cursors
