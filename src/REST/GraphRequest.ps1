# Copyright 2019, Adam Edwards
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
. (import-script GraphResponse)

ScriptClass GraphRequest {
    $Connection = $null
    $Uri = strict-val [Uri]
    $RelativeUri = strict-val [Uri]
    $Verb = strict-val [String]
    $Body = strict-val [String]
    $Query = $null
    $Headers = $null
    $ClientRequestId = $null

    function __initialize([PSCustomObject] $GraphConnection, [Uri] $uri, $verb = 'GET', $headers = $null, $query = $null, $clientRequestId, [bool] $noRequestId) {
        $uriString = if ( $uri.scheme -ne $null ) {
            $uri.AbsoluteUri
        } else {
            $graphConnection.GraphEndpoint.Graph.tostring() + $uri.originalstring
        }

        if ( ! $noRequestId ) {
            $this.ClientRequestId = if ( $clientRequestId ) {
                [guid] ($clientRequestId)
            } else {
                new-guid
            }
        }

        $uriQueryLength = if ( $uri.Query -ne $null ) { $uri.Query.length } else { 0 }
        $uriNoQuery = new-object Uri ($uriString.substring(0, $uriString.length - $uriQueryLength))

        $this.Connection = $GraphConnection
        $this.RelativeUri = $uri
        $this.Uri = $uriNoQuery
        $this.Verb = $verb

        $queryParams = @($uri.query)
        $queryParams += $query
        $this.Query = __AddQueryParameters $queryParams

        $this.Headers = if ( $headers -ne $null ) {
            $headers
        } else {
            @{'Content-Type'='application/json'}
        }

        if ($graphConnection.Identity) {
            $token = $graphConnection |=> GetToken
            $this.Headers['Authorization'] = $token.CreateAuthorizationHeader()
        }

        if ( $this.ClientRequestId ) {
            $this.Headers['client-request-id'] = $this.ClientRequestId.tostring()
        }
    }

    function Invoke($pageStartIndex = $null, $maxResultCount = $null, $pageSize = $null, $logger) {
        if ( $this.Connection.Status -eq ([GraphConnectionStatus]::Offline) ) {
            throw "Web request cannot proceed -- connection status is set to offline"
        }

        $queryParameters = if ( $this.Query -is [object[]] ) {
            $this.Query
        } else {
            @($this.Query)
        }

        if ($pageStartIndex -ne $null) {
            $queryParameters += (__NewODataParameter 'skip' $pageStartIndex)
        }

        $adjustedPageSize = if ( $pageSize -ne $null -and $maxResultCount -ne $null -and $maxResultCount -lt $pageSize ) {
            $maxResultCount
        } else {
            $pageSize
        }

        if ($adjustedPageSize -ne $null) {
            $queryParameters += (__NewODataParameter 'top' $adjustedPageSize)
        }

        $query = __AddQueryParameters $queryParameters

        if ( $this.ClientRequestId ) {
            write-verbose "Invoking Graph request with request id: '$($this.ClientRequestId)'"
        }

        $response = __InvokeRequest $this.verb $this.uri $query $logger
        new-so GraphResponse $response
    }

    function SetBody($body) {
        $this.body = if ($body -is [string] ) {
            $body
        } else {
            $body | convertto-json -depth 6
        }
    }

    function __InvokeRequest($verb, $uri, $query, $logger) {
        $uriPath = __UriWithQuery $uri $query
        $uri = new-object Uri $uriPath
        $restRequest = new-so RESTRequest $uri $verb $this.headers $this.body $this.Connection.UserAgent
        $logEntry = if ( $logger ) { $logger |=> NewLogEntry $this.Connection $restRequest }
        try {
            $restResponse = $restRequest |=> Invoke -logEntry $logEntry
        } finally {
            if ( $logEntry ) { $logger |=> CommitLogEntry $logEntry }
        }
        $restResponse
    }

    function __AddQueryParameters($parameters) {
        $components = @()

        $parameters | foreach {
            if ( $_ -ne $null ) {

                $normalizedParameter = if ( $_.startswith('?') ) {
                    $_.substring(1, $_.length -1)
                } else {
                    $_
                }

                if ( $normalizedParameter -ne $null -and $normalizedParameter.length -gt 0 ) {
                    $components += $normalizedParameter
                }
            }
        }

        $components -join '&'
    }

    function __UriWithQuery($uri, $query) {
        if ( $query -ne $null -and $query.length -gt 0 ) {
            new-object Uri ($Uri.tostring() + '?' + $query)
        } else {
            new-object Uri $uri.tostring()
        }
    }

    function __NewODataParameter($parameterName, $value) {
        if ( $value -ne $null ) {
            '${0}={1}' -f $parameterName, $value
        } else {
            '${0}' -f $parameterName
        }
    }
}
