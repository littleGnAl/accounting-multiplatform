package com.littlegnal.accountingmultiplatform.data

import com.littlegnal.accountingmultiplatform.AccountingDB
import com.squareup.sqldelight.db.SqlDriver
import com.squareup.sqldelight.drivers.ios.NativeSqliteDriver
import kotlin.native.concurrent.AtomicReference
import kotlin.native.concurrent.freeze

object Db {
  private val driverRef = AtomicReference<SqlDriver?>(null)
  private val dbRef = AtomicReference<AccountingDB?>(null)

  internal fun dbSetup(driver: SqlDriver) {
    val db = createQueryWrapper(driver)
    driverRef.value = driver.freeze()
    dbRef.value = db.freeze()
  }

  internal fun dbClear() {
    driverRef.value!!.close()
    dbRef.value = null
    driverRef.value = null
  }

  fun defaultDriver() {
    Db.dbSetup(NativeSqliteDriver(Schema, "accounting-db.db"))
  }

  val instance: AccountingDB
    get() = dbRef.value!!
}