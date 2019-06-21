package com.littlegnal.accountingmultiplatform.data

import kotlinx.coroutines.CoroutineDispatcher
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Runnable
import platform.darwin.dispatch_async
import platform.darwin.dispatch_get_main_queue
import platform.darwin.dispatch_queue_t
import kotlin.coroutines.CoroutineContext

actual val runCoroutineDispatcher: CoroutineContext = NsQueueDispatcher(dispatch_get_main_queue())

class NsQueueDispatcher(private val dispatchQueue: dispatch_queue_t) : CoroutineDispatcher() {
  override fun dispatch(
    context: CoroutineContext,
    block: Runnable
  ) {
    dispatch_async(dispatchQueue) {
      block.run()
    }
  }

}