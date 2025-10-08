plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    id("com.google.gms.google-services") // để Firebase hoạt động
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.tag_go_app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    defaultConfig {
        applicationId = "com.example.tag_go_app"
        minSdk = 23
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = "17"
    }

    buildTypes {
        release {
            // TODO: đổi signingConfig sang release nếu có keystore
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // Import Firebase BoM
    implementation(platform("com.google.firebase:firebase-bom:34.1.0"))

    // Firebase Analytics
    implementation("com.google.firebase:firebase-analytics")

    // Firebase Auth
    implementation("com.google.firebase:firebase-auth")

    // Thêm Firebase khác tại đây nếu cần
    // implementation("com.google.firebase:firebase-firestore")
}
