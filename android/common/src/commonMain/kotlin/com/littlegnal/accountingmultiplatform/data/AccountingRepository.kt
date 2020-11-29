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

import com.littlegnal.accountingmultiplatform.AccountingDB
import kotlinx.coroutines.Deferred
import kotlinx.coroutines.async
import kotlinx.coroutines.coroutineScope
import kotlinx.coroutines.launch
import kotlinx.serialization.ExperimentalSerializationApi
import kotlinx.serialization.builtins.ListSerializer
import kotlinx.serialization.json.Json

class AccountingRepository(private val accountingDB: AccountingDB) {

  @ExperimentalSerializationApi
  suspend fun queryPreviousAccountingAsync(
    lastDateTimeMilliseconds: Long,
    limit: Long
  ): Deferred<String> = coroutineScope {
      async(runCoroutineDispatcher) {
        val list = accountingDB.accountingDBQueries
            .queryPreviousAccounting(lastDateTimeMilliseconds, limit)
            .executeAsList()

        Json.encodeToString(ListSerializer(AccountingSerialization), list)
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

  @ExperimentalSerializationApi
  suspend fun getAccountingByIdAsync(id: Long): Deferred<String> = coroutineScope {
    async(runCoroutineDispatcher) {
      val r = accountingDB.accountingDBQueries.getAccountingById(id)
          .executeAsOne()
      Json.encodeToString(AccountingSerialization, r)
    }
  }

  suspend fun totalExpensesOfDayAsync(timeMilliseconds: Long): Deferred<Double> =
    coroutineScope {
      async(runCoroutineDispatcher) {
        accountingDB.accountingDBQueries
            .totalExpensesOfDay(timeMilliseconds, timeMilliseconds)
            .executeAsOne()
            .total!!
      }
    }

  @ExperimentalSerializationApi
  suspend fun getMonthTotalAmountAsync(
    yearAndMonthList: List<String>
  ): Deferred<String> = coroutineScope {
    return@coroutineScope async(runCoroutineDispatcher) {
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

      return@async Json.encodeToString(ListSerializer(GetMonthTotalAmountSerialization), list)
    }
  }

  @ExperimentalSerializationApi
  suspend fun getGroupingMonthTotalAmountAsync(
    yearAndMonth: String
  ): Deferred<String> = coroutineScope {
    return@coroutineScope async(runCoroutineDispatcher) {
      val list = accountingDB.accountingDBQueries
          .getGroupingMonthTotalAmount(yearAndMonth)
          .executeAsList()
      Json.encodeToString(ListSerializer(GetGroupingMonthTotalAmountSerialization), list)
    }
  }
}
