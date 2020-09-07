{{- /*
********************************************************** {COPYRIGHT-TOP} ****
* Licensed Materials - Property of IBM
*
* "Restricted Materials of IBM"
*
*  5737-H89, 5737-H64
*
* © Copyright IBM Corp. 2015, 2018  All Rights Reserved.
*
* US Government Users Restricted Rights - Use, duplication, or
* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
********************************************************* {COPYRIGHT-END} ****

Chart specific kubernetes resource requests and limits
This file defines the various sizes which may be included in a container's spec
*/ -}}

{{- /*
`$chart.resources` will supply a resources definition based on the provided yaml
in the ncodatalayer.sizeData definition. Specify resources in the format:
service:
  size0|1:
      resources:
__Usage:__
resources:
{{ include "ncodatalayer.comp.size.data" (list . "component" "resources") | indent 10 }}
```
  */ -}}

{{- define "ncodatalayer.sizeData" -}}
ncoprimary:
  size0:
    resources:
      limits:
        memory: 2048Mi
        cpu: 2000m
      requests:
        memory: 1024Mi
        cpu: 200m
  size1:
    resources:
      limits:
        memory: 4096Mi
        cpu: 4000m
      requests:
        memory: 1024Mi
        cpu: 200m      
{{- end -}}

{{- define "ncodatalayer.comp.size.data" -}}
{{- $root := (index . 0) -}}
{{- $resName := (index . 1) -}}
{{- $keyName := (index . 2) -}}
{{- $sizeData := fromYaml (include "ncodatalayer.sizeData" .) -}}
{{- $resData := index $sizeData $resName -}}
{{- $resSizeData := index $resData $root.Values.global.environmentSize -}}
{{- $result := index $resSizeData $keyName -}}
{{- toYaml $result | trimSuffix "\n" -}}
{{- end -}}
