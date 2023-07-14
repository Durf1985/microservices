{{- define "comment.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name }}
{{- end -}}
{{- define "mongo.fullname" -}}
{{- printf "comment-%s-%s" .Release.Name .Chart.Name }}
{{- end -}}
