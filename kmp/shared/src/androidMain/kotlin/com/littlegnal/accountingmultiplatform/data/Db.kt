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

import android.content.Context
import app.cash.sqldelight.db.SqlDriver
import app.cash.sqldelight.driver.android.AndroidSqliteDriver
import com.littlegnal.accountingmultiplatform.AccountingDB


object Db {
//  private var driverRef: SqlDriver? = null
  private var dbRef: AccountingDB? = null

  val ready: Boolean
    get() = dbRef != null

  fun dbSetup(driverFactory: DriverFactory) {
    val db = createDatabase(driverFactory)
//    driverRef = driver
    dbRef = db
  }

  internal fun dbClear() {
//    driverRef?.close()
    dbRef = null
//    driverRef = null
  }

  val instance: AccountingDB
    get() = dbRef!!
}

actual class DriverFactory(private val context: Context) {
  actual fun createDriver(): SqlDriver {
    return AndroidSqliteDriver(AccountingDB.Schema, context, "accounting-db.db")
  }
}
