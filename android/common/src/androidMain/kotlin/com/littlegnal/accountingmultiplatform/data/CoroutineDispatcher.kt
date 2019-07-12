package com.littlegnal.accountingmultiplatform.data

import kotlinx.coroutines.Dispatchers
import kotlin.coroutines.CoroutineContext

actual val runCoroutineDispatcher: CoroutineContext = Dispatchers.IO

actual val uiCoroutineDispatcher: CoroutineContext = Dispatchers.Main