package com.littlegnal.accountingmultiplatform.data

class SqlDelightManagerTest {

//  @MockK
//  private lateinit var accountingRepository: AccountingRepository
//
//  private lateinit var sqlDelightManager: SqlDelightManager
//
//  @BeforeTest
//  fun setUp() {
//    MockKAnnotations.init(this)
//    sqlDelightManager = SqlDelightManager(accountingRepository)
//  }
//
//  @Test
//  fun `queryPreviousAccounting with lastDateTimeMilliseconds == 1561202892000`() {
//    val args = mapOf("lastDateTimeMilliseconds" to 1561202892000, "limit" to 20)
//    sqlDelightManager.methodCall("queryPreviousAccounting", args) { }
//    verify(exactly = 1) { accountingRepository.queryPreviousAccounting(
//        lastDateTimeMilliseconds = 1561202892000,
//        limit =  20) }
//  }
//
//  @Test
//  fun insertAccounting() {
//    val args = mapOf(
//        "id" to 0,
//        "amount" to 90.0,
//        "createTime" to 1561202892000,
//        "tagName" to "Lunch",
//        "remarks" to "uuuuu")
//    sqlDelightManager.methodCall("insertAccounting", args) { }
//    verify { accountingRepository.insertAccounting(
//        id = 0,
//        amount = 90.0,
//        createTime = 1561202892000,
//        tagName = "Lunch",
//        remarks = "uuuuu") }
//  }
//
//  @Test
//  fun `deleteAccountingById with id == 10`() {
//    val args = mapOf("id" to 10)
//    sqlDelightManager.methodCall("deleteAccountingById", args) { }
//    verify(exactly = 1) { accountingRepository.deleteAccountingById(10L) }
//  }
//
//  @Test
//  fun `getAccountingById with id == 10`() {
//    val args = mapOf("id" to 10)
//    sqlDelightManager.methodCall("getAccountingById", args) { }
//    verify(exactly = 1) { accountingRepository.getAccountingById(10L) }
//  }
//
//  @Test
//  fun `totalExpensesOfDay with timeMilliseconds == 1561202892000`() {
//    val args = mapOf("timeMilliseconds" to 10)
//    sqlDelightManager.methodCall("totalExpensesOfDay", args) { }
//    verify(exactly = 1) { accountingRepository.totalExpensesOfDay(10) }
//  }
//
//  @Test
//  fun `getMonthTotalAmount with yearAndMonthList == listOf("2019-06", "2019-05")`() {
//    val args = mapOf("yearAndMonthList" to listOf("2019-06", "2019-05"))
//    sqlDelightManager.methodCall("getMonthTotalAmount", args) { }
//    verify(exactly = 1) { accountingRepository.getMonthTotalAmount(listOf("2019-06", "2019-05")) }
//  }
//
//  @Test
//  fun `getGroupingMonthTotalAmount with yearAndMonth == "2019-06"`() {
//    val args = mapOf("yearAndMonth" to "2019-06")
//    sqlDelightManager.methodCall("getGroupingMonthTotalAmount", args) { }
//    verify(exactly = 1) { accountingRepository.getGroupingMonthTotalAmount("2019-06") }
//  }
}