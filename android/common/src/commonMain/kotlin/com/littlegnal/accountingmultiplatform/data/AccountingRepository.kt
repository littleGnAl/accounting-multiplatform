package com.littlegnal.accountingmultiplatform.data

import com.littlegnal.accountingmultiplatform.AccountingDB
import kotlinx.coroutines.Deferred
import kotlinx.coroutines.async
import kotlinx.coroutines.coroutineScope
import kotlinx.coroutines.launch
import kotlinx.serialization.json.Json
import kotlinx.serialization.json.JsonConfiguration
import kotlinx.serialization.list

class AccountingRepository(private val accountingDB: AccountingDB) {

  private val json: Json by lazy {
    Json(JsonConfiguration.Stable)
  }

  suspend fun queryPreviousAccountingAsync(
    lastDateTimeMilliseconds: Long,
    limit: Long
  ): Deferred<String> = coroutineScope {
      async(runCoroutineDispatcher) {
        val list = accountingDB.accountingDBQueries
            .queryPreviousAccounting(lastDateTimeMilliseconds, limit)
            .executeAsList()
            .map {
              it.toAccountingSerialization()
            }

        json.stringify(AccountingSerialization.serializer().list, list)
      }
    }

  suspend fun insertAccounting(
    id: Long,
    amount: Double,
    createTime: Long,
    tagName: String,
    remarks: String?
  ) = coroutineScope {
    launch(runCoroutineDispatcher) {
      accountingDB.accountingDBQueries.insertAccounting(
          id = id,
          amount = amount,
          createTime = createTime,
          tag_name = tagName,
          remarks = remarks)
    }
  }

  suspend fun deleteAccountingById(id: Long) = coroutineScope {
    launch(runCoroutineDispatcher) {
      accountingDB.accountingDBQueries.deleteAccountingById(id)
    }
  }

  suspend fun getAccountingByIdAsync(id: Long): Deferred<String> = coroutineScope {
    async(runCoroutineDispatcher) {
      val r = accountingDB.accountingDBQueries.getAccountingById(id)
          .executeAsOne()
          .toAccountingSerialization()
      json.stringify(AccountingSerialization.serializer(), r)
    }
  }

  suspend fun totalExpensesOfDayAsync(timeMilliseconds: Long): Deferred<Double> =
    coroutineScope {
      async(runCoroutineDispatcher) {
        accountingDB.accountingDBQueries
            .totalExpensesOfDay(timeMilliseconds, timeMilliseconds)
            .executeAsOne()
      }
    }

  suspend fun getMonthTotalAmountAsync(yearAndMonthList: List<String>): Deferred<String> =
    coroutineScope {
      async(runCoroutineDispatcher) {
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

        json.stringify(GetMonthTotalAmountSerialization.serializer().list, list)
      }
    }
  
  suspend fun getGroupingMonthTotalAmountAsync(yearAndMonth: String): Deferred<String> =
    coroutineScope {
      async(runCoroutineDispatcher) {
        val list = accountingDB.accountingDBQueries
            .getGroupingMonthTotalAmount(yearAndMonth)
            .executeAsList()
            .map {
              it.toGetGroupingMonthTotalAmountSerialization()
            }
        json.stringify(GetGroupingMonthTotalAmountSerialization.serializer().list, list)
      }
    }
}