TENANT_ID=e32b856e-0950-47e2-a493-c2e0fa528615
KEYVAULT_NAME=secret-store-cluster

SERVICE_PRINCIPAL_CLIENT_ID=8f1d88f4-91b1-4426-baf3-a54955313cca
SERVICE_PRINCIPAL_CLIENT_SECRET="$(az ad sp create-for-rbac --skip-assignment --name http://secret-store-cluster --query 'password' -otsv)"

kubectl create secret generic secrets-store-creds --from-literal clientid=${SERVICE_PRINCIPAL_CLIENT_ID} --from-literal clientsecret=${SERVICE_PRINCIPAL_CLIENT_SECRET} -n dev


TENANT_ID=e32b856e-0950-47e2-a493-c2e0fa528615
KEYVAULT_NAME=secret-store-cluster

NAME_SPACE=dev

cat <<EOF | kubectl apply -f -
apiVersion: secrets-store.csi.x-k8s.io/v1
kind: SecretProviderClass
metadata:
  name: "${KEYVAULT_NAME}"
  namespace: "${NAME_SPACE}"
spec:
  provider: azure
  parameters:
    usePodIdentity: "false"
    useVMManagedIdentity: "false"
    userAssignedIdentityID: ""
    keyvaultName: "${KEYVAULT_NAME}"
    objects: |
      array:
        - |
          objectName: DBSERVER
          objectType: secret
          objectVersion: "146c48fa86414a78a1ea8b996cccbb13"
        - |
          objectName: DATABASE
          objectType: secret
          objectVersion: "4bdbb9de5c624c20b50f27d0f5b91e0a"
        - |
          objectName: DBUSER
          objectType: secret
          objectVersion: "e7772184d4c64f7d9d2659c50d5a7808"
        - |
          objectName: DBPASSWORD
          objectType: secret
          objectVersion: "8350747346e443528ccbb9f2337b473c"
        - |
          objectName: APIHOST
          objectType: secret
          objectVersion: "3f24c8cd91814fb5af729770c085ba2c"
        - |
          objectName: APIPORT
          objectType: secret
          objectVersion: "b4c619ba1ccd406da2b957a57ee7bbde"
        - |
          objectName: APIPROTO
          objectType: secret
          objectVersion: "32f9848316cb463fb2c6b398fca99e6e"
    tenantID: "${TENANT_ID}"
  secretObjects:
  - data:
    - key: database_url
      objectName: DBSERVER
    - key: database
      objectName: DATABASE
    - key: db_user
      objectName: DBUSER
    - key: db_password
      objectName: DBPASSWORD
    - key: api_host
      objectName: APIHOST
    - key: api_port
      objectName: APIPORT
    - key: api_protocol
      objectName: APIPROTO
    secretName: postgre-secret
    type: Opaque
EOF

######## verify
cat <<EOF | kubectl apply -f -
kind: Pod
apiVersion: v1
metadata:
  name: busybox-secrets-store-inline
  namespace: "${NAME_SPACE}"
spec:
  containers:
  - name: busybox
    image: registry.k8s.io/e2e-test-images/busybox:1.29-4
    command:
      - "/bin/sleep"
      - "10000"
    volumeMounts:
    - name: secrets-store-inline
      mountPath: "/mnt/secrets-store"
      readOnly: true
    env:
    - name: DbSettings__Server
      valueFrom:
        secretKeyRef:
          name: postgre-secret
          key: database_url
    - name: DbSettings__Database
      valueFrom:
        secretKeyRef:
          name: postgre-secret
          key: database
    - name: DbSettings__UserId
      valueFrom:
        secretKeyRef:
          name: postgre-secret
          key: db_user
    - name: DbSettings__Password
      valueFrom:
        secretKeyRef:
          name: postgre-secret
          key: db_password
    - name: Api__Protocol
      valueFrom:
        secretKeyRef:
          name: postgre-secret
          key: api_protocol
    - name: Api__Host
      valueFrom:
        secretKeyRef:
          name: postgre-secret
          key: api_host
    - name: Api__Port
      valueFrom:
        secretKeyRef:
          name: postgre-secret
          key: api_port
  volumes:
    - name: secrets-store-inline
      csi:
        driver: secrets-store.csi.k8s.io
        readOnly: true
        volumeAttributes:
          secretProviderClass: "${KEYVAULT_NAME}"
        nodePublishSecretRef:         # Only required when using service principal mode
          name: secrets-store-creds   # Only required when using service principal mode
EOF

# kubectl exec busybox-secrets-store-inline -n dev -- ls /mnt/secrets-store/

# kubectl exec busybox-secrets-store-inline -n dev -- cat /mnt/secrets-store/EXAMPLE_SECRET

# kubectl exec busybox-secrets-store-inline -n dev -- printenv DbSettings__Password