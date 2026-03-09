{{/*
Build the scheme from the ingress.tls flag.
*/}}
{{- define "convex.scheme" -}}
{{- if .Values.ingress.tls }}https{{- else }}http{{- end }}
{{- end }}

{{/*
Backend cloud origin (e.g. https://convex-backend.my-tailnet.ts.net)
*/}}
{{- define "convex.backendOrigin" -}}
{{- include "convex.scheme" . }}://{{ (.Values.ingress.backend.origin | default (required "ingress.backend.host must be set" .Values.ingress.backend.host)) }}
{{- end }}

{{/*
Site origin
*/}}
{{- define "convex.siteOrigin" -}}
{{- include "convex.scheme" . }}://{{ (.Values.ingress.site.origin | default (required "ingress.site.host must be set" .Values.ingress.site.host)) }}
{{- end }}

{{/*
Dashboard deployment URL
*/}}
{{- define "convex.dashboardOrigin" -}}
{{- include "convex.scheme" . }}://{{ (.Values.ingress.dashboard.origin | default (required "ingress.dashboard.host must be set" .Values.ingress.dashboard.host)) }}
{{- end }}
