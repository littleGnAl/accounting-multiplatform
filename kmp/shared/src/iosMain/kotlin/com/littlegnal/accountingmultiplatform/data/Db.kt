/*
 * Copyright (C) 2019 littlegnal
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.littlegnal.accountingmultiplatform.data
import app.cash.sqldelight.db.SqlDriver
import app.cash.sqldelight.driver.native.NativeSqliteDriver
import com.littlegnal.accountingmultiplatform.AccountingDB
import kotlin.concurrent.AtomicReference
import kotlin.native.concurrent.freeze

object Db {
//  private val driverRef = AtomicReference<SqlDriver?>(null)
//  private val dbRef = AtomicReference<AccountingDB?>(null)

  private lateinit var db:  AccountingDB

  internal fun dbSetup(driverFactory: DriverFactory) {
//    val driver = driverFactory.createDriver()
    db = createDatabase(driverFactory)
//    driverRef.value = driver.freeze()
//    dbRef.value = db.freeze()
  }

  internal fun dbClear() {
//    driverRef.value!!.close()
//    dbRef.value = null
//    driverRef.value = null
  }

  fun defaultDriver() {
    Db.dbSetup(DriverFactory())
  }

  val instance: AccountingDB
    get() = db
}

actual class DriverFactory {
  actual fun createDriver(): SqlDriver {
    return NativeSqliteDriver(AccountingDB.Schema, "accounting-db.db")
  }
}
