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
  GetGroupingMonthTotalAmountSerialization(total, tag_name)