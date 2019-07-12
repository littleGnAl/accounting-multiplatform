package com.littlegnal.accountingmultiplatform.data

import kotlin.coroutines.CoroutineContext

expect val runCoroutineDispatcher: CoroutineContext

expect val uiCoroutineDispatcher: CoroutineContext