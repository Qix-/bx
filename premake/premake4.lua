--
-- Copyright 2010-2013 Branimir Karadzic. All rights reserved.
-- License: http://www.opensource.org/licenses/BSD-2-Clause
--

solution "bx"
	configurations {
		"Debug",
		"Release",
	}

	platforms {
		"x32",
		"x64",
	}

	language "C++"

BX_DIR = (path.getabsolute("..") .. "/")
local BX_BUILD_DIR = (BX_DIR .. ".build/")
local BX_THIRD_PARTY_DIR = (BX_DIR .. "3rdparty/")

defines {
	"BX_CONFIG_ENABLE_MSVC_LEVEL4_WARNINGS=1"
}

dofile (BX_DIR .. "premake/toolchain.lua")
toolchain(BX_BUILD_DIR, BX_THIRD_PARTY_DIR)

function copyLib()
end

dofile "bx.lua"
dofile "unittest++.lua"

project "bx.test"
	uuid "8a653da8-23d6-11e3-acb4-887628d43830"
	kind "ConsoleApp"

	debugdir (BX_DIR .."tests")

	includedirs {
		BX_DIR .. "include",
		BX_THIRD_PARTY_DIR .. "UnitTest++/src/",
	}

	links {
		"UnitTest++",
	}

	files {
		BX_DIR .. "test/**.cpp",
		BX_DIR .. "test/**.H",
	}