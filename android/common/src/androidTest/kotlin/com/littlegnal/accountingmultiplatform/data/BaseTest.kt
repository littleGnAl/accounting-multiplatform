package com.littlegnal.accountingmultiplatform.data

import com.squareup.sqldelight.sqlite.driver.JdbcSqliteDriver

actual fun getAccountingRepository(): AccountingRepository {
  val driver = JdbcSqliteDriver("accounting-db.db")
  Schema.create(driver)
  Db.dbSetup(driver)
  return AccountingRepository(Db.instance)
}

actual fun closeDriver() {
  Db.dbClear()
}