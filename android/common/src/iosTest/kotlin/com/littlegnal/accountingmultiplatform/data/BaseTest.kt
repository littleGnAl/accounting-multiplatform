package com.littlegnal.accountingmultiplatform.data

actual fun getAccountingRepository(): AccountingRepository {
  Db.defaultDriver()
  return AccountingRepository(Db.instance)
}

actual fun closeDriver() {
  Db.dbClear()
}
