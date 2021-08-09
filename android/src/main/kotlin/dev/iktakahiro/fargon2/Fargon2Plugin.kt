package dev.iktakahiro.fargon2

import android.util.Base64
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

import com.lambdapioneer.argon2kt.Argon2Kt
import com.lambdapioneer.argon2kt.Argon2KtResult
import com.lambdapioneer.argon2kt.Argon2Mode

/** Fargon2Plugin */
class Fargon2Plugin: FlutterPlugin, MethodCallHandler {
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "fargon2")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
      "hash" -> {
        val mode = call.argument<String>("mode").toString()
        val password = call.argument<String>("password").toString()
        val salt = call.argument<String>("salt").toString()
        val hashLength = call.argument<Int>("hash_length")!!.toInt()
        val iterations = call.argument<Int>("iterations")!!.toInt()
        val parallelism = call.argument<Int>("parallelism")!!.toInt()
        val memory = call.argument<Int>("memory_kibibytes")!!.toInt()

        val hashString: String = hash(mode, password, salt, hashLength, iterations, parallelism, memory)
        result.success(hashString)
      }
      else -> {
        result.notImplemented()
      }
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  fun hash(
      @NonNull mode: String,
      @NonNull password: String,
      @NonNull salt: String,
      @NonNull hashLength: Int,
      @NonNull iterations: Int,
      @NonNull parallelism: Int,
      @NonNull memoryKibibytes: Int
  ) : String {
    var argon2mode: Argon2Mode
    when (mode) {
      "argon2i" -> {
        argon2mode = Argon2Mode.ARGON2_I
      }
      "argon2d" -> {
        argon2mode = Argon2Mode.ARGON2_D
      }
      "argon2id" -> {
        argon2mode = Argon2Mode.ARGON2_ID
      }
      else -> {
        argon2mode = Argon2Mode.ARGON2_ID
      }
    }

    val argon2Kt = Argon2Kt()
    val hashResult: Argon2KtResult = argon2Kt.hash(
            mode = argon2mode,
            password = password.toByteArray(),
            salt = salt.toByteArray(),
            tCostInIterations = iterations,
            mCostInKibibyte = memoryKibibytes,
            parallelism = parallelism,
            hashLengthInBytes = hashLength
    )

    return Base64.encodeToString(hashResult.rawHashAsByteArray(), Base64.DEFAULT)
  }
}
