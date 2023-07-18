{{- define "post.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name }}
{{- end -}}
{{- define "mongo.fullname" -}}
{{- printf "post-%s-%s" .Release.Name .Chart.Name }}
{{- end -}}
