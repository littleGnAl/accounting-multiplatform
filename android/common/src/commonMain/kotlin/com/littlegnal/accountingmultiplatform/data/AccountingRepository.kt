package com.littlegnal.accountingmultiplatform.data

import com.littlegnal.accountingmultiplatform.AccountingDB
import kotlinx.serialization.json.Json
import kotlinx.serialization.json.JsonConfiguration
import kotlinx.serialization.list

class AccountingRepository(private val accountingDB: AccountingDB) {

  private val json: Json by lazy {
    Json(JsonConfiguration.Stable)
  }

  fun queryPreviousAccounting(lastDateTimeMilliseconds: Long, limit: Long): String {
    val list = accountingDB.accountingDBQueries
        .queryPreviousAccounting(lastDateTimeMilliseconds, limit)
        .executeAsList()
        .map {
          it.toAccountingSerialization()
        }

    return json.stringify(AccountingSerialization.serializer().list, list)
  }

  fun insertAccounting(
    id: Long,
    amount: Double,
    createTime: Long,
    tagName: String,
    remarks: String?
  ) {
    accountingDB.accountingDBQueries.insertAccounting(
        id = id,
        amount = amount,
        createTime = createTime,
        tag_name = tagName,
        remarks = remarks)
  }

  fun deleteAccountingById(id: Long) {
    accountingDB.accountingDBQueries.deleteAccountingById(id)
  }

  fun getAccountingById(id: Long): String {
    val r = accountingDB.accountingDBQueries.getAccountingById(id)
        .executeAsOne()
        .toAccountingSerialization()
    return json.stringify(AccountingSerialization.serializer(), r)
  }

  fun totalExpensesOfDay(timeMilliseconds: Long): Double {
    return accountingDB.accountingDBQueries
        .totalExpensesOfDay(timeMilliseconds, timeMilliseconds)
        .executeAsOne()
  }

  fun getMonthTotalAmount(yearAndMonthList: List<String>): String {
    val list = mutableListOf<GetMonthTotalAmount>()
        .apply {
          for (yearAndMonth in yearAndMonthList) {
            val r = accountingDB.accountingDBQueries
                .getMonthTotalAmount(yearAndMonth)
                .executeAsOneOrNull()

            if (r?.total != null && r.yearMonth != null) {
              add(r)
            }
          }
        }
        .map {
          it.toGetMonthTotalAmountSerialization()
        }

    return json.stringify(GetMonthTotalAmountSerialization.serializer().list, list)
  }
  
  fun getGroupingMonthTotalAmount(yearAndMonth: String): String {
    val list = accountingDB.accountingDBQueries
        .getGroupingMonthTotalAmount(yearAndMonth)
        .executeAsList()
        .map {
          it.toGetGroupingMonthTotalAmountSerialization()
        }
    return json.stringify(GetGroupingMonthTotalAmountSerialization.serializer().list, list)
  }
}