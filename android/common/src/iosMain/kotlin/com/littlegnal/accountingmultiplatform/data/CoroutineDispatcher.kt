package com.littlegnal.accountingmultiplatform.data

import kotlinx.coroutines.CoroutineDispatcher
import kotlinx.coroutines.Runnable
import platform.darwin.dispatch_async
import platform.darwin.dispatch_get_main_queue
import kotlin.coroutines.CoroutineContext

actual val runCoroutineDispatcher: CoroutineContext = NsQueueDispatcher

actual val uiCoroutineDispatcher: CoroutineContext = NsQueueDispatcher

object NsQueueDispatcher : CoroutineDispatcher() {
  override fun dispatch(
    context: CoroutineContext,
    block: Runnable
  ) {
    dispatch_async(dispatch_get_main_queue()) {
      block.run()
    }
  }
}