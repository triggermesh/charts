{{/*
Expand the name of the chart.
*/}}
{{- define "knative-operator.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "knative-operator.fullname" -}}
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
{{- define "knative-operator.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "knative-operator.labels" -}}
helm.sh/chart: {{ include "knative-operator.chart" . }}
{{ include "knative-operator.selectorLabels" . }}
{{- if .Chart.AppVersion }}
operator.knative.dev/release: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/part-of: knative-operator
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "knative-operator.selectorLabels" -}}
app.kubernetes.io/name: {{ include "knative-operator.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "knative-operator.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "knative-operator.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Webhook FQDN
*/}}
{{- define "knative-operator.webhook.fullname" -}}
{{- $name := include "knative-operator.fullname" . }}
{{- printf "%s-%s" $name "webhook" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Webhook labels
*/}}
{{- define "knative-operator.webhook.labels" -}}
{{ include "knative-operator.labels" . }}
app.kubernetes.io/component: webhook
{{- end }}

{{/*
Webhook Selector labels
*/}}
{{- define "knative-operator.webhook.selectorLabels" -}}
{{ include "knative-operator.selectorLabels" . }}
app.kubernetes.io/component: webhook
{{- end }}

{{/*
Create the name of the webhook service account to use
*/}}
{{- define "knative-operator.webhook.serviceAccountName" -}}
{{- if .Values.webhook.serviceAccount.create }}
{{- default (include "knative-operator.webhook.fullname" .) .Values.webhook.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.webhook.serviceAccount.name }}
{{- end }}
{{- end }}
