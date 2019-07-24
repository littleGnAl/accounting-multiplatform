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

import kotlinx.coroutines.CoroutineExceptionHandler
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Job
import kotlinx.coroutines.launch
import kotlin.coroutines.CoroutineContext

const val SQLDELIGHT_CHANNEL = "com.littlegnal.accountingmultiplatform/sqldelight"

class SqlDelightManager(
  private val accountingRepository: AccountingRepository
) : CoroutineScope {

  private val job = Job()

  private val exceptionHandler = CoroutineExceptionHandler { _, throwable ->
    println(throwable)
  }

  override val coroutineContext: CoroutineContext
    get() = uiCoroutineDispatcher + job + exceptionHandler

  fun clear() {
    job.cancel()
  }

  fun methodCall(method: String, arguments: Map<String, Any>, result: (Any) -> Unit) {
    launch(coroutineContext) {
      when (method) {
        "queryPreviousAccounting" -> {
          val lastDateTimeMilliseconds = arguments["lastDateTimeMilliseconds"] as? Long ?: 0L
          val limit = arguments["limit"] as? Int ?: 0
          val r = accountingRepository.queryPreviousAccountingAsync(
              lastDateTimeMilliseconds,
              limit.toLong()).await()
          result(r)
        }
        "insertAccounting" -> {
          val id: Int = arguments["id"] as? Int ?: 0
          val amount: Double = arguments["amount"] as? Double ?: 0.0
          val createTime: Long = arguments["createTime"] as? Long ?: 0L
          val tagName: String = arguments["tagName"] as? String ?: ""
          val remarks: String? = arguments["remarks"] as? String
          accountingRepository.insertAccounting(
              id = id.toLong(),
              amount = amount,
              createTime = createTime,
              tagName = tagName,
              remarks = remarks
          )

          result(true)
        }
        "deleteAccountingById" -> {
          val id: Int = arguments["id"] as? Int ?: 0
          accountingRepository.deleteAccountingById(id.toLong())
          result(true)
        }
        "getAccountingById" -> {
          val id: Int = arguments["id"] as? Int ?: 0
          val r = accountingRepository.getAccountingByIdAsync(id.toLong()).await()
          result(r)
        }
        "totalExpensesOfDay" -> {
          val timeMilliseconds: Int = arguments["timeMilliseconds"] as? Int ?: 0
          val r = accountingRepository.totalExpensesOfDayAsync(timeMilliseconds.toLong()).await()
          result(r)
        }
        "getMonthTotalAmount" -> {
          @Suppress("UNCHECKED_CAST") val yearAndMonthList: List<String> =
            arguments["yearAndMonthList"] as? List<String> ?: emptyList()
          val r = accountingRepository.getMonthTotalAmountAsync(yearAndMonthList).await()
          result(r)
        }
        "getGroupingMonthTotalAmount" -> {
          val yearAndMonth: String = arguments["yearAndMonth"] as? String ?: ""
          val r = accountingRepository.getGroupingMonthTotalAmountAsync(yearAndMonth).await()
          result(r)
        }
      }
    }
  }
}
