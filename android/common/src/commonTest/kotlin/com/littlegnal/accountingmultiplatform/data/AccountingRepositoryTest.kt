package com.littlegnal.accountingmultiplatform.data

import com.littlegnal.accountingmultiplatform.AccountingDB
import io.mockk.MockKAnnotations
import io.mockk.every
import io.mockk.impl.annotations.MockK
import kotlin.test.BeforeTest
import kotlin.test.Test
import kotlin.test.assertTrue

class AccountingRepositoryTest {

  @MockK
  private lateinit var accountingDB: AccountingDB

  @MockK
  private lateinit var accountingDBQueries: AccountingDBQueries

  private lateinit var accountingRepository: AccountingRepository

  @BeforeTest
  fun setUp() {
    MockKAnnotations.init(this)

    every { accountingDB.accountingDBQueries }.returns(accountingDBQueries)

    accountingRepository = AccountingRepository(accountingDB)
  }

//  @Test
//  fun closeDb() {
//    closeDriver()
//  }

  @Test
  fun `get accountings with lastDateTimeMilliseconds == 1561202892000`() {
    val expected = "[" +
        "{\"id\":4,\"amount\":90.0,\"createTime\":1561129534254," +
        "\"tag_name\":\"Lunch\",\"remarks\":\"yyyy\"}," +
        "{\"id\":3,\"amount\":20.0,\"createTime\":1561128485499," +
        "\"tag_name\":\"Lunch\",\"remarks\":\"uuuuu\"}," +
        "{\"id\":2,\"amount\":80.0,\"createTime\":1560693874648," +
        "\"tag_name\":\"Breakfast\",\"remarks\":\"ppopopopopo\"}" +
        "]"

//    accountingRepository.insertAccounting(
//        id = 0,
//        amount = 90.0,
//        createTime = 1561129534254,
//        tagName = "Lunch",
//        remarks = "yyyy"
//    )
//    accountingRepository.insertAccounting(
//        id = 0,
//        amount = 20.0,
//        createTime = 1561128485499,
//        tagName = "Lunch",
//        remarks = "uuuuu"
//    )
//    accountingRepository.insertAccounting(
//        id = 0,
//        amount = 80.0,
//        createTime = 1560693874648,
//        tagName = "Breakfast",
//        remarks = "ppopopopopo"
//    )
    val r = accountingRepository.queryPreviousAccounting(
        lastDateTimeMilliseconds = 1561202892000,
        limit = 20)
    assertTrue { expected == r }
  }
}