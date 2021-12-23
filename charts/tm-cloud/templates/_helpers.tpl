{{/*
Expand the name of the chart.
*/}}
{{- define "tm-cloud.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "tm-cloud.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "tm-cloud.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "tm-cloud.labels" -}}
helm.sh/chart: {{ include "tm-cloud.chart" . }}
{{ include "tm-cloud.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "tm-cloud.selectorLabels" -}}
app.kubernetes.io/name: {{ include "tm-cloud.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}


{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "tm-cloud.imagePullSecrets" -}}
{{/*
Helm 2.11 supports the assignment of a value to a variable defined in a different scope,
but Helm 2.9 and 2.10 does not support it, so we need to implement this if-else logic.
Also, we can not use a single if because lazy evaluation is not an option
*/}}

{{- if or .Values.global.image.pullSecrets .Values.global.image.dockercfg }}
imagePullSecrets:
{{- if .Values.global.image.pullSecrets }}
{{- range .Values.global.image.pullSecrets }}
  - name: {{ . }}
{{- end }}
{{- end }}
{{- if .Values.global.image.dockercfg }}
  - name: {{ include "tm-cloud.fullname" . }}-imagepullsecret
{{- end }}
{{- end }}
{{- end }}

{{- define "tm-cloud.keycloak.fullname" -}}
{{- if .Values.keycloak.fullnameOverride }}
{{- .Values.keycloak.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default "keycloak" .Values.keycloak.nameOverride }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Backend Controller FQDN
*/}}
{{- define "tm-cloud.backend-controller.fullname" -}}
{{- $name := include "tm-cloud.fullname" . }}
{{- printf "%s-%s" $name "backend-controller" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Backend Controller labels
*/}}
{{- define "tm-cloud.backend-controller.labels" -}}
{{ include "tm-cloud.labels" . }}
app.kubernetes.io/part-of: backend-controller
{{- end }}

{{/*
Backend Controller Selector labels
*/}}
{{- define "tm-cloud.backend-controller.selectorLabels" -}}
{{ include "tm-cloud.selectorLabels" . }}
app.kubernetes.io/part-of: backend-controller
{{- end }}

{{/*
BridgeCatalogEntries FQDN
*/}}
{{- define "tm-cloud.bridgecatalogentries.fullname" -}}
{{- $name := include "tm-cloud.fullname" . }}
{{- printf "%s-%s" $name "bridgecatalogentries" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
BridgeCatalogEntries labels
*/}}
{{- define "tm-cloud.bridgecatalogentries.labels" -}}
{{ include "tm-cloud.labels" . }}
app.kubernetes.io/part-of: bridges
{{- end }}

{{/*
BridgeCatalogEntries Selector labels
*/}}
{{- define "tm-cloud.bridgecatalogentries.selectorLabels" -}}
{{ include "tm-cloud.selectorLabels" . }}
app.kubernetes.io/part-of: bridges
{{- end }}

{{/*
Frontend FQDN
*/}}
{{- define "tm-cloud.frontend.fullname" -}}
{{- $name := include "tm-cloud.fullname" . }}
{{- printf "%s-%s" $name "frontend" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Frontend labels
*/}}
{{- define "tm-cloud.frontend.labels" -}}
{{ include "tm-cloud.labels" . }}
app.kubernetes.io/part-of: frontend
{{- end }}

{{/*
Frontend Selector labels
*/}}
{{- define "tm-cloud.frontend.selectorLabels" -}}
{{ include "tm-cloud.selectorLabels" . }}
app.kubernetes.io/part-of: frontend
{{- end }}

{{/*
ghBackend FQDN
*/}}
{{- define "tm-cloud.ghbackend.fullname" -}}
{{- $name := include "tm-cloud.fullname" . }}
{{- printf "%s-%s" $name "ghbackend" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
ghBackend Controller labels
*/}}
{{- define "tm-cloud.ghbackend.labels" -}}
{{ include "tm-cloud.labels" . }}
app.kubernetes.io/part-of: ghbackend
{{- end }}

{{/*
ghBackend Controller Selector labels
*/}}
{{- define "tm-cloud.ghbackend.selectorLabels" -}}
{{ include "tm-cloud.selectorLabels" . }}
app.kubernetes.io/part-of: ghbackend
{{- end }}

{{/*
Knative Configs FQDN
*/}}
{{- define "tm-cloud.knative-configs.fullname" -}}
{{- $name := include "tm-cloud.fullname" . }}
{{- printf "%s-%s" $name "knative-configs" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Knative Configs labels
*/}}
{{- define "tm-cloud.knative-configs.labels" -}}
{{ include "tm-cloud.labels" . }}
app.kubernetes.io/part-of: knative-configs
{{- end }}

{{/*
Knative Configs Selector labels
*/}}
{{- define "tm-cloud.knative-configs.selectorLabels" -}}
{{ include "tm-cloud.selectorLabels" . }}
app.kubernetes.io/part-of: knative-configs
{{- end }}

{{/*
TriggerFlow FQDN
*/}}
{{- define "tm-cloud.triggerflow.fullname" -}}
{{- $name := include "tm-cloud.fullname" . }}
{{- printf "%s-%s" $name "triggerflow" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
TriggerFlow labels
*/}}
{{- define "tm-cloud.triggerflow.labels" -}}
{{ include "tm-cloud.labels" . }}
app.kubernetes.io/part-of: triggerflow
{{- end }}

{{/*
TriggerFlow Selector labels
*/}}
{{- define "tm-cloud.triggerflow.selectorLabels" -}}
{{ include "tm-cloud.selectorLabels" . }}
app.kubernetes.io/part-of: triggerflow
{{- end }}

{{/*
Koby FQDN
*/}}
{{- define "tm-cloud.koby.fullname" -}}
{{- $name := include "tm-cloud.fullname" . }}
{{- printf "%s-%s" $name "koby" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Koby labels
*/}}
{{- define "tm-cloud.koby.labels" -}}
{{ include "tm-cloud.labels" . }}
app.kubernetes.io/part-of: koby
{{- end }}

{{/*
Koby Selector labels
*/}}
{{- define "tm-cloud.koby.selectorLabels" -}}
{{ include "tm-cloud.selectorLabels" . }}
app.kubernetes.io/part-of: koby
{{- end }}
