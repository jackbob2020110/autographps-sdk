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

. (import-script common/ApplicationHelper)

function Get-GraphApplication {
    [cmdletbinding(defaultparametersetname='appid', positionalbinding=$false)]
    param (
        [parameter(parametersetname='appid', position=0)]
        $AppId,

        [parameter(parametersetname='objectid', mandatory=$true)]
        $ObjectId,

        [parameter(parametersetname='odatafilter', mandatory=$true)]
        $ODataFilter,

        [parameter(parametersetname='name', mandatory=$true)]
        $Name,

        [switch] $RawContent,

        [String] $Version = $null,

        [parameter(parametersetname='NewConnection')]
        [parameter(parametersetname='NewConnectionAppId')]
        [parameter(parametersetname='NewConnectionObjectId')]
        [parameter(parametersetname='NewConnectionODataFilter')]
        [parameter(parametersetname='NewConnectionName')]
        [String[]] $Permissions = $null,

        [parameter(parametersetname='NewConnection')]
        [parameter(parametersetname='NewConnectionAppId')]
        [parameter(parametersetname='NewConnectionObjectId')]
        [parameter(parametersetname='NewConnectionODataFilter')]
        [parameter(parametersetname='NewConnectionName')]
        [GraphCloud] $Cloud = [GraphCloud]::Public,

        [parameter(parametersetname='ExistingConnection')]
        [parameter(parametersetname='ExistingConnectionAppId')]
        [parameter(parametersetname='ExistingConnectionODataFilter')]
        [parameter(parametersetname='ExistingConnectionObjectId')]
        [parameter(parametersetname='ExistingConnectionName')]
        [PSCustomObject] $Connection = $null
    )
    $result = $::.ApplicationHelper |=> QueryApplications $AppId $objectId $OdataFilter $Name $RawContent $Version $Permissions $cloud $connection

    $displayableResult = if ( $result ) {
        if ( $RawContent.IsPresent ) {
            $result
        } elseif ( $result | gm id ) {
            $result | sort displayname | foreach {
                $::.ApplicationHelper |=> ToDisplayableObject $_
            }
        }
    }

    if ( ! $displayableResult -and ( $AppId -and $ObjectId) ) {
        throw "The specified application could not be found."
    }

    $displayableResult
}
