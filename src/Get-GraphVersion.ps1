# Copyright 2017, Adam Edwards
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

. (import-script RESTRequest)
. (import-script GraphEndpoint)
. (import-script GraphIdentity)
. (import-script Application)
. (import-script GraphConnection)

function Get-GraphVersion {
    [cmdletbinding(positionalbinding=$false)]
    param(
        [parameter(position=0,parametersetname='GetVersions', mandatory=$true)][String] $Version,
        [parameter(parametersetname='GetVersions')][switch] $Json,
        [parameter(parametersetname='ListVersions',mandatory=$true)][switch] $List,
        [parameter(parametersetname='GetVersions')][parameter(parametersetname='ListVersions')][switch] $AADGraph,
        [parameter(parametersetname='GetVersions')][parameter(parametersetname='ListVersions')][GraphCloud] $Cloud = [GraphCloud]::Public,
        [parameter(parametersetname='GetVersions')][parameter(parametersetname='ListVersions')][PSCustomObject] $Connection = $null
    )

    $graphType = if ( $AADGraph.ispresent ) {
        ([GraphType]::AADGraph)
    } else {
        ([GraphType]::MSGraph)
    }

    $graphConnection = if ( $Connection -eq $null ) {
        $::.GraphConnection |=> NewSimpleConnection $graphType $Cloud 'User.Read'
    } else {
        $Connection
    }

    $relativeBase = 'versions'
    $relativeUri = if ( ! $List.ispresent ) {
        $relativeBase, $version -join '/'
    } else {
        $relativeBase
    }

    $versionUri = [Uri]::new($graphConnection.GraphEndpoint.Graph, $relativeUri)

    $graphConnection |=> Connect

    $headers = @{
        'Content-Type'='application/json'
        'Authorization'=$graphConnection.Identity.token.CreateAuthorizationHeader()
    }

    $request = new-so RESTRequest $versionUri GET $headers
    $response = $request |=> Invoke

    if ( $JSON.ispresent ) {
        $response.content
    } else {
        $response.content | convertfrom-json
    }
}
