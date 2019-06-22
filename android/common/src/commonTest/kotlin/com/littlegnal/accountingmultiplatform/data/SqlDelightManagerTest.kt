package com.littlegnal.accountingmultiplatform.data

import io.mockk.MockKAnnotations
import io.mockk.impl.annotations.MockK
import io.mockk.verify
import kotlin.test.BeforeTest
import kotlin.test.Test

class SqlDelightManagerTest {

  @MockK
  private lateinit var accountingRepository: AccountingRepository

  private lateinit var sqlDelightManager: SqlDelightManager

  @BeforeTest
  fun setUp() {
    MockKAnnotations.init(this)
    sqlDelightManager = SqlDelightManager(accountingRepository)
  }

  @Test
  fun `queryPreviousAccounting with lastDateTimeMilliseconds == 1561202892000`() {
    val args = mapOf("lastDateTimeMilliseconds" to 1561202892000, "limit" to 20)
    sqlDelightManager.methodCall("queryPreviousAccounting", args) { }
    verify(exactly = 1) { accountingRepository.queryPreviousAccounting(
        lastDateTimeMilliseconds = 1561202892000,
        limit =  20) }
  }

  @Test
  fun insertAccounting() {
    val args = mapOf(
        "id" to 0,
        "amount" to 90.0,
        "createTime" to 1561202892000,
        "tagName" to "Lunch",
        "remarks" to "uuuuu")
    sqlDelightManager.methodCall("insertAccounting", args) { }
    verify { accountingRepository.insertAccounting(
        id = 0,
        amount = 90.0,
        createTime = 1561202892000,
        tagName = "Lunch",
        remarks = "uuuuu") }
  }

  @Test
  fun deleteAccountingById() {
    val args = mapOf("id" to 10)
    sqlDelightManager.methodCall("deleteAccountingById", args) { }
    verify(exactly = 1) { accountingRepository.deleteAccountingById(10L) }
  }
}