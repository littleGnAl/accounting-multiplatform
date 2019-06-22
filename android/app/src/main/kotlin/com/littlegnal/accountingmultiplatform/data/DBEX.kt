package com.littlegnal.accountingmultiplatform.data

import android.content.Context
import com.littlegnal.accountingmultiplatform.AccountingDB
import com.squareup.sqldelight.android.AndroidSqliteDriver

fun Db.getInstance(context: Context): AccountingDB {
  if (!ready) {
    dbSetup(AndroidSqliteDriver(Schema, context, "accounting-db.db"))
  }

  return instance
}