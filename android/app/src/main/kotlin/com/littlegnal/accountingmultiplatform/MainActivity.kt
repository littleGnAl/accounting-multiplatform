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

package com.littlegnal.accountingmultiplatform

import android.os.Bundle
import com.littlegnal.accountingmultiplatform.data.AccountingRepository
import com.littlegnal.accountingmultiplatform.data.Db
import com.littlegnal.accountingmultiplatform.data.SQLDELIGHT_CHANNEL
import com.littlegnal.accountingmultiplatform.data.SqlDelightManager
import com.littlegnal.accountingmultiplatform.data.getInstance
import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {

  private val sqlDelightManager by lazy {
    val accountingRepository = AccountingRepository(Db.getInstance(applicationContext))
    SqlDelightManager(accountingRepository)
  }

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)

    MethodChannel(flutterView, SQLDELIGHT_CHANNEL).setMethodCallHandler { methodCall, result ->
      @Suppress("UNCHECKED_CAST")
      val args = methodCall.arguments as? Map<String, Any> ?: emptyMap()
      sqlDelightManager.methodCall(methodCall.method, args) {
        result.success(it)
      }
    }
  }

  override fun onDestroy() {
    super.onDestroy()

    sqlDelightManager.clear()
  }
}
