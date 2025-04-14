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
import com.littlegnal.accountingmultiplatform.data.SQLDELIGHT_CHANNEL
import com.littlegnal.accountingmultiplatform.data.SqlDelightManager
import com.littlegnal.accountingmultiplatform.data.getDBInstance
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {

  private val sqlDelightManager by lazy {
    val accountingRepository = AccountingRepository(getDBInstance(applicationContext))
    SqlDelightManager(accountingRepository)
  }

  override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)

    GeneratedPluginRegistrant.registerWith(flutterEngine)

    MethodChannel(flutterEngine.dartExecutor, SQLDELIGHT_CHANNEL).setMethodCallHandler { methodCall, result ->
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
