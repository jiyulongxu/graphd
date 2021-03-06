# Copyright 2015 Google Inc. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#!/bin/bash

B=`basename $0 .sh`
cd `dirname $0`
source ./rungraphd

rm -rf $D $B.pid

rungraphd -d${D} -p${B}.pid -bty << 'EOF'
write ("object" (-> "attribute-content" name="one" ("literal" value="my name")))
write ("object" (-> "attribute-content" name="two" ("literal" value="my name")))
read (any "attribute-content" pagesize=1
	result=(cursor(guid name value)))
read (any "attribute-content" pagesize=1 cursor="gmap:15-19:type->10/1/"
	result=(cursor(guid name value)))
read (any "attribute-content" pagesize=1 cursor="null:"
	result=(cursor(guid name value)))
EOF
rm -rf $D $B.pid
