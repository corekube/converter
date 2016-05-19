#!/bin/bash

cat > converter-deployment.yaml << EOF
 apiVersion: extensions/v1beta1
 kind: Deployment
 metadata:
   name: converter-deployment
 spec:
   replicas: 1
   template:
     metadata:
       name: converter
       labels:
         app: converter
         env: dev
     spec:
       containers:
         - name: git-sync
           image: ${GIT_SYNC_DOCKER_REPO}:${GIT_SYNC_IMAGE_TAG}
           imagePullPolicy: Always
           volumeMounts:
             - name: converter-nfs-pvc
               mountPath: /srv
           env:
             - name: GIT_SYNC_REPO
               valueFrom:
                 configMapKeyRef:
                   name: git-sync-config
                   key: git.sync.repo
             - name: GIT_SYNC_BRANCH
               valueFrom:
                 configMapKeyRef:
                   name: git-sync-config
                   key: git.sync.branch
             - name: GIT_SYNC_REV
               valueFrom:
                 configMapKeyRef:
                   name: git-sync-config
                   key: git.sync.rev
             - name: GIT_SYNC_DEST
               valueFrom:
                 configMapKeyRef:
                   name: git-sync-config
                   key: git.sync.dest
             - name: GIT_SYNC_WAIT
               valueFrom:
                 configMapKeyRef:
                   name: git-sync-config
                   key: git.sync.wait
         - name: hugo
           image: ${HUGO_DOCKER_REPO}:${HUGO_IMAGE_TAG}
           imagePullPolicy: Always
           args:
             - server
             - --source=\${HUGO_SRC}
             - --theme=\${HUGO_THEME}
             - --baseUrl=\${HUGO_BASE_URL}
             - --destination=\${HUGO_DEST}
             - --appendPort=false
             - --watch
             - --disableLiveReload
           volumeMounts:
             - name: converter-nfs-pvc
               mountPath: /srv
           env:
             - name: HUGO_SRC
               valueFrom:
                 configMapKeyRef:
                   name: hugo-config
                   key: hugo.src
             - name: HUGO_THEME
               valueFrom:
                 configMapKeyRef:
                   name: hugo-config
                   key: hugo.theme
             - name: HUGO_BASE_URL
               valueFrom:
                 configMapKeyRef:
                   name: hugo-config
                   key: hugo.base.url
             - name: HUGO_DEST
               valueFrom:
                 configMapKeyRef:
                   name: hugo-config
                   key: hugo.dest
       volumes:
         - name: converter-nfs-pvc
           persistentVolumeClaim:
             claimName: converter-nfs-pvc
         - name: git-sync-config
           configMap:
             name: git-sync-config
         - name: hugo-config
           configMap:
             name: hugo-config
EOF
