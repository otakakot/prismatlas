table "accounts" {
  schema = schema.public
  column "id" {
    null    = false
    type    = uuid
    default = sql("gen_random_uuid()")
  }
  column "created_at" {
    null    = false
    type    = timestamptz(3)
    default = sql("CURRENT_TIMESTAMP")
  }
  column "updated_at" {
    null    = false
    type    = timestamptz(3)
    default = sql("CURRENT_TIMESTAMP")
  }
  column "deleted" {
    null    = false
    type    = boolean
    default = false
  }
  primary_key {
    columns = [column.id]
  }
}
table "emails" {
  schema = schema.public
  column "id" {
    null    = false
    type    = uuid
    default = sql("gen_random_uuid()")
  }
  column "value" {
    null = false
    type = text
  }
  column "created_at" {
    null    = false
    type    = timestamptz(3)
    default = sql("CURRENT_TIMESTAMP")
  }
  column "updated_at" {
    null    = false
    type    = timestamptz(3)
    default = sql("CURRENT_TIMESTAMP")
  }
  column "account_id" {
    null = false
    type = uuid
  }
  column "deleted" {
    null    = false
    type    = boolean
    default = false
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "emails_account_id_fkey" {
    columns     = [column.account_id]
    ref_columns = [table.accounts.column.id]
    on_update   = CASCADE
    on_delete   = RESTRICT
  }
  index "emails_account_id_idx" {
    columns = [column.account_id]
  }
  index "emails_account_id_key" {
    unique  = true
    columns = [column.account_id]
  }
  index "emails_value_idx" {
    columns = [column.value]
  }
  index "emails_value_key" {
    unique  = true
    columns = [column.value]
  }
  index "emails_value_not_deleted_idx" {
    unique  = true
    columns = [column.value]
    where   = "(NOT deleted)"
  }
}
table "passwords" {
  schema = schema.public
  column "id" {
    null    = false
    type    = uuid
    default = sql("gen_random_uuid()")
  }
  column "value" {
    null = false
    type = bytea
  }
  column "created_at" {
    null    = false
    type    = timestamptz(3)
    default = sql("CURRENT_TIMESTAMP")
  }
  column "updated_at" {
    null    = false
    type    = timestamptz(3)
    default = sql("CURRENT_TIMESTAMP")
  }
  column "account_id" {
    null = false
    type = uuid
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "passwords_account_id_fkey" {
    columns     = [column.account_id]
    ref_columns = [table.accounts.column.id]
    on_update   = CASCADE
    on_delete   = RESTRICT
  }
  index "passwords_account_id_idx" {
    columns = [column.account_id]
  }
  index "passwords_account_id_key" {
    unique  = true
    columns = [column.account_id]
  }
  index "passwords_value_idx" {
    columns = [column.value]
  }
}
table "profiles" {
  schema = schema.public
  column "id" {
    null    = false
    type    = uuid
    default = sql("gen_random_uuid()")
  }
  column "first_name" {
    null = false
    type = text
  }
  column "family_name" {
    null = false
    type = text
  }
  column "created_at" {
    null    = false
    type    = timestamptz(3)
    default = sql("CURRENT_TIMESTAMP")
  }
  column "updated_at" {
    null    = false
    type    = timestamptz(3)
    default = sql("CURRENT_TIMESTAMP")
  }
  column "account_id" {
    null = false
    type = uuid
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "profiles_account_id_fkey" {
    columns     = [column.account_id]
    ref_columns = [table.accounts.column.id]
    on_update   = CASCADE
    on_delete   = RESTRICT
  }
  index "profiles_account_id_idx" {
    columns = [column.account_id]
  }
  index "profiles_account_id_key" {
    unique  = true
    columns = [column.account_id]
  }
}
schema "public" {
  comment = "standard public schema"
}
