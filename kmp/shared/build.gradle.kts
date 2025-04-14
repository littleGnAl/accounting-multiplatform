import org.jetbrains.kotlin.gradle.dsl.JvmTarget

plugins {
    alias(libs.plugins.kotlinMultiplatform)
    alias(libs.plugins.kotlinCocoapods)
    alias(libs.plugins.androidLibrary)
    alias(libs.plugins.sqldelight)
    alias(libs.plugins.kotlinSerialization)
}

sqldelight {
    linkSqlite = true
    databases {
        create("AccountingDB") {
            packageName.set("com.littlegnal.accountingmultiplatform")
        }
    }
}

kotlin {
    androidTarget {
        compilations.all {
            compileTaskProvider.configure {
                compilerOptions {
                    jvmTarget.set(JvmTarget.JVM_1_8)
                }
            }
        }
    }
    iosX64()
    iosArm64()
    iosSimulatorArm64()

    cocoapods {
        summary = "Some description for the Shared Module"
        homepage = "Link to the Shared Module homepage"
        version = "1.0"
        ios.deploymentTarget = "12.0"
        framework {
            baseName = "shared"
            isStatic = true
        }
    }
    
    sourceSets {
        commonMain.dependencies {
            implementation(libs.kotlinx.coroutines)
            implementation(libs.kotlinx.serialization)
        }
        commonTest.dependencies {
            implementation(libs.kotlin.test)
        }

        androidMain.dependencies {
            implementation(libs.sqldelight.android.driver)
        }

        // or iosMain, windowsMain, etc.
        nativeMain.dependencies {
            implementation(libs.sqldelight.native.driver)
            implementation(libs.kotlinx.serialization)
        }

//        jvmMain.dependencies {
//            implementation(libs.sqldelight.sqlite.driver)
//        }
    }
}

android {
    namespace = "com.littlegnal.accounting_kmp"
    compileSdk = 35
    defaultConfig {
        minSdk = 21
    }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }
}

group = "com.littlegnal"
version = "1.0.0"