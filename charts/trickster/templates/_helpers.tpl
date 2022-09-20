{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "trickster.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "trickster.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "trickster.chart" -}}
{{- regexReplaceAll "\\W+" (printf "%s-%s" .Chart.Name .Chart.Version) "_" | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* Generate basic labels */}}
{{- define "trickster.labels" }}
app.kubernetes.io/component: trickster-infra
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/name: {{ template "trickster.name" . }}
app.kubernetes.io/part-of: {{ template "trickster.name" . }} 
app.kubernetes.io/version: "{{  regexReplaceAll "\\W+" .Chart.Version "_" }}"
helm.sh/chart: {{ .Chart.Name }}-{{  regexReplaceAll "\\W+" .Chart.Version "_" }}
tricksterproxy.io/version: "{{ .Chart.AppVersion }}"
{{- if .Values.customLabels }}
{{ toYaml .Values.customLabels | indent 4 }}
{{- end }}
{{- end }}

{{/*
Specify default selectors
*/}}
{{- define "trickster.selectors" }}
app.kubernetes.io/name: {{ template "trickster.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
