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
import kotlinx.serialization.Serializable

@Serializable
data class AccountingSerialization(
  override val id: Long,
  override val amount: Double,
  override val createTime: Long,
  override val tag_name: String,
  override val remarks: String?
) : Accounting

@Serializable
data class GetMonthTotalAmountSerialization(
  override val total: Double?,
  override val yearMonth: String?
) : GetMonthTotalAmount

@Serializable
data class GetGroupingMonthTotalAmountSerialization(
  override val total: Double,
  override val tag_name: String
) : GetGroupingMonthTotalAmount

fun Accounting.toAccountingSerialization(): AccountingSerialization =
  AccountingSerialization(id, amount, createTime, tag_name, remarks)

fun GetMonthTotalAmount.toGetMonthTotalAmountSerialization(): GetMonthTotalAmountSerialization =
  GetMonthTotalAmountSerialization(total, yearMonth)

fun GetGroupingMonthTotalAmount.toGetGroupingMonthTotalAmountSerialization():
    GetGroupingMonthTotalAmountSerialization =
  GetGroupingMonthTotalAmountSerialization(total ?: 0.0, tag_name)
