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

class MainActivity: FlutterActivity() {

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
