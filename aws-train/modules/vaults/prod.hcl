storage "file" {
  path    = "./vault/data"
  node_id = "node1"
}

listener "tcp" {
  address     = "0.0.0.0:8200"
  tls_disable = "true"
}

disable_mlock = true

api_addr = "http://127.0.0.1:8200"
cluster_addr = "https://127.0.0.1:8201"
ui = true


/* # export VAULT_ADDR='http://127.0.0.1:8200'
# kill vault if the api adress is already in use
# sudo lsof -i :8200
# sudo kill <PID> */