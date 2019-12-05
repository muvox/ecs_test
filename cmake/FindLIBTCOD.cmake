# Copyright (C) 2014 Barry Deeney
# Copyright (C) 2014 Benny Bobaganoosh
# Copyright (C) 2019 Joni Niemi
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#############################################
# Try to find LIBTCOD and set the following: #
#                                           #
# LIBTCOD_FOUND                              #
# LIBTCOD_INCLUDE_DIRS                       #
# LIBTCOD_LIBRARIES                          #
#############################################

SET(_PF86 "PROGRAMFILES(X86)")
SET( LIBTCOD_SEARCH_PATHS
	${LIBTCOD_ROOT_DIR}					# LIBTCOD!
	./lib/libtcod
	$ENV{PROGRAMFILES}/libtcod			# WINDOWS
	"$ENV{_PF86}/libtcod"	# WINDOWS
	~/Library/Frameworks				# MAC
	/Library/Frameworks					# MAC
	/usr/local							# LINUX/MAC/UNIX
	/usr/local/lib							# LINUX/MAC/UNIX
	/usr								# LINUX/MAC/UNIX
	/opt								# LINUX/MAC/UNIX
	/sw									# Fink
	/opt/local							# DarwinPorts
	/opt/csw							# Blastwave
)

FIND_PATH( LIBTCOD_INCLUDE_DIRS
	NAMES
		libtcod.h libtcod/libtcod.h
	PATHS
		${LIBTCOD_SEARCH_PATHS}
	PATH_SUFFIXES
		include
	DOC
		"The directory where libtcod.h resides"
)

FIND_LIBRARY( LIBTCOD_LIBRARIES
	NAMES
		libtcod LIBTCOD
	PATHS
		${LIBTCOD_SEARCH_PATHS}
	PATH_SUFFIXES
		lib
		lib64
		lib/x86
		lib/x64
	DOC
		"The libtcod library"
)

# Check if we found it!
IF ( LIBTCOD_INCLUDE_DIRS AND LIBTCOD_LIBRARIES )
	SET( LIBTCOD_FOUND TRUE )
	MESSAGE(STATUS "Looking for LIBTCOD - found")
ELSE ( LIBTCOD_INCLUDE_DIRS AND LIBTCOD_LIBRARIES )
	SET( LIBTCOD_FOUND FALSE )
	MESSAGE(STATUS "Looking for LIBTCOD - not found")
ENDIF ( LIBTCOD_INCLUDE_DIRS AND LIBTCOD_LIBRARIES )
