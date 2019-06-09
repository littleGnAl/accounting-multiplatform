package com.littlegnal.accountingmultiplatform.data

import com.littlegnal.accountingmultiplatform.AccountingDB
import com.squareup.sqldelight.db.SqlDriver

fun createQueryWrapper(driver: SqlDriver): AccountingDB = AccountingDB(driver)

object Schema : SqlDriver.Schema by AccountingDB.Schema {
  override fun create(driver: SqlDriver) {
    AccountingDB.Schema.create(driver)

    createQueryWrapper(driver)
  }
}