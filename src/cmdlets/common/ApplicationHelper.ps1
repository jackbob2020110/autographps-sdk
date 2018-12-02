# Copyright 2018, Adam Edwards
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

. (import-script DisplayTypeFormatter)

ScriptClass ApplicationHelper {
    static {
        $formatter = $null

        function __initialize {
            $this.formatter = new-so DisplayTypeFormatter GraphApplicationDisplayType 'AppId', 'DisplayName', 'CreatedDateTime', 'Id'
        }

        function ToDisplayableObject($object) {
            $this.formatter |=> ToDisplayableObject $object
        }
    }
}

$::.ApplicationHelper |=> __initialize
