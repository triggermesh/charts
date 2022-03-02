{{/*
Expand the name of the chart.
*/}}
{{- define "knative-serving.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "knative-serving.fullname" -}}
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
{{- define "knative-serving.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "knative-serving.labels" -}}
helm.sh/chart: {{ include "knative-serving.chart" . }}
{{ include "knative-serving.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/part-of: knative-serving
{{- end }}

{{/*
Selector labels
*/}}
{{- define "knative-serving.selectorLabels" -}}
app.kubernetes.io/name: {{ include "knative-serving.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "knative-serving.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "knative-serving.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Net-certmanager labels
*/}}
{{- define "knative-serving.net-certmanager.labels" -}}
{{ include "knative-serving.labels" . }}
app.kubernetes.io/component: net-certmanager
serving.knative.dev/release: "v{{ .Chart.AppVersion }}"
networking.knative.dev/certificate-provider: cert-manager
{{- end }}

{{/*
networking-ns-cert labels
*/}}
{{- define "knative-serving.networking-ns-cert.labels" -}}
helm.sh/chart: {{ include "knative-serving.chart" . }}
{{ include "knative-serving.networking-ns-cert.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/part-of: knative-serving
{{- end }}

{{/*
networking-ns-cert Selector labels
*/}}
{{- define "knative-serving.networking-ns-cert.selectorLabels" -}}
app.kubernetes.io/name: networking-ns-cert
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
