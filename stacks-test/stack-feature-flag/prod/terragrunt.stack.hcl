unit "db" {
  source = "../units/db"
  path   = "db"

  values = {
    db_name = "myapp-prod-db"
  }
}

unit "backend" {
  source = "../units/backend"
  path   = "backend"

  values = {
    app_name = "myapp-prod-backend"
  }
}

unit "frontend" {
  source = "../units/frontend"
  path   = "frontend"

  values = {
    app_name = "myapp-prod-frontend"
  }
}
